package org.erisia.savethreading.mixin;

import java.io.File;
import java.io.IOException;
import org.erisia.savethreading.NbtFileWrite;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Coerce;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;

/** write(NBTTagCompound, File): serialise in memory, then one write + rename (see NbtFileWrite). */
@Mixin(targets = "net.minecraft.nbt.CompressedStreamTools", remap = false)
public abstract class CompressedStreamToolsMixin {
    @Inject(method = "func_74795_b(Lnet/minecraft/nbt/NBTTagCompound;Ljava/io/File;)V",
            at = @At("HEAD"), cancellable = true, require = 1)
    private static void erisia$writeBuffered(@Coerce Object compound, File file, CallbackInfo ci) throws IOException {
        if (NbtFileWrite.write(compound, file)) ci.cancel();
    }
}
