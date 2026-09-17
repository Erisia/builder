package org.erisia.inspect.mixin;

import com.llamalad7.mixinextras.injector.wrapoperation.Operation;
import com.llamalad7.mixinextras.injector.wrapoperation.WrapOperation;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Coerce;
import org.erisia.inspect.Watch;

/** Observes original calls, including exceptions, without changing their arguments or results. */
@Mixin(targets="net.minecraft.world.World", remap=false)
public abstract class WorldUpdates {
    @WrapOperation(method="func_72866_a", at=@At(value="INVOKE", target="Lnet/minecraft/entity/Entity;func_70071_h_()V"), require=0, remap=false)
    private void inspectEntity(@Coerce Object entity, Operation<Void> original) {
        Watch.noteHook(0);
        long start=Watch.begin(entity,false);
        try { original.call(entity); } finally { Watch.end(entity,start); }
    }
    @WrapOperation(method="func_72866_a", at=@At(value="INVOKE", target="Lnet/minecraft/entity/Entity;func_70098_U()V"), require=0, remap=false)
    private void inspectRider(@Coerce Object entity, Operation<Void> original) {
        Watch.noteHook(1);
        long start=Watch.begin(entity,false);
        try { original.call(entity); } finally { Watch.end(entity,start); }
    }
    @WrapOperation(method="func_72939_s", at=@At(value="INVOKE", target="Lnet/minecraft/util/ITickable;func_73660_a()V"), require=0, remap=false)
    private void inspectTile(@Coerce Object tile, Operation<Void> original) {
        Watch.noteHook(2);
        long start=Watch.begin(tile,true);
        try { original.call(tile); } finally { Watch.end(tile,start); }
    }
}
