package org.erisia.savethreading.mixin;

import com.llamalad7.mixinextras.injector.wrapmethod.WrapMethod;
import com.llamalad7.mixinextras.injector.wrapoperation.Operation;
import com.llamalad7.mixinextras.injector.wrapoperation.WrapOperation;
import java.io.File;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;
import org.erisia.savethreading.PendingCopy;
import org.erisia.savethreading.SaveFailureLog;
import org.spongepowered.asm.mixin.Final;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.Shadow;
import org.spongepowered.asm.mixin.Unique;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Coerce;

/** SRG names deliberately target the production 1.12.2 runtime; no refmap is needed. */
@Mixin(targets = "net.minecraft.world.chunk.storage.AnvilChunkLoader", remap = false)
public abstract class AnvilChunkLoaderMixin {
    @Shadow @Final private File field_75825_d; // chunkSaveLocation

    @Shadow @Final private Map<?, ?> field_75828_a; // chunksToSave
    @Shadow @Final private Set<?> field_193415_c; // chunksBeingSaved

    // One lock per loader for the queue bookkeeping. It is released during the disk write
    // itself, so a server-thread load or enqueue waits for a map operation, not for storage.
    @Unique private final ReentrantLock erisia$lock = new ReentrantLock();
    @Unique private final Condition erisia$written = erisia$lock.newCondition();
    // Chunks dequeued by writeNextIO whose disk write has not finished. Loads read these
    // instead of the older region copy (MC-119971).
    @Unique private final Map<Object, Object> erisia$inFlight = new ConcurrentHashMap<>();

    // Two consumers (File IO Thread and a flush) must not both pass the nonempty check and
    // then remove the same last entry: the dequeue runs under the lock. Vanilla's order
    // (beingSaved.add, toSave.remove, write, beingSaved.remove) is kept; SaveWait relies on it.
    @WrapMethod(method = "func_75814_c()Z", require = 1)
    private boolean erisia$writeNextIO(Operation<Boolean> original) {
        erisia$lock.lock();
        try {
            return original.call();
        } finally {
            erisia$written.signalAll();
            erisia$lock.unlock();
        }
    }

    // The disk write runs without the lock. During a flush the lock is held twice (flush and
    // writeNextIO), so this unlock leaves it held: flush writes still exclude loads, as before.
    @WrapOperation(method = "func_75814_c()Z", at = @At(value = "INVOKE",
            target = "Lnet/minecraft/world/chunk/storage/AnvilChunkLoader;func_183013_b(Lnet/minecraft/util/math/ChunkPos;Lnet/minecraft/nbt/NBTTagCompound;)V"),
            require = 1)
    private void erisia$unlockedWrite(@Coerce Object self, @Coerce Object pos, @Coerce Object nbt, Operation<Void> original) {
        erisia$inFlight.put(pos, nbt);
        erisia$lock.unlock();
        try {
            original.call(self, pos, nbt);
        } finally {
            erisia$lock.lock();
            erisia$inFlight.remove(pos);
        }
    }

    // flush drains the queue itself, then waits for a chunk the File IO Thread dequeued
    // earlier and is still writing, so a flush never returns before every write finished.
    // Do NOT lock ThreadedFileIOBase.waitForFinish: that waits for the worker to run.
    @WrapMethod(method = "func_75818_b()V", require = 1)
    private void erisia$flush(Operation<Void> original) {
        erisia$lock.lock();
        try {
            original.call();
            while (!field_193415_c.isEmpty()) erisia$written.awaitUninterruptibly();
        } finally {
            erisia$lock.unlock();
        }
    }

    // Vanilla discards an update when chunksBeingSaved contains its position. Waiting for
    // that one older write prevents the loss and preserves write ordering; saves of other
    // chunks do not wait.
    @WrapMethod(method = "func_75824_a(Lnet/minecraft/util/math/ChunkPos;Lnet/minecraft/nbt/NBTTagCompound;)V", require = 1)
    private void erisia$enqueue(@Coerce Object pos, @Coerce Object nbt, Operation<Void> original) {
        erisia$lock.lock();
        try {
            while (field_193415_c.contains(pos)) erisia$written.awaitUninterruptibly();
            original.call(pos, nbt);
        } finally {
            erisia$lock.unlock();
        }
    }

    // Vanilla loads a chunk still queued for saving from the queued compound itself; Load handlers
    // (XU2 adds XU2Generation) and the chunk's shared light arrays would then mutate it mid-write.
    // A chunk being written is loaded from its in-flight compound, never the older region copy.
    @WrapOperation(method = "loadChunk__Async(Lnet/minecraft/world/World;II)[Ljava/lang/Object;",
            at = @At(value = "INVOKE", target = "Ljava/util/Map;get(Ljava/lang/Object;)Ljava/lang/Object;"), require = 1)
    private Object erisia$copyPending(Map<?, ?> pending, Object pos, Operation<Object> original) {
        Object nbt;
        erisia$lock.lock();
        try {
            nbt = original.call(pending, pos);
            if (nbt == null) nbt = erisia$inFlight.get(pos);
        } finally {
            erisia$lock.unlock();
        }
        return PendingCopy.copy(nbt);
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
