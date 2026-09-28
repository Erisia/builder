package org.erisia.slimestomach;

import net.minecraftforge.common.config.Config;

@Config(modid = Tags.MOD_ID)
public class SSConfig {
    @Config.Comment("Smallest slime size that swallows players. Natural slimes and magma cubes are 1, 2 or 4.")
    @Config.RangeInt(min = 1)
    public static int minSlimeSize = 4;

    @Config.Comment({"Dimension ID for the stomach dimension, registered by this mod as an empty overworld-type",
            "dimension (so clients don't need the mod). Must not be used by anything else."})
    @Config.RequiresMcRestart
    public static int stomachDimension = 7355;

    @Config.Comment({"Which slimes swallow, and what their stomachs are made of:",
            "entity id | wall block | light block | juice (Forge fluid name) | description.",
            "Blocks may carry properties, e.g. tconstruct:slime_congealed[type=blue]. Pick blocks with some hardness:",
            "vanilla slime blocks break instantly even with mining fatigue. Inside a stomach only digestion hurts,",
            "so lava or magma blocks are just for looks."})
    public static String[] themes = {
            "minecraft:slime | tconstruct:slime_congealed[type=green] | minecraft:glowstone | blueslime | a slime",
            "tconstruct:blueslime | tconstruct:slime_congealed[type=blue] | minecraft:glowstone | blueslime | a blue slime",
            "minecraft:magma_cube | minecraft:magma | minecraft:glowstone | lava | a magma cube",
    };

    @Config.Comment("Ticks between each new layer of gastric juice (stomachs are roughly 4-6 layers deep).")
    @Config.RangeInt(min = 1)
    public static int ticksPerLayer = 100;

    @Config.Comment({"Damage per second while in gastric juice (or anywhere once the stomach is full),",
            "times the number of wall blocks broken."})
    public static float digestDamage = 1.0F;

    @Config.Comment("Chance that a big slime swallows a player when it hurts them.")
    @Config.RangeDouble(min = 0, max = 1)
    public static double swallowChanceOnHit = 1.0 / 6;

    @Config.Comment("Chance for each wall block facing the inside to be glowstone instead of slime.")
    @Config.RangeDouble(min = 0, max = 1)
    public static double glowstoneChance = 0.06;

    @Config.Comment("Mining fatigue amplifier inside a stomach (0 = I, 2 = III; -1 = none).")
    @Config.RangeInt(min = -1, max = 10)
    public static int miningFatigue = 2;

    @Config.Comment("Ticks of invulnerability after getting out of a slime.")
    @Config.RangeInt(min = 0)
    public static int graceTicks = 100;

    @Config.Comment("Digestion damage doubles every this many seconds of digesting (0: never).")
    @Config.RangeInt(min = 0)
    public static int digestDoublingSeconds = 10;

    @Config.Comment("Announce swallowings and rescues to the whole server.")
    public static boolean announce = true;

}
