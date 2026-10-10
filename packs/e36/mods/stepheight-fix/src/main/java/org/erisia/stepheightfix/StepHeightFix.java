package org.erisia.stepheightfix;

import java.lang.invoke.MethodHandle;
import java.lang.invoke.MethodHandles;
import java.lang.invoke.MethodType;
import net.minecraft.entity.Entity;
import net.minecraft.entity.player.EntityPlayerMP;
import net.minecraftforge.common.MinecraftForge;
import net.minecraftforge.event.entity.EntityEvent;
import net.minecraftforge.event.entity.EntityJoinWorldEvent;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.common.event.FMLPreInitializationEvent;
import net.minecraftforge.fml.common.eventhandler.EventPriority;
import net.minecraftforge.fml.common.eventhandler.SubscribeEvent;

/**
 * Vanilla's EntityPlayerMP constructor sets the server-side stepHeight to 1.0. Chibi's VanillaFix mixin
 * (zone.rong.loliasm.vanillafix.bugfixes.mixins.MixinEntityPlayerMP, no config switch) sets it to 0.7 instead.
 * Astral Sorcery's Step Assist adds 0.5 on the server and sends the client (server - 0.4), assuming the 1.0
 * base, so with Chibi the client gets 0.8 and can't step up a block.
 *
 * A new player entity (login, respawn) joins its world right after construction, before any perk tick, so
 * this puts the base back to 1.0 there. Only Chibi's exact 0.7 is touched; any other value is left alone.
 */
@Mod(modid="erisia_stepheight_fix", name="Erisia Step Height Fix", version="1.0.0",
     serverSideOnly=true, acceptableRemoteVersions="*")
public final class StepHeightFix {
    static final float CHIBI_BASE = 0.7f, VANILLA_BASE = 1.0f;
    // The launcher jar's EntityEvent is compiled against notch names (getEntity returns vg), so it can't be
    // called directly from SRG-named code; at runtime it returns net.minecraft.entity.Entity.
    private static final MethodHandle GET_ENTITY;
    static {
        try {
            GET_ENTITY = MethodHandles.publicLookup().findVirtual(EntityEvent.class, "getEntity",
                MethodType.methodType(Entity.class));
        } catch (ReflectiveOperationException e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    @Mod.EventHandler public void preInit(FMLPreInitializationEvent event) {
        MinecraftForge.EVENT_BUS.register(this);
    }

    @SubscribeEvent(priority=EventPriority.HIGHEST)
    public void join(EntityJoinWorldEvent event) throws Throwable {
        Entity entity = (Entity) GET_ENTITY.invoke((EntityEvent) event);
        if (entity instanceof EntityPlayerMP && entity.field_70138_W == CHIBI_BASE) {
            entity.field_70138_W = VANILLA_BASE;
        }
    }
}
