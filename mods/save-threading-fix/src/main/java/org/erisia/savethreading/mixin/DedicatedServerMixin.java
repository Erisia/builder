package org.erisia.savethreading.mixin;

import com.llamalad7.mixinextras.injector.wrapmethod.WrapMethod;
import com.llamalad7.mixinextras.injector.wrapoperation.Operation;
import java.util.concurrent.ExecutionException;
import org.spongepowered.asm.mixin.Mixin;

@Mixin(targets = "net.minecraft.server.dedicated.DedicatedServer", remap = false)
public abstract class DedicatedServerMixin {
    @WrapMethod(method = "func_71252_i(Ljava/lang/String;)Ljava/lang/String;", require = 1)
    private String erisia$rconOnServerThread(String command, Operation<String> original) {
        MinecraftServerAccess server = (MinecraftServerAccess) this;
        if (server.erisia$isServerThread()) {
            return original.call(command);
        }
        // Include the shared RConConsoleSource buffer reset and response read in the
        // scheduled operation. Scheduling only executeCommand mixes concurrent replies.
        try {
            return server.erisia$callFromMainThread(() -> original.call(command)).get();
        } catch (InterruptedException interrupted) {
            Thread.currentThread().interrupt();
            throw new IllegalStateException("Interrupted waiting for RCON command on server thread", interrupted);
        } catch (ExecutionException failed) {
            throw new IllegalStateException("RCON command failed on server thread", failed.getCause());
        }
    }
}
