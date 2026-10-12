package org.erisia.dimsyncfix;

import java.lang.invoke.MethodHandle;
import java.lang.invoke.MethodHandles;
import net.minecraft.entity.ai.attributes.AttributeMap;
import net.minecraft.entity.player.EntityPlayer;
import net.minecraft.entity.player.EntityPlayerMP;
import net.minecraft.network.play.server.SPacketEntityProperties;
import net.minecraftforge.common.MinecraftForge;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.common.event.FMLPreInitializationEvent;
import net.minecraftforge.fml.common.eventhandler.EventPriority;
import net.minecraftforge.fml.common.eventhandler.SubscribeEvent;
import net.minecraftforge.fml.common.gameevent.PlayerEvent;

/**
 * On a dimension change the server sends SPacketRespawn and the client builds a new player entity with default
 * attributes. Forge's PlayerList.transferPlayerToDimension then resends the watched attributes, but NetherPortalFix
 * teleports players through paired portals with its own copy of the old vanilla routine, which doesn't. The client
 * then shows base max health and reach (Spice of Life hearts, Astral Sorcery perks) until relog, while the server
 * keeps the real values.
 *
 * Both routines fire PlayerChangedDimensionEvent last, so this resends the watched attributes, the abilities, and
 * (next tick) health/food from there. On the Forge path that is a harmless duplicate.
 */
@Mod(modid="erisia_dimsync_fix", name="Erisia Dimension Sync Fix", version="1.0.0",
     serverSideOnly=true, acceptableRemoteVersions="*")
public final class DimSyncFix {
    // The launcher jar's PlayerEvent is compiled against notch names (player is an aed), so the field can't be read
    // directly from SRG-named code; at runtime it is net.minecraft.entity.player.EntityPlayer.
    private static final MethodHandle GET_PLAYER;
    static {
        try {
            GET_PLAYER = MethodHandles.publicLookup().findGetter(PlayerEvent.class, "player", EntityPlayer.class);
        } catch (ReflectiveOperationException e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    @Mod.EventHandler public void preInit(FMLPreInitializationEvent event) {
        MinecraftForge.EVENT_BUS.register(this);
    }

    @SubscribeEvent(priority=EventPriority.LOWEST)
    public void changedDimension(PlayerEvent.PlayerChangedDimensionEvent event) throws Throwable {
        EntityPlayer player = (EntityPlayer) GET_PLAYER.invoke((PlayerEvent) event);
        if (!(player instanceof EntityPlayerMP)) return;
        EntityPlayerMP mp = (EntityPlayerMP) player;
        if (mp.field_71135_a == null) return;
        AttributeMap attributes = (AttributeMap) mp.func_110140_aT();
        mp.field_71135_a.func_147359_a(new SPacketEntityProperties(mp.func_145782_y(), attributes.func_111160_c()));
        mp.func_71016_p();
        mp.func_71118_n();
    }
}
