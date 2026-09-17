package org.erisia.inspect.mixin;

import com.llamalad7.mixinextras.injector.wrapoperation.Operation;
import com.llamalad7.mixinextras.injector.wrapoperation.WrapOperation;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.Pseudo;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Coerce;
import org.erisia.inspect.Watch;

/** HammerLib replaces World's tile call with a scheduler. Observe only actual updates. */
@Pseudo
@Mixin(targets="com.zeitheron.hammercore.asm.McHooks", remap=false)
public abstract class HammerUpdates {
    @WrapOperation(method="tickTile", at=@At(value="INVOKE", target="Lnet/minecraft/util/ITickable;func_73660_a()V"), require=0, remap=false)
    private static void inspectTile(@Coerce Object tile, Operation<Void> original) {
        Watch.noteHook(2);
        long start=Watch.begin(tile,true);
        try { original.call(tile); } finally { Watch.end(tile,start); }
    }
}
