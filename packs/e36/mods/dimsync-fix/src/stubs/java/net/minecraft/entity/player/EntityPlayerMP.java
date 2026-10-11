package net.minecraft.entity.player;

import net.minecraft.network.NetHandlerPlayServer;

/**
 * Compile-only stub; the real class is Minecraft's. field_71135_a is connection, func_71016_p is
 * sendPlayerAbilities, func_71118_n is setPlayerHealthUpdated (lastHealth = -1e8, so health is resent next tick).
 */
public abstract class EntityPlayerMP extends EntityPlayer {
    public NetHandlerPlayServer field_71135_a;
    public void func_71016_p() { throw new AssertionError(); }
    public void func_71118_n() { throw new AssertionError(); }
}
