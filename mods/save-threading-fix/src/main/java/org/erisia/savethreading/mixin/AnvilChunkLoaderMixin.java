package org.erisia.savethreading.mixin;

import com.llamalad7.mixinextras.injector.wrapmethod.WrapMethod;
import com.llamalad7.mixinextras.injector.wrapoperation.Operation;
import com.llamalad7.mixinextras.injector.wrapoperation.WrapOperation;
import java.io.File;
import java.util.Map;
import org.erisia.savethreading.PendingCopy;
import org.erisia.savethreading.SaveFailureLog;
import org.spongepowered.asm.mixin.Final;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.Shadow;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Coerce;

/** SRG names deliberately target the production 1.12.2 runtime; no refmap is needed. */
@Mixin(targets = "net.minecraft.world.chunk.storage.AnvilChunkLoader", remap = false)
public abstract class AnvilChunkLoaderMixin {
    @Shadow @Final private File field_75825_d; // chunkSaveLocation

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

    // Without the lock, a load between dequeue and disk write reads the older region copy (MC-119971).
    @WrapMethod(method = "loadChunk__Async(Lnet/minecraft/world/World;II)[Ljava/lang/Object;", require = 1)
    private Object[] erisia$load(@Coerce Object world, int x, int z, Operation<Object[]> original) {
        synchronized (this) {
            return original.call(world, x, z);
        }
    }

    // Vanilla loads a chunk still queued for saving from the queued compound itself; Load handlers
    // (XU2 adds XU2Generation) and the chunk's shared light arrays would then mutate it mid-write.
    @WrapOperation(method = "loadChunk__Async(Lnet/minecraft/world/World;II)[Ljava/lang/Object;",
            at = @At(value = "INVOKE", target = "Ljava/util/Map;get(Ljava/lang/Object;)Ljava/lang/Object;"), require = 1)
    private Object erisia$copyPending(Map<?, ?> pending, Object pos, Operation<Object> original) {
        return PendingCopy.copy(original.call(pending, pos));
    }

    // Vanilla's "Failed to save chunk" names neither chunk nor dimension; log both, then rethrow.
    @WrapMethod(method = "func_183013_b(Lnet/minecraft/util/math/ChunkPos;Lnet/minecraft/nbt/NBTTagCompound;)V", require = 1)
    private void erisia$writeChunkData(@Coerce Object pos, @Coerce Object nbt, Operation<Void> original) {
        try {
            original.call(pos, nbt);
        } catch (RuntimeException e) {
            SaveFailureLog.log(field_75825_d, pos, nbt, e);
            throw e;
        }
    }
}
