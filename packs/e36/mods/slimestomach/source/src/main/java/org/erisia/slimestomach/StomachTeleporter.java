package org.erisia.slimestomach;

import net.minecraft.entity.Entity;
import net.minecraft.entity.player.EntityPlayerMP;
import net.minecraft.world.World;
import net.minecraftforge.common.util.ITeleporter;

/** Puts a player at an exact spot, in any dimension, without portals or End platforms. */
public class StomachTeleporter implements ITeleporter {
    private final double x, y, z;

    private StomachTeleporter(double x, double y, double z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    @Override
    public void placeEntity(World world, Entity entity, float yaw) {
        entity.setLocationAndAngles(x, y, z, entity.rotationYaw, entity.rotationPitch);
        entity.motionX = entity.motionY = entity.motionZ = 0;
    }

    public static void teleport(EntityPlayerMP player, int dim, double x, double y, double z) {
        player.dismountRidingEntity();
        player.removePassengers();
        player.fallDistance = 0;
        if (player.dimension != dim) {
            player.server.getPlayerList().transferPlayerToDimension(player, dim, new StomachTeleporter(x, y, z));
        }
        player.connection.setPlayerLocation(x, y, z, player.rotationYaw, player.rotationPitch);
        player.motionX = player.motionY = player.motionZ = 0;
        player.fallDistance = 0;
    }
}
