package org.erisia.savethreading.mixin;

import com.llamalad7.mixinextras.injector.wrapmethod.WrapMethod;
import com.llamalad7.mixinextras.injector.wrapoperation.Operation;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.Coerce;

/** SRG names deliberately target the production 1.12.2 runtime; no refmap is needed. */
@Mixin(targets = "net.minecraft.world.chunk.storage.AnvilChunkLoader", remap = false)
public abstract class AnvilChunkLoaderMixin {
    // Lock through the disk write, not just iterator.next/remove: otherwise flush can
    // return while another consumer is still writing, or older NBT can overwrite newer NBT.
    @WrapMethod(method = "func_75814_c()Z", require = 1)
    private boolean erisia$writeNextIO(Operation<Boolean> original) {
        synchronized (this) {
            return original.call();
        }
    }

    // A flush owns the same reentrant monitor for its entire drain, including the flag.
    // Do NOT lock ThreadedFileIOBase.waitForFinish: that waits for the worker to run.
    @WrapMethod(method = "func_75818_b()V", require = 1)
    private void erisia$flush(Operation<Void> original) {
        synchronized (this) {
            original.call();
        }
    }

    // Vanilla discards an update when chunksBeingSaved contains its position. Waiting
    // for the older write to finish prevents that loss and preserves write ordering.
    @WrapMethod(method = "func_75824_a(Lnet/minecraft/util/math/ChunkPos;Lnet/minecraft/nbt/NBTTagCompound;)V", require = 1)
    private void erisia$enqueue(@Coerce Object pos, @Coerce Object nbt, Operation<Void> original) {
        synchronized (this) {
            original.call(pos, nbt);
        }
    }
}
