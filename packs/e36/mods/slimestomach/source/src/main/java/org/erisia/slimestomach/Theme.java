package org.erisia.slimestomach;

import com.google.common.base.Optional;
import java.util.HashMap;
import java.util.Map;
import net.minecraft.block.Block;
import net.minecraft.block.properties.IProperty;
import net.minecraft.block.state.IBlockState;
import net.minecraft.entity.Entity;
import net.minecraft.entity.EntityList;
import net.minecraft.init.Blocks;
import net.minecraft.util.ResourceLocation;
import net.minecraftforge.fluids.Fluid;
import net.minecraftforge.fluids.FluidRegistry;

/** What a stomach is made of, by the kind of slime that swallowed you. See {@link SSConfig#themes}. */
public class Theme {
    public final String entity, wallSpec, lightSpec, juiceName, description;
    public final IBlockState wall, light;
    public final Block juice;

    private Theme(String entity, String wallSpec, String lightSpec, String juiceName, String description) {
        this.entity = entity;
        this.wallSpec = wallSpec;
        this.lightSpec = lightSpec;
        this.juiceName = juiceName;
        this.description = description;
        this.wall = parseState(wallSpec, Blocks.SLIME_BLOCK.getDefaultState());
        this.light = parseState(lightSpec, Blocks.GLOWSTONE.getDefaultState());
        Fluid fluid = FluidRegistry.getFluid(juiceName);
        Block block = fluid == null ? null : fluid.getBlock();
        this.juice = block == null ? Blocks.WATER : block;
    }

    private static final Map<String, Theme> cache = new HashMap<>();

    public static Theme of(String wall, String light, String juice) {
        return cache.computeIfAbsent(wall + "|" + light + "|" + juice, k -> new Theme("", wall, light, juice, "a slime"));
    }

    /** The theme for this entity, or null if it doesn't swallow players. */
    public static Theme forEntity(Entity e) {
        ResourceLocation key = EntityList.getKey(e);
        if (key == null) return null;
        for (String line : SSConfig.themes) {
            String[] f = line.split("\\|");
            if (f.length < 4 || !f[0].trim().equals(key.toString())) continue;
            String desc = f.length > 4 ? f[4].trim() : "a slime";
            return cache.computeIfAbsent(line, k -> new Theme(f[0].trim(), f[1].trim(), f[2].trim(), f[3].trim(), desc));
        }
        return null;
    }

    public boolean isJuice(IBlockState state) {
        Block b = state.getBlock();
        if (b == juice) return true;
        // Vanilla liquids come as a still and a flowing block.
        return state.getMaterial().isLiquid() && state.getMaterial() == juice.getDefaultState().getMaterial();
    }

    public boolean isWall(IBlockState state) {
        return state.getBlock() == wall.getBlock() || state.getBlock() == light.getBlock();
    }

    /** "modid:block" or "modid:block[prop=value,...]". */
    @SuppressWarnings({"unchecked", "rawtypes"})
    static IBlockState parseState(String spec, IBlockState fallback) {
        String name = spec, props = "";
        int bracket = spec.indexOf('[');
        if (bracket >= 0 && spec.endsWith("]")) {
            name = spec.substring(0, bracket);
            props = spec.substring(bracket + 1, spec.length() - 1);
        }
        ResourceLocation rl = new ResourceLocation(name);
        if (!Block.REGISTRY.containsKey(rl)) {
            SlimeStomach.LOGGER.warn("Unknown block {} in theme; using {}", spec, fallback);
            return fallback;
        }
        IBlockState state = Block.REGISTRY.getObject(rl).getDefaultState();
        for (String kv : props.split(",")) {
            if (kv.isEmpty()) continue;
            String[] p = kv.split("=", 2);
            if (p.length != 2) continue;
            boolean found = false;
            for (IProperty prop : state.getPropertyKeys()) {
                if (!prop.getName().equals(p[0].trim())) continue;
                Optional value = prop.parseValue(p[1].trim());
                if (value.isPresent()) {
                    state = state.withProperty(prop, (Comparable) value.get());
                    found = true;
                }
            }
            if (!found) SlimeStomach.LOGGER.warn("Ignoring {} in block spec {}", kv, spec);
        }
        return state;
    }
}
