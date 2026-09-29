package org.erisia.savethreadingtest.mixin;

import org.erisia.savethreadingtest.RaceGate;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfoReturnable;

/** Instrument the actual game method, never a model/reimplementation of its queue. */
@Mixin(targets = "net.minecraft.world.chunk.storage.AnvilChunkLoader", remap = false)
public abstract class AnvilRaceHooks {
    @Inject(method = "func_75814_c()Z", at = @At(value = "INVOKE", target = "Ljava/util/Map;keySet()Ljava/util/Set;"))
    private void afterNonemptyCheck(CallbackInfoReturnable<Boolean> ci) {
        RaceGate.pause(this, "dequeue");
    }

    // Inside the real disk write, where the production lock is released.
    @Inject(method = "func_183013_b(Lnet/minecraft/util/math/ChunkPos;Lnet/minecraft/nbt/NBTTagCompound;)V", at = @At("HEAD"))
    private void beforeDiskWrite(CallbackInfo ci) {
        RaceGate.pause(this, "write");
    }
}
