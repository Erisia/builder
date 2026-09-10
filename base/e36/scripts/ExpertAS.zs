//RECIPES
//------------------------------------------------------------------------------------------------------------
import mods.astralsorcery.Altar;
//REMOVE RECIPES
mods.astralsorcery.Altar.removeAltarRecipe("astralsorcery:shaped/internal/altar/grindstone");
furnace.remove(<astralsorcery:itemcraftingcomponent:1>, <astralsorcery:blockcustomore:1>);
mods.astralsorcery.Altar.removeAltarRecipe("astralsorcery:shaped/internal/altar/handtelescope");
mods.astralsorcery.Altar.removeAltarRecipe("astralsorcery:shaped/internal/altar/upgrade_tier2");
mods.astralsorcery.Altar.removeAltarRecipe("astralsorcery:shaped/internal/altar/telescope");
mods.astralsorcery.Altar.removeAltarRecipe("astralsorcery:shaped/internal/altar/tool_linking");
mods.astralsorcery.Altar.removeAltarRecipe("astralsorcery:shaped/internal/altar/upgrade_tier3");
mods.astralsorcery.Altar.removeAltarRecipe("astralsorcery:shaped/internal/altar/upgrade_tier4");
mods.astralsorcery.Altar.removeAltarRecipe("astralsorcery:shaped/internal/altar/gateway");
mods.astralsorcery.Altar.removeAltarRecipe("astralsorcery:shaped/internal/altar/wand/vicio");
mods.astralsorcery.Altar.removeAltarRecipe("astralsorcery:shaped/internal/altar/drawingtable");
mods.astralsorcery.Altar.removeAltarRecipe("astralsorcery:shaped/internal/altar/capebase");
mods.astralsorcery.Altar.removeAltarRecipe("astralsorcery:shaped/internal/altar/enchantment_amulet_craft");
mods.astralsorcery.Altar.removeAltarRecipe("astralsorcery:shaped/internal/altar/ritualpedestal");
recipes.remove(<astralsorcery:itemcraftingcomponent:2>);//STARDUST
recipes.remove(<waystones:waystone>);//WAYSTONE
val oreDictEnt = <ore:crystalRock>;
oreDictEnt.add(<astralsorcery:itemrockcrystalsimple>, <astralsorcery:itemtunedrockcrystal>, <astralsorcery:itemcelestialcrystal>,<astralsorcery:itemtunedcelestialcrystal>);
recipes.remove(<astralsorcery:itemenchantmentamulet>);//RESPLENDANT PRISM
//ADD RECIPES
mods.astralsorcery.Altar.addDiscoveryAltarRecipe("astralsorcery:shaped/internal/altar/handtelescope", <astralsorcery:itemhandtelescope>, 100, 100, [null,<botania:manaresource:3>,<astralsorcery:itemcraftingcomponent:3>,
														<botania:manaresource:3>,<botania:manaresource:0>,<botania:manaresource:3>,
														<astralsorcery:itemcraftingcomponent:3>,<botania:manaresource:3>,null]);//LOOKING GLASS
mods.astralsorcery.Altar.addDiscoveryAltarRecipe("astralsorcery:shaped/internal/altar/upgrade_tier2", <astralsorcery:blockaltar:1>, 200, 200, [<astralsorcery:blockmarble:2>,<ore:crystalRock>,<astralsorcery:blockmarble:2>,
														<astralsorcery:blockmarble:4>,<forge:bucketfilled>.withTag({FluidName: "astralsorcery.liquidstarlight", Amount: 1000}),<astralsorcery:blockmarble:4>,
														<astralsorcery:blockmarble:2>,<botania:manaresource:0>,<astralsorcery:blockmarble:2>]);//STARLIGHT CRAFTING ALTAR
mods.astralsorcery.Altar.addDiscoveryAltarRecipe("astralsorcery:shaped/internal/altar/grindstone", <astralsorcery:blockmachine:1>, 100, 100, [null,null,null,
														<astralsorcery:itemcraftingcomponent:1>,<botania:livingrock:0>,<botania:livingwood:1>,
														<botania:manaresource:3>,<botania:manaresource:3>,<botania:livingwood:1>]);//GRINDSTONE
mods.astralsorcery.Altar.addAttunementAltarRecipe("astralsorcery:shaped/internal/altar/telescope", <astralsorcery:blockmachine:0>, 500, 500, [null,<astralsorcery:itemhandtelescope>,null,
														<botania:manaresource:0>,<botania:livingwood:0>,<botania:manaresource:0>,
														<botania:manaresource:3>,<botania:manaresource:3>,<botania:manaresource:3>,
														null,null,null,null]);//TELESCOPE
mods.astralsorcery.Altar.addAttunementAltarRecipe("astralsorcery:shaped/internal/altar/tool_linking", <astralsorcery:itemlinkingtool>, 500, 500, [null,<astralsorcery:itemcraftingcomponent:0>,<botania:storage:0>,
														null,<ore:crystalRock>,<astralsorcery:itemcraftingcomponent:0>,
														<botania:twigwand>,null,null,
														null,null,<botania:manaresource:3>,null]);//LINKING TOOL
mods.astralsorcery.Altar.addAttunementAltarRecipe("astralsorcery:shaped/internal/altar/upgrade_tier3", <astralsorcery:blockaltar:2>, 1000, 1000, [<contenttweaker:star_diamond>,<minecraft:gold_block>,<contenttweaker:star_diamond>,
														<botania:storage:0>,<ore:crystalRock>,<botania:storage:0>,
														<astralsorcery:blockmarble:2>,<astralsorcery:itemcraftingcomponent:1>,<astralsorcery:blockmarble:2>,
														<astralsorcery:itemcraftingcomponent:2>,<astralsorcery:itemcraftingcomponent:2>,<astralsorcery:blockmarble:4>,<astralsorcery:blockmarble:4>]);//CELESTIAL ALTAR
mods.astralsorcery.Altar.addConstellationAltarRecipe("integrationbyparts:shaped/internal/altar/runicaltar", <botania:runealtar>, 1000, 1000, [<botania:livingrock:0>,<botania:livingrock:0>,<botania:livingrock:0>,
														<botania:livingrock:0>,<ore:crystalRock>,<botania:livingrock:0>,
														<botania:livingrock:0>,<botania:storage:3>,<botania:livingrock:0>,
														<astralsorcery:itemcraftingcomponent:1>,<astralsorcery:itemcraftingcomponent:1>,<astralsorcery:itemcraftingcomponent:1>,<astralsorcery:itemcraftingcomponent:1>,
														<botania:manaresource:0>,<botania:manaresource:0>,<botania:manaresource:0>,<botania:manaresource:0>,<botania:manaresource:0>,<botania:manaresource:0>,<botania:manaresource:0>,<botania:manaresource:0>]);//RUNIC ALTAR
mods.astralsorcery.Altar.addConstellationAltarRecipe("astralsorcery:shaped/internal/altar/upgrade_tier4", <astralsorcery:blockaltar:3>, 3000, 500, [<astralsorcery:blockmarble:6>,<astralsorcery:itemcoloredlens:3>,<astralsorcery:blockmarble:6>,
														<astralsorcery:itemcoloredlens:2>,<astralsorcery:itemcelestialcrystal:0>,<astralsorcery:itemcoloredlens:6>,
														<astralsorcery:blockmarble:6>,<astralsorcery:itemcoloredlens:4>,<astralsorcery:blockmarble:6>,
														<astralsorcery:blockmarble:6>,<astralsorcery:blockmarble:6>,<astralsorcery:blockmarble:6>,<astralsorcery:blockmarble:6>,
														<contenttweaker:star_pearl>,<contenttweaker:star_pearl>,<astralsorcery:itemcraftingcomponent:4>,<astralsorcery:itemcraftingcomponent:4>,<astralsorcery:itemcraftingcomponent:4>,<astralsorcery:itemcraftingcomponent:4>,<contenttweaker:star_pearl>,<contenttweaker:star_pearl>]);//IRIDESCENT ALTAR
mods.astralsorcery.Altar.addConstellationAltarRecipe("astralsorcery:shaped/internal/altar/amulet_craft", <astralsorcery:itemenchantmentamulet>, 3000, 500, [<contenttweaker:bloodshine_ingot>,<botania:manaresource:15>,<contenttweaker:bloodshine_ingot>,
														<astralsorcery:itemcraftingcomponent:2>,<astralsorcery:itemshiftingstar>,<astralsorcery:itemcraftingcomponent:2>,
														<bloodmagic:slate:3>,<minecraft:ender_eye>,<bloodmagic:slate:3>,
														null,null,null,null,
														<contenttweaker:star_pearl>,<contenttweaker:star_pearl>,null,null,null,null,<contenttweaker:star_pearl>,<contenttweaker:star_pearl>]);//RESPLENDANT PRISM
mods.astralsorcery.Altar.addTraitAltarRecipe("astralsorcery:shaped/internal/altar/wand/vicio", <astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.vicio"}}), 7000, 1000, [null,<harvestcraft:sugarcookieitem>,null,
														<bloodmagic:sigil_air>,<astralsorcery:itemwand>.withTag({astralsorcery: {}}),<bloodmagic:sigil_air>,
														null,<harvestcraft:sugarcookieitem>,null,
														null,null,null,null,
														<minecraft:feather>,<minecraft:feather>,<astralsorcery:itemcraftingcomponent:4>,<astralsorcery:itemcraftingcomponent:4>,<astralsorcery:itemcraftingcomponent:4>,<astralsorcery:itemcraftingcomponent:4>,<minecraft:feather>,<minecraft:feather>,
														<minecraft:tipped_arrow>.withTag({Potion: "minecraft:strong_swiftness"}),<botania:flighttiara:0>,<botania:flighttiara:0>,<minecraft:tipped_arrow>.withTag({Potion: "minecraft:strong_swiftness"}),
														<xreliquary:phoenix_down>,<xreliquary:phoenix_down>,<xreliquary:phoenix_down>,<xreliquary:phoenix_down>],"astralsorcery.constellation.vicio");//VICIO RESONATING WAND
mods.astralsorcery.Altar.addTraitAltarRecipe("astralsorcery:shaped/internal/altar/gateway", <astralsorcery:blockcelestialgateway>, 5000, 1000, [<astralsorcery:itemusabledust:0>,<contenttweaker:star_diamond>,<astralsorcery:itemusabledust:0>,
														<astralsorcery:itemcoloredlens:5>,<botania:lightrelay:0>,<astralsorcery:itemcoloredlens:5>,
														<astralsorcery:blockmarble:6>,<contenttweaker:blockcasing_starmetal>,<astralsorcery:blockmarble:6>,
														<astralsorcery:itemcraftingcomponent:2>,<astralsorcery:itemcraftingcomponent:2>,<astralsorcery:itemcraftingcomponent:2>,<astralsorcery:itemcraftingcomponent:2>,
														null,null,null,null,null,null,null,null,
														<astralsorcery:itemcelestialcrystal>,null,null,null,<contenttweaker:star_pearl>]);//CELESTIAL GATEWAY
mods.astralsorcery.Altar.addTraitAltarRecipe("astralsorcery:shaped/internal/altar/drawingtable", <astralsorcery:blockmapdrawingtable>, 7000, 1000, [<astralsorcery:itemcraftingcomponent:4>,<botania:elfglass>,<astralsorcery:itemcraftingcomponent:4>,
														<astralsorcery:itemcraftingcomponent:1>,<minecraft:enchanting_table>,<astralsorcery:itemcraftingcomponent:1>,
														<astralsorcery:blockmarble:6>,<astralsorcery:blockmarble:6>,<astralsorcery:blockmarble:6>,
														<botania:pylon:0>,<botania:pylon:0>,<astralsorcery:blockmarble:6>,<astralsorcery:blockmarble:6>,
														null,null,<botania:dreamwood:0>,<botania:dreamwood:0>,<botania:dreamwood:0>,<botania:dreamwood:0>,null,null,
														<botania:manaresource:8>,<botania:manaresource:8>,<botania:manaresource:8>,<botania:manaresource:8>,<contenttweaker:star_pearl>]);//STELLAR REFRACTION TABLE
mods.astralsorcery.Altar.addTraitAltarRecipe("astralsorcery:shaped/internal/altar/capebase", <astralsorcery:itemcape>.withTag({astralsorcery: {}}), 7000, 1000, [<botania:manaresource:8>,<astralsorcery:itemcelestialcrystal>,<botania:manaresource:8>,
														<botania:manaresource:5>,<botania:terrasteelchest>,<botania:manaresource:5>,
														<botania:manaresource:5>,<botania:manaresource:9>,<botania:manaresource:5>,
														<botania:quartz:5>,<botania:quartz:5>,<astralsorcery:itemcraftingcomponent:2>,<astralsorcery:itemcraftingcomponent:2>,
														null,null,<astralsorcery:itemcraftingcomponent:4>,<astralsorcery:itemcraftingcomponent:4>,<astralsorcery:itemcraftingcomponent:2>,<astralsorcery:itemcraftingcomponent:2>,null,null,
														null,<astralsorcery:itemcraftingcomponent:4>,<astralsorcery:itemcraftingcomponent:4>,null,
														<contenttweaker:star_diamond>,<contenttweaker:star_pearl>,<astralsorcery:itemcraftingcomponent:1>,<astralsorcery:itemcraftingcomponent:2>]);//MANTLE OF THE STARS
recipes.addShapeless(<astralsorcery:itemcraftingcomponent:2>,[<jaopca:item_dustsmallastralstarmetal>,<jaopca:item_dustsmallastralstarmetal>,<jaopca:item_dustsmallastralstarmetal>,<jaopca:item_dustsmallastralstarmetal>]);//STARDUST
//ADD RECIPES
mods.astralsorcery.StarlightInfusion.addInfusion(<minecraft:arrow>, <minecraft:tipped_arrow>.withTag({Potion: "minecraft:strong_swiftness"}), false, 0.7, 200);//SWIFTNESS ARROW

mods.astralsorcery.Altar.addConstellationAltarRecipe("integrationbyparts:shaped/internal/altar/ritualpedestal", <astralsorcery:blockritualpedestal>, 3000, 1000, [
            <botania:manaresource:7>, <astralsorcery:blocklens>, <botania:manaresource:7>,
            <ore:blockMarble>, <bloodmagic:ritual_controller>, <ore:blockMarble>,
            <botania:manaresource:7>, <minecraft:nether_star>, <botania:manaresource:7>,
            null, null, <liquid:astralsorcery.liquidstarlight>, <liquid:astralsorcery.liquidstarlight>,
            <ore:blockMarble>, <ore:blockMarble>,
            <ore:ingotGold>, <ore:ingotGold>,
            <ore:ingotGold>, <ore:ingotGold>,
            <ore:blockMarble>, <ore:blockMarble>]);//RITUAL PEDESTAL


//GRINDSTONE

mods.astralsorcery.Grindstone.removeRecipe(<astralsorcery:itemcraftingcomponent:2>);
mods.astralsorcery.Grindstone.removeRecipe(<astralsorcery:itemcraftingcomponent:2>);
mods.astralsorcery.Grindstone.removeRecipe(<ic2:dust:7>);
mods.astralsorcery.Grindstone.removeRecipe(<ic2:dust:8>);
mods.astralsorcery.Grindstone.removeRecipe(<ic2:dust:4>);
mods.astralsorcery.Grindstone.removeRecipe(<ic2:dust:10>);
mods.astralsorcery.Grindstone.removeRecipe(<thermalfoundation:material:69>);
mods.astralsorcery.Grindstone.removeRecipe(<ic2:dust:14>);
mods.astralsorcery.Grindstone.removeRecipe(<ic2:dust:17>);
mods.astralsorcery.Grindstone.removeRecipe(<thermalfoundation:material:68>);
mods.astralsorcery.Grindstone.removeRecipe(<mekanism:dust:2>);

mods.astralsorcery.Grindstone.addRecipe(<astralsorcery:blockcustomore:1>, <jaopca:item_dustsmallastralstarmetal>);//TINY PILE OF STARDUST
mods.astralsorcery.Grindstone.addRecipe(<astralsorcery:itemcraftingcomponent:1>, <astralsorcery:itemcraftingcomponent:2>);//STARDUST
furnace.addRecipe(<jaopca:item_nuggetastralstarmetal>, <astralsorcery:blockcustomore:1>);//STARMETAL NUGGET

mods.astralsorcery.StarlightInfusion.addInfusion(<contenttweaker:omni_ore>, <botania:specialflower>.withTag({type: "orechid"}), false, 0.7, 200);

//INFUSED WOOD, CELESTIAL CRYSTALS, RESONATING GEMS, LIQUID STARLIGHT, STARMETAL INGOTS, LEATHER, STAR PEARLS, STAR DIAMONDS


mods.astralsorcery.Altar.addDiscoveryAltarRecipe("integrationbyparts:shaped/internal/altar/rosaarcana", <botania:specialflower>.withTag({type: "arcanerose"}), 100, 100, [<astralsorcery:itemcraftingcomponent:2>,<actuallyadditions:item_solidified_experience>,<astralsorcery:itemcraftingcomponent:2>,
														<minecraft:wheat_seeds>,<astralsorcery:itemshiftingstar>,<minecraft:wheat_seeds>,
														<astralsorcery:itemcraftingcomponent:2>,<actuallyadditions:item_solidified_experience>,<astralsorcery:itemcraftingcomponent:2>]);//ROSA ARCANA

mods.astralsorcery.Altar.addDiscoveryAltarRecipe("integrationbyparts:shaped/internal/altar/spectrolus", <botania:specialflower>.withTag({type: "spectrolus"}), 100, 100, [<astralsorcery:itemcraftingcomponent:1>,<simplyjetpacks:metaitem:3>,<astralsorcery:itemcraftingcomponent:1>,
														<minecraft:wheat_seeds>,<astralsorcery:itemshiftingstar>,<minecraft:wheat_seeds>,
														<astralsorcery:itemcraftingcomponent:1>,<simplyjetpacks:metaitem:3>,<astralsorcery:itemcraftingcomponent:1>]);//SPECTROLUS 


mods.astralsorcery.Altar.addDiscoveryAltarRecipe("integrationbyparts:shaped/internal/altar/dirtrod", <botania:dirtrod>, 100, 100, [null,<minecraft:dirt>,null,
									null,<botania:manaresource:3>,<minecraft:dirt>,
									<astralsorcery:itemcraftingcomponent:2>,null,null]);//ROD OF THE LANDS

mods.astralsorcery.Altar.addDiscoveryAltarRecipe("integrationbyparts:shaped/internal/altar/waterrod", <botania:waterrod>, 100, 100, [null,<mysticalagriculture:water_essence>,null,
									null,<botania:manaresource:3>,<mysticalagriculture:water_essence>,
									<astralsorcery:itemcraftingcomponent:2>,null,null]);//ROD OF THE SEAS

mods.astralsorcery.Altar.addDiscoveryAltarRecipe("integrationbyparts:shaped/internal/altar/soujournersash", <botania:travelbelt>, 100, 100, [<minecraft:potion>.withTag({Potion: "minecraft:swiftness"}),<minecraft:leather>,null,
									<minecraft:leather>,null,<minecraft:leather>,
									<botania:manaresource:0>,<minecraft:leather>,<minecraft:potion>.withTag({Potion: "minecraft:leaping"})]);//SOUJOURNER'S SASH

mods.astralsorcery.Altar.addDiscoveryAltarRecipe("integrationbyparts:shaped/internal/altar/icependant", <botania:icependant>, 100, 100, [<minecraft:snow>,<botania:manaresource:16>,<minecraft:ice>,
									<botania:manaresource:16>,<astralsorcery:itemcraftingcomponent:1>,<botania:manaresource:16>,
									<minecraft:ice>,<botania:manaresource:16>,<minecraft:snow>]);//SNOWFLAKE PENDANT

mods.astralsorcery.Altar.addDiscoveryAltarRecipe("integrationbyparts:shaped/internal/altar/cirrusamulet", <botania:cloudpendant>, 100, 100, [<chisel:cloud>,<botania:manaresource:16>,null,
									<botania:manaresource:16>,null,<botania:manaresource:16>,
									<botania:manaresource:0>,<botania:manaresource:16>,<chisel:cloud>]);//CIRRUS AMULET