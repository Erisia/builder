package org.erisia.arcrecycle;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import net.minecraft.item.Item;
import net.minecraft.item.ItemStack;
import net.minecraft.util.ResourceLocation;
import net.minecraftforge.common.config.Config;
import net.minecraftforge.fml.common.Loader;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.common.event.FMLLoadCompleteEvent;
import net.minecraftforge.fml.common.event.FMLPostInitializationEvent;
import net.minecraftforge.fml.common.event.FMLServerAboutToStartEvent;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Removes listed items from Immersive Engineering's Arc Furnace recycling.
 *
 * IE generates its recycling recipes at startup from the crafting registry, and CraftTweaker can only remove
 * Arc Furnace recipes by output, which recycling recipes don't have. So this drops them from
 * ArcFurnaceRecipe.recipeList directly, after IE has added them. Uses reflection, so there is no compile-time
 * dependency on IE, and does nothing if IE is absent.
 *
 * Works on both sides. The server is what matters for processing; on a client it also hides the recipes from
 * JEI, which reads the list at load-complete. Clients without it can still join (acceptableRemoteVersions).
 */
@Mod(modid = Tags.MOD_ID, name = Tags.MOD_NAME, version = Tags.VERSION, acceptableRemoteVersions = "*",
        dependencies = "after:immersiveengineering")
public class ArcRecycle {
    public static final Logger LOGGER = LogManager.getLogger(Tags.MOD_NAME);

    @Config(modid = Tags.MOD_ID)
    public static class Cfg {
        @Config.Comment({"Items the Arc Furnace must not recycle: modid:item@meta (meta optional = all metas).",
                "Default: steel (1-3) and aluminium (5-7) scaffolding, which the block duplicators make from RF alone."})
        public static String[] blacklist = {
                "immersiveengineering:metal_decoration1@1", "immersiveengineering:metal_decoration1@2",
                "immersiveengineering:metal_decoration1@3", "immersiveengineering:metal_decoration1@5",
                "immersiveengineering:metal_decoration1@6", "immersiveengineering:metal_decoration1@7",
        };
    }

    /**
     * IE finishes its recycling recipes in its own postInit; ordering after it means the list is already filtered
     * when JEI (client) reads it at load-complete. The later calls are cheap, idempotent safety nets.
     */
    @Mod.EventHandler
    public void postInit(FMLPostInitializationEvent event) {
        filter();
    }

    @Mod.EventHandler
    public void loadComplete(FMLLoadCompleteEvent event) {
        filter();
    }

    @Mod.EventHandler
    public void serverAboutToStart(FMLServerAboutToStartEvent event) {
        filter();
    }

    private static List<ItemStack> blacklistStacks() {
        List<ItemStack> out = new ArrayList<>();
        for (String s : Cfg.blacklist) {
            String[] parts = s.trim().split("@");
            Item item = Item.REGISTRY.getObject(new ResourceLocation(parts[0]));
            if (item == null) {
                LOGGER.warn("Unknown item in blacklist: {}", s);
                continue;
            }
            if (parts.length > 1) {
                out.add(new ItemStack(item, 1, Integer.parseInt(parts[1])));
            } else {
                out.add(new ItemStack(item, 1, net.minecraftforge.oredict.OreDictionary.WILDCARD_VALUE));
            }
        }
        return out;
    }

    static void filter() {
        if (!Loader.isModLoaded("immersiveengineering")) return;
        try {
            Class<?> recipeClass = Class.forName("blusunrize.immersiveengineering.api.crafting.ArcFurnaceRecipe");
            Field listField = recipeClass.getField("recipeList");
            Field typeField = recipeClass.getField("specialRecipeType");
            Method isValidInput = recipeClass.getMethod("isValidInput", ItemStack.class);
            List<?> recipes = (List<?>) listField.get(null);
            List<ItemStack> blacklist = blacklistStacks();
            int removed = 0, recycling = 0;
            for (Iterator<?> it = recipes.iterator(); it.hasNext(); ) {
                Object recipe = it.next();
                if (!"Recycling".equals(typeField.get(recipe))) continue;
                recycling++;
                for (ItemStack stack : blacklist) {
                    if (stackMatches(recipe, isValidInput, stack)) {
                        it.remove();
                        removed++;
                        break;
                    }
                }
            }
            LOGGER.info("Removed {} of {} Arc Furnace recycling recipes", removed, recycling);
        } catch (ReflectiveOperationException | RuntimeException e) {
            LOGGER.error("Could not filter Arc Furnace recycling recipes", e);
        }
    }

    private static boolean stackMatches(Object recipe, Method isValidInput, ItemStack stack)
            throws ReflectiveOperationException {
        if (stack.getMetadata() != net.minecraftforge.oredict.OreDictionary.WILDCARD_VALUE) {
            return (Boolean) isValidInput.invoke(recipe, stack);
        }
        // Wildcard: try every meta the item could plausibly have.
        for (int meta = 0; meta < 16; meta++) {
            if ((Boolean) isValidInput.invoke(recipe, new ItemStack(stack.getItem(), 1, meta))) return true;
        }
        return false;
    }
}
