package org.erisia.slimestomach;

import net.minecraft.world.DimensionType;
import net.minecraftforge.common.DimensionManager;
import net.minecraftforge.common.MinecraftForge;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.common.event.FMLPreInitializationEvent;
import net.minecraftforge.fml.common.event.FMLServerStartingEvent;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Right-clicking a big slime swallows you into a slime-block stomach sealed in bedrock, in an empty
 * dimension of its own. Someone else has to kill the slime to get you out. Breaking the stomach
 * wall makes it fill with gastric juice.
 *
 * Server-side only: it registers no blocks or items, so clients don't need it.
 */
@Mod(modid = Tags.MOD_ID, name = Tags.MOD_NAME, version = Tags.VERSION, acceptableRemoteVersions = "*")
public class SlimeStomach {
    public static final Logger LOGGER = LogManager.getLogger(Tags.MOD_NAME);
    /** False if the stomach dimension ID was taken; slimes then leave players alone. */
    public static boolean enabled;

    @Mod.EventHandler
    public void preInit(FMLPreInitializationEvent event) {
        int dim = SSConfig.stomachDimension;
        if (DimensionManager.isDimensionRegistered(dim)) {
            LOGGER.error("Dimension {} is already registered by something else; slimes will not swallow anyone."
                    + " Set another stomachDimension in config/slimestomach.cfg.", dim);
        } else {
            // A vanilla type: Forge tells clients the type by name, and they only know vanilla ones.
            DimensionManager.registerDimension(dim, DimensionType.OVERWORLD);
            enabled = true;
            LOGGER.info("Registered stomach dimension {}", dim);
        }
        MinecraftForge.EVENT_BUS.register(StomachEvents.INSTANCE);
    }

    @Mod.EventHandler
    public void serverStarting(FMLServerStartingEvent event) {
        event.registerServerCommand(new CommandSlimeStomach());
    }
}
