package org.erisia.savethreading.mixin;

import com.google.common.util.concurrent.ListenableFuture;
import java.util.concurrent.Callable;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.gen.Invoker;

@Mixin(targets = "net.minecraft.server.MinecraftServer", remap = false)
public interface MinecraftServerAccess {
    @Invoker("func_152345_ab") boolean erisia$isServerThread();
    @Invoker("func_175586_a") <V> ListenableFuture<V> erisia$callFromMainThread(Callable<V> task);
}
