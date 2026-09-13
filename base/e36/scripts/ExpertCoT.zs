import mods.extendedcrafting.CombinationCrafting;
import crafttweaker.item.IItemStack;
//ADD RECIPES
recipes.addShaped(<contenttweaker:blockcasing_livingrock>*4,[[<botania:livingrock>,<minecraft:iron_ingot>,<botania:livingrock>],
																[<ore:ingotCopper>,null,<ore:ingotCopper>],
																[<botania:livingrock>,<minecraft:iron_ingot>,<botania:livingrock>]]);//LIVINGROCK CASING

recipes.addShaped(<contenttweaker:blockcasing_livingrock>*4,[[<botania:livingrock>,<ore:ingotCopper>,<botania:livingrock>],
																[<minecraft:iron_ingot>,null,<minecraft:iron_ingot>],
																[<botania:livingrock>,<ore:ingotCopper>,<botania:livingrock>]]);//LIVINGROCK CASING

recipes.addShapeless(<contenttweaker:mixed_brick_block>,[<contenttweaker:mixed_brick>,<contenttweaker:mixed_brick>,<contenttweaker:mixed_brick>,<contenttweaker:mixed_brick>]);//BRICK BLOCK

furnace.addRecipe(<contenttweaker:mixed_brick>, <contenttweaker:mixed_blend>);//BRICK

recipes.addShaped(<contenttweaker:mixed_blend>*4, [[<minecraft:clay_ball>,<forestry:peat>,<minecraft:clay_ball>],
																[<forestry:peat>,<minecraft:dye:15>,<forestry:peat>],
																[<minecraft:clay_ball>,<forestry:peat>,<minecraft:clay_ball>]]);//BLEND

recipes.addShaped(<contenttweaker:blockcasing_bedrock>*4,[[<contenttweaker:bedrock_crystal>,<minecraft:iron_ingot>,<contenttweaker:bedrock_crystal>],
																[<ore:ingotCopper>,null,<ore:ingotCopper>],
																[<contenttweaker:bedrock_crystal>,<minecraft:iron_ingot>,<contenttweaker:bedrock_crystal>]]);//BEDROCK CASING

recipes.addShaped(<contenttweaker:blockcasing_bedrock>*4,[[<contenttweaker:bedrock_crystal>,<ore:ingotCopper>,<contenttweaker:bedrock_crystal>],
																[<minecraft:iron_ingot>,null,<minecraft:iron_ingot>],
																[<contenttweaker:bedrock_crystal>,<ore:ingotCopper>,<contenttweaker:bedrock_crystal>]]);//BEDROCK CASING

recipes.addShapeless(<contenttweaker:bedrock_shard>*4, [<contenttweaker:bedrock_crystal>]);// SHARDS

recipes.addShaped(<contenttweaker:blockcasing_duskstone>*4,[[<contenttweaker:duskstone_ingot>,<ore:ingotSilver>,<contenttweaker:duskstone_ingot>],
																[<ore:ingotLead>,null,<ore:ingotLead>],
																[<contenttweaker:duskstone_ingot>,<ore:ingotSilver>,<contenttweaker:duskstone_ingot>]]);//DUSKSTONE CASING

recipes.addShaped(<contenttweaker:blockcasing_duskstone>*4,[[<contenttweaker:duskstone_ingot>,<ore:ingotLead>,<contenttweaker:duskstone_ingot>],
																[<ore:ingotSilver>,null,<ore:ingotSilver>],
																[<contenttweaker:duskstone_ingot>,<ore:ingotLead>,<contenttweaker:duskstone_ingot>]]);//DUSKSTONE CASING
recipes.addShaped(<contenttweaker:blockcasing_blackquartz>*4,[[<actuallyadditions:item_misc:5>,<contenttweaker:duskstone_ingot>,<actuallyadditions:item_misc:5>],
																[<ore:ingotSilver>,null,<ore:ingotSilver>],
																[<actuallyadditions:item_misc:5>,<contenttweaker:duskstone_ingot>,<actuallyadditions:item_misc:5>]]);//BLACK QUARTZ CASING
recipes.addShaped(<contenttweaker:blockcasing_blackquartz>*4,[[<actuallyadditions:item_misc:5>,<ore:ingotSilver>,<actuallyadditions:item_misc:5>],
																[<contenttweaker:duskstone_ingot>,null,<contenttweaker:duskstone_ingot>],
																[<actuallyadditions:item_misc:5>,<ore:ingotSilver>,<actuallyadditions:item_misc:5>]]);//BLACK QUARTZ CASING
recipes.addShaped(<contenttweaker:blockcasing_steel>*4,[[<ore:ingotSteel>,<ic2:crafting:3>,<ore:ingotSteel>],
																[<contenttweaker:duskstone_ingot>,null,<contenttweaker:duskstone_ingot>],
																[<ore:ingotSteel>,<ic2:crafting:3>,<ore:ingotSteel>]]);//STEEL CASING
recipes.addShaped(<contenttweaker:blockcasing_steel>*4,[[<ore:ingotSteel>,<contenttweaker:duskstone_ingot>,<ore:ingotSteel>],
																[<ic2:crafting:3>,null,<ic2:crafting:3>],
																[<ore:ingotSteel>,<contenttweaker:duskstone_ingot>,<ore:ingotSteel>]]);//STEEL CASING
recipes.addShaped(<contenttweaker:blockcasing_empoweredredsteel>*4,[[<contenttweaker:empowered_steel_ingot>,<ic2:crafting:3>,<contenttweaker:empowered_steel_ingot>],
																[<galacticraftcore:item_basic_moon:1>,null,<galacticraftcore:item_basic_moon:1>],
																[<contenttweaker:empowered_steel_ingot>,<ic2:crafting:3>,<contenttweaker:empowered_steel_ingot>]]);//EMPOWERED RED STEEL CASING
recipes.addShaped(<contenttweaker:blockcasing_empoweredredsteel>*4,[[<contenttweaker:empowered_steel_ingot>,<galacticraftcore:item_basic_moon:1>,<contenttweaker:empowered_steel_ingot>],
																[<ic2:crafting:3>,null,<ic2:crafting:3>],
																[<contenttweaker:empowered_steel_ingot>,<galacticraftcore:item_basic_moon:1>,<contenttweaker:empowered_steel_ingot>]]);//EMPOWERED RED STEEL CASING

recipes.addShaped(<contenttweaker:blockcasing_starmetal>*4,[[<astralsorcery:itemcraftingcomponent:1>,<botania:manaresource:0>,<astralsorcery:itemcraftingcomponent:1>],
																[<astralsorcery:itemcraftingcomponent:0>,null,<astralsorcery:itemcraftingcomponent:0>],
																[<astralsorcery:itemcraftingcomponent:1>,<botania:manaresource:0>,<astralsorcery:itemcraftingcomponent:1>]]);//STARMETAL CASING
recipes.addShaped(<contenttweaker:blockcasing_starmetal>*4,[[<astralsorcery:itemcraftingcomponent:1>,<astralsorcery:itemcraftingcomponent:0>,<astralsorcery:itemcraftingcomponent:1>],
																[<botania:manaresource:0>,null,<botania:manaresource:0>],
																[<astralsorcery:itemcraftingcomponent:1>,<astralsorcery:itemcraftingcomponent:0>,<astralsorcery:itemcraftingcomponent:1>]]);//STARMETAL CASING
recipes.addShaped(<contenttweaker:duplication_core>,[[<ore:ingotSteel>,<minecraft:stained_glass:5>,<ore:ingotSteel>],
																[<minecraft:stained_glass:5>,<ore:circuitBasic>,<minecraft:stained_glass:5>],
																[<ore:ingotSteel>,<minecraft:stained_glass:5>,<ore:ingotSteel>]]);//DUPLICATION CORE
recipes.addShaped(<contenttweaker:blockcasing_empowereddiamatine>*4,[[<actuallyadditions:item_crystal_empowered:2>,<galacticraftplanets:item_basic_mars:5>,<actuallyadditions:item_crystal_empowered:2>],
																[<thermalfoundation:material:162>,null,<thermalfoundation:material:162>],
																[<actuallyadditions:item_crystal_empowered:2>,<galacticraftplanets:item_basic_mars:5>,<actuallyadditions:item_crystal_empowered:2>]]);//EMPOWERED DIAMATINE CASING

recipes.addShaped(<contenttweaker:blockcasing_empowereddiamatine>*4,[[<actuallyadditions:item_crystal_empowered:2>,<thermalfoundation:material:162>,<actuallyadditions:item_crystal_empowered:2>],
																[<galacticraftplanets:item_basic_mars:5>,null,<galacticraftplanets:item_basic_mars:5>],
																[<actuallyadditions:item_crystal_empowered:2>,<thermalfoundation:material:162>,<actuallyadditions:item_crystal_empowered:2>]]);//EMPOWERED DIAMATINE CASING
recipes.addShaped(<contenttweaker:bioenriched_circuit>*4,[[null,<contenttweaker:organic_diode>,null],
																[<contenttweaker:organic_diode>,<ic2:crafting:1>,<contenttweaker:organic_diode>],
																[null,<contenttweaker:organic_diode>,null]]);//BIO-ENRICHED CIRCUIT
recipes.addShaped(<contenttweaker:tool_core>,[[<immersiveengineering:pickaxe_steel>,<minecraft:flint>,<immersiveengineering:shovel_steel>],
																[<minecraft:flint>,<actuallyadditions:item_crystal_empowered:3>,<minecraft:flint>],
																[null,<minecraft:flint>,null]]);//TOOL CORE
recipes.addShaped(<contenttweaker:speed_gear>,[[null,<actuallyadditions:item_crystal_empowered:1>,null],
																[<actuallyadditions:item_crystal_empowered:1>,<jaopca:item_gearcobalt>,<actuallyadditions:item_crystal_empowered:1>],
																[null,<actuallyadditions:item_crystal_empowered:1>,null]]);//SPEED GEAR
recipes.addShaped(<contenttweaker:power_gear>,[[null,<actuallyadditions:item_crystal_empowered:0>,null],
																[<actuallyadditions:item_crystal_empowered:0>,<jaopca:item_gearardite>,<actuallyadditions:item_crystal_empowered:0>],
																[null,<actuallyadditions:item_crystal_empowered:0>,null]]);//POWER GEAR
recipes.addShaped(<contenttweaker:speed_gearbox>,[[<ore:ingotDesh>,<contenttweaker:speed_gear>,<ore:ingotDesh>],
																[<contenttweaker:speed_gear>,<contenttweaker:empowered_silver_ingot>,<contenttweaker:speed_gear>],
																[<ore:ingotDesh>,<contenttweaker:speed_gear>,<ore:ingotDesh>]]);//SPEED GEARBOX
recipes.addShaped(<contenttweaker:power_gearbox>,[[<ore:ingotDesh>,<contenttweaker:power_gear>,<ore:ingotDesh>],
																[<contenttweaker:power_gear>,<contenttweaker:empowered_steel_ingot>,<contenttweaker:power_gear>],
																[<ore:ingotDesh>,<contenttweaker:power_gear>,<ore:ingotDesh>]]);//POWER GEARBOX
recipes.addShaped(<contenttweaker:blockcasing_refinedglowstone>*4,[[<mekanism:ingot:3>,<ore:ingotLumium>,<mekanism:ingot:3>],
																[<ore:ingotSignalum>,null,<ore:ingotSignalum>],
																[<mekanism:ingot:3>,<ore:ingotLumium>,<mekanism:ingot:3>]]);//REFINED GLOWSTONE CASING
recipes.addShaped(<contenttweaker:blockcasing_refinedglowstone>*4,[[<mekanism:ingot:3>,<ore:ingotSignalum>,<mekanism:ingot:3>],
																[<ore:ingotLumium>,null,<ore:ingotLumium>],
																[<mekanism:ingot:3>,<ore:ingotSignalum>,<mekanism:ingot:3>]]);//REFINED GLOWSTONE CASING
recipes.addShaped(<contenttweaker:blockcasing_enderium>*4,[[<ore:ingotEnderium>,<ore:ingotTitanium>,<ore:ingotEnderium>],
																[<ore:ingotSignalum>,null,<ore:ingotSignalum>],
																[<ore:ingotEnderium>,<ore:ingotTitanium>,<ore:ingotEnderium>]]);//ENDERIUM CASING
recipes.addShaped(<contenttweaker:blockcasing_enderium>*4,[[<ore:ingotEnderium>,<ore:ingotSignalum>,<ore:ingotEnderium>],
																[<ore:ingotTitanium>,null,<ore:ingotTitanium>],
																[<ore:ingotEnderium>,<ore:ingotSignalum>,<ore:ingotEnderium>]]);//ENDERIUM CASING
recipes.addShaped(<contenttweaker:blockcasing_awakeneddraconium>*4,[[<ore:ingotDraconiumAwakened>,<ore:ingotRefinedObsidian>,<ore:ingotDraconiumAwakened>],
																[<ore:ingotDraconium>,null,<ore:ingotDraconium>],
																[<ore:ingotDraconiumAwakened>,<ore:ingotRefinedObsidian>,<ore:ingotDraconiumAwakened>]]);//AWAKENED DRACONIUM CASING
recipes.addShaped(<contenttweaker:blockcasing_awakeneddraconium>*4,[[<ore:ingotDraconiumAwakened>,<ore:ingotDraconium>,<ore:ingotDraconiumAwakened>],
																[<ore:ingotRefinedObsidian>,null,<ore:ingotRefinedObsidian>],
																[<ore:ingotDraconiumAwakened>,<ore:ingotDraconium>,<ore:ingotDraconiumAwakened>]]);//AWAKENED DRACONIUM CASING
recipes.addShaped(<contenttweaker:blockcasing_terrasteel>*4,[[<ore:ingotTerrasteel>,<botania:manaresource:8>,<ore:ingotTerrasteel>],
																[<botania:manaresource:23>,null,<botania:manaresource:23>],
																[<ore:ingotTerrasteel>,<botania:manaresource:8>,<ore:ingotTerrasteel>]]);//TERRASTEEL CASING
recipes.addShaped(<contenttweaker:blockcasing_terrasteel>*4,[[<ore:ingotTerrasteel>,<botania:manaresource:23>,<ore:ingotTerrasteel>],
																[<botania:manaresource:8>,null,<botania:manaresource:8>],
																[<ore:ingotTerrasteel>,<botania:manaresource:23>,<ore:ingotTerrasteel>]]);//TERRASTEEL CASING
recipes.addShaped(<contenttweaker:dragon_catalyst>,[[<ore:ingotDraconium>,<mysticalagradditions:stuff:3>,<ore:ingotDraconium>],
																[<mysticalagradditions:stuff:3>,<draconicevolution:draconic_core>,<mysticalagradditions:stuff:3>],
																[<ore:ingotDraconium>,<mysticalagradditions:stuff:3>,<ore:ingotDraconium>]]);//DRAGON CATALYST
recipes.addShaped(<contenttweaker:framed_growth_lens>,[[null,<astralsorcery:blockinfusedwood>,null],
																[<astralsorcery:blockinfusedwood>,<astralsorcery:itemcoloredlens:2>,<astralsorcery:blockinfusedwood>],
																[null,<astralsorcery:blockinfusedwood>,null]]);//FRAMED GROWTH LENS
recipes.addShaped(<contenttweaker:stellar_wrapped_lens>,[[<minecraft:leather>,<astralsorcery:itemcraftingcomponent:1>,<minecraft:leather>],
																[<contenttweaker:star_diamond>,<contenttweaker:framed_growth_lens>,<contenttweaker:star_pearl>],
																[<minecraft:leather>,<astralsorcery:itemcraftingcomponent:1>,<minecraft:leather>]]);//FRAMED GROWTH LENS
recipes.addShaped(<contenttweaker:resonated_plated_growth_lens>*4,[[null,<astralsorcery:itemcraftingcomponent:4>,null],
																[<astralsorcery:itemcraftingcomponent:4>,<contenttweaker:stellar_wrapped_lens>,<astralsorcery:itemcraftingcomponent:4>],
																[null,<astralsorcery:itemcraftingcomponent:4>,null]]);//FRAMED GROWTH LENS

recipes.addShaped(<contenttweaker:gaia_catalyst>,[[<botania:manaresource:7>,<botania:manaresource:23>,<botania:manaresource:7>],
																[<botania:manaresource:8>,<botania:manaresource:14>,<botania:manaresource:8>],
																[<botania:manaresource:7>,<botania:manaresource:23>,<botania:manaresource:7>]]);//GAIA CATALYST

recipes.addShaped(<contenttweaker:wither_catalyst>,[[<minecraft:soul_sand>,<minecraft:skull:1>,<minecraft:soul_sand>],
																[<minecraft:skull:1>,<ore:plateDarkIron>,<minecraft:skull:1>],
																[<minecraft:soul_sand>,<bloodmagic:slate:1>,<minecraft:soul_sand>]]);//WITHER CATALYST

recipes.addShaped(<contenttweaker:circuit_shell>*2,[[<appliedenergistics2:paint_ball:25>,<mekanism:plasticblock:5>,<appliedenergistics2:paint_ball:25>],
																[<mekanism:plasticblock:5>,<mekanism:controlcircuit:3>,<mekanism:plasticblock:5>],
																[<appliedenergistics2:paint_ball:25>,<mekanism:plasticblock:5>,<appliedenergistics2:paint_ball:25>]]);//CIRCUIT SHELL

recipes.addShaped(<contenttweaker:palladium_screw>*2,[[<ore:platePalladium>],
														[<ore:stickPalladium>]]);//PALLADIUM SCREW

recipes.addShaped(<contenttweaker:empowered_plating>*2,[[<contenttweaker:palladium_screw>,<ore:plateDarkIron>,<contenttweaker:palladium_screw>],
																[<ore:plateDarkIron>,<contenttweaker:empowered_copper_ingot>,<ore:plateDarkIron>],
																[<contenttweaker:palladium_screw>,<ore:plateDarkIron>,<contenttweaker:palladium_screw>]]);//EMPOWERED PLATING
				
recipes.addShaped(<contenttweaker:life_infused_cooler>*8,[[<bloodmagic:inscription_tool:2>,<bloodmagic:slate:1>,<bloodmagic:inscription_tool:2>],
																[<bloodmagic:slate:1>,<contenttweaker:bloodshine_ingot>,<bloodmagic:slate:1>],
																[<bloodmagic:component:1>,<bloodmagic:slate:1>,<bloodmagic:component:1>]]);//LIFE INFUSED COOLER

recipes.addShaped(<contenttweaker:double_gearbox>,[[<ore:ingotDesh>,<contenttweaker:double_gear>,<ore:ingotDesh>],
																[<contenttweaker:double_gear>,<ore:ingotRefinedObsidian>,<contenttweaker:double_gear>],
																[<ore:ingotDesh>,<contenttweaker:double_gear>,<ore:ingotDesh>]]);//DOUBLE GEARBOX

recipes.addShaped(<contenttweaker:heating_coil>,[[<ore:plateDenseOsmium>,<ore:plateDenseOsmium>,<ore:plateDenseOsmium>],
																[<ore:rodCarbon>,<ic2:crafting:5>,<ore:rodCarbon>],
																[<ore:rodCarbon>,<nuclearcraft:turbine_dynamo_coil:4>,<ore:rodCarbon>]]);//HEATING COIL



mods.extendedcrafting.TableCrafting.addShaped(0, <contenttweaker:ultimate_magic_block>, [
	[<ore:ingotAstralStarmetal>, <ore:plateAstralStarmetal>, <ore:plateAstralStarmetal>, <contenttweaker:star_diamond>, <astralsorcery:itemcoloredlens:6>, <contenttweaker:star_diamond>, <ore:plateAstralStarmetal>, <ore:plateAstralStarmetal>, <ore:ingotAstralStarmetal>], 
	[<ore:plateAstralStarmetal>, <botania:brewflask>.withTag({brewKey: "clear"}), <astralsorcery:itemusabledust:0>, <bloodmagic:item_demon_crystal>, <ore:elvenPixieDust>, <bloodmagic:item_demon_crystal>, <astralsorcery:itemusabledust:0>, <botania:brewflask>.withTag({brewKey: "clear"}), <ore:plateAstralStarmetal>], 
	[<ore:plateAstralStarmetal>, <ore:gaiaIngot>, <bloodmagic:slate:3>, <ore:elvenDragonstone>, <bloodmagic:sigil_water>, <ore:elvenDragonstone>, <bloodmagic:slate:3>, <ore:gaiaIngot>, <ore:plateAstralStarmetal>], 
	[<contenttweaker:star_pearl>, <bloodmagic:item_demon_crystal>, <ore:elvenDragonstone>, <botania:storage:2>, <contenttweaker:bloodshine_ingot>, <botania:storage:2>, <ore:elvenDragonstone>, <bloodmagic:item_demon_crystal>, <contenttweaker:star_pearl>], 
	[<astralsorcery:itemcoloredlens:6>, <ore:elvenPixieDust>, <bloodmagic:sigil_green_grove>, <contenttweaker:bloodshine_ingot>, <contenttweaker:runeofabsolution>, <contenttweaker:bloodshine_ingot>, <bloodmagic:sigil_air>, <ore:elvenPixieDust>, <astralsorcery:itemcoloredlens:6>], 
	[<contenttweaker:star_pearl>, <bloodmagic:item_demon_crystal>, <ore:elvenDragonstone>, <botania:storage:2>, <contenttweaker:bloodshine_ingot>, <botania:storage:2>, <ore:elvenDragonstone>, <bloodmagic:item_demon_crystal>, <contenttweaker:star_pearl>], 
	[<ore:plateAstralStarmetal>, <ore:gaiaIngot>, <bloodmagic:slate:3>, <ore:elvenDragonstone>, <bloodmagic:sigil_lava>, <ore:elvenDragonstone>, <bloodmagic:slate:3>, <ore:gaiaIngot>, <ore:plateAstralStarmetal>], 
	[<ore:plateAstralStarmetal>, <botania:brewflask>.withTag({brewKey: "clear"}), <astralsorcery:itemusabledust:0>, <bloodmagic:item_demon_crystal>, <ore:elvenPixieDust>, <bloodmagic:item_demon_crystal>, <astralsorcery:itemusabledust:0>, <botania:brewflask>.withTag({brewKey: "clear"}), <ore:plateAstralStarmetal>], 
	[<ore:ingotAstralStarmetal>, <ore:plateAstralStarmetal>, <ore:plateAstralStarmetal>, <contenttweaker:star_diamond>, <astralsorcery:itemcoloredlens:6>, <contenttweaker:star_diamond>, <ore:plateAstralStarmetal>, <ore:plateAstralStarmetal>, <ore:ingotAstralStarmetal>]
]);

mods.extendedcrafting.TableCrafting.addShaped(0, <contenttweaker:ultimate_tech_block>, [
	[<ic2:crafting:4>, <ore:rodDarkIron>, <ore:rodDarkIron>, <ore:rodDarkIron>, <contenttweaker:empowered_silver_ingot>, <ore:rodDarkIron>, <ore:rodDarkIron>, <ore:rodDarkIron>, <ic2:crafting:4>], 
	[<ore:rodDarkIron>, <ore:alloyUltimate>, <ore:gearNickel>, <ore:plateSignalum>, <ore:plateSignalum>, <ore:plateSignalum>, <ore:gearNickel>, <ore:alloyUltimate>, <ore:rodDarkIron>], 
	[<ore:rodDarkIron>, <extraplanets:tier5_items:3>, <thermalfoundation:fertilizer:2>, <ore:ingotRefinedGlowstone>, <ore:circuitUltimate>, <ore:ingotRefinedGlowstone>, <thermalfoundation:fertilizer:2>, <extraplanets:tier5_items:3>, <ore:rodDarkIron>], 
	[<ore:rodDarkIron>, <ore:plateSignalum>, <ore:ingotRefinedGlowstone>, <mekanism:polyethene:2>, <mekanism:polyethene:2>, <mekanism:polyethene:2>, <ore:ingotRefinedGlowstone>, <ore:plateSignalum>, <ore:rodDarkIron>], 
	[<contenttweaker:empowered_silver_ingot>, <ore:plateSignalum>, <ore:circuitUltimate>, <mekanism:polyethene:2>, <mekanism:teleportationcore>, <mekanism:polyethene:2>, <ore:circuitUltimate>, <ore:plateSignalum>, <contenttweaker:empowered_silver_ingot>], 
	[<ore:rodDarkIron>, <ore:plateSignalum>, <ore:ingotRefinedGlowstone>, <mekanism:polyethene:2>, <mekanism:polyethene:2>, <mekanism:polyethene:2>, <ore:ingotRefinedGlowstone>, <ore:plateSignalum>, <ore:rodDarkIron>], 
	[<ore:rodDarkIron>, <extraplanets:tier5_items:3>, <thermalfoundation:fertilizer:2>, <ore:ingotRefinedGlowstone>, <ore:circuitUltimate>, <ore:ingotRefinedGlowstone>, <thermalfoundation:fertilizer:2>, <extraplanets:tier5_items:3>, <ore:rodDarkIron>], 
	[<ore:rodDarkIron>, <ore:alloyUltimate>, <ore:gearNickel>, <ore:plateSignalum>, <ore:plateSignalum>, <ore:plateSignalum>, <ore:gearNickel>, <ore:alloyUltimate>, <ore:rodDarkIron>], 
	[<ic2:crafting:4>, <ore:rodDarkIron>, <ore:rodDarkIron>, <ore:rodDarkIron>, <contenttweaker:empowered_silver_ingot>, <ore:rodDarkIron>, <ore:rodDarkIron>, <ore:rodDarkIron>, <ic2:crafting:4>]
]);

CombinationCrafting.addRecipe(<contenttweaker:inert_infinity_alloy>, 200000, 2000, <extraplanets:tier5_items:5>, [<calculator:redstoneingot>, <thermalfoundation:material:165>, <mekanism:ingot:3>, <botania:manaresource:4>, <contenttweaker:empowered_aluminium_ingot>, <astralsorcery:itemcraftingcomponent:1>, <mysticalagradditions:insanium:2>]);//INERT INFINITY ALLOY

mods.extendedcrafting.TableCrafting.addShaped(0, <contenttweaker:ultra_electromagnet>, [
	[null, null, null, null, null, <ore:itemGoldCable>, <nuclearcraft:fusion_electromagnet_idle>, <ic2:te:37>, <nuclearcraft:accelerator_electromagnet_idle>], 
	[null, null, null, null, <ore:itemGoldCable>, <nuclearcraft:fusion_electromagnet_idle>, <extraplanets:tier8_items:4>, <nuclearcraft:fusion_electromagnet_idle>, <ic2:te:37>], 
	[null, null, null, <ore:itemGoldCable>, <nuclearcraft:fusion_electromagnet_idle>, <extraplanets:tier8_items:4>, <extraplanets:tier8_items:4>, <extraplanets:tier8_items:4>, <nuclearcraft:fusion_electromagnet_idle>], 
	[null, null, <ore:itemGoldCable>, <nuclearcraft:fusion_electromagnet_idle>, <mekanismgenerators:generator:9>, <extraplanets:tier8_items:4>, <extraplanets:tier8_items:4>, <nuclearcraft:fusion_electromagnet_idle>, <ore:itemGoldCable>], 
	[null, <ore:itemGoldCable>, <nuclearcraft:fusion_electromagnet_idle>, <mekanismgenerators:generator:9>, <avaritia:singularity:1>, <mekanismgenerators:generator:9>, <nuclearcraft:fusion_electromagnet_idle>, <ore:itemGoldCable>, null], 
	[<ore:itemGoldCable>, <nuclearcraft:fusion_electromagnet_idle>, <extraplanets:tier8_items:4>, <extraplanets:tier8_items:4>, <mekanismgenerators:generator:9>, <nuclearcraft:fusion_electromagnet_idle>, <ore:itemGoldCable>, null, null], 
	[<nuclearcraft:fusion_electromagnet_idle>, <extraplanets:tier8_items:4>, <extraplanets:tier8_items:4>, <extraplanets:tier8_items:4>, <nuclearcraft:fusion_electromagnet_idle>, <ore:itemGoldCable>, null, null, null], 
	[<ic2:te:37>, <nuclearcraft:fusion_electromagnet_idle>, <extraplanets:tier8_items:4>, <nuclearcraft:fusion_electromagnet_idle>, <ore:itemGoldCable>, null, null, null, null], 
	[<nuclearcraft:accelerator_electromagnet_idle>, <ic2:te:37>, <nuclearcraft:fusion_electromagnet_idle>, <ore:itemGoldCable>, null, null, null, null, null]
]);

recipes.addShaped(<contenttweaker:ultra_electromagnetic_coil>,[[<ore:plateElectrum>,<ore:rodCarbon>,<ore:plateElectrum>],
																[<ore:rodCarbon>,<contenttweaker:ultra_electromagnet>,<ore:rodCarbon>],
																[<ore:plateElectrum>,<ore:rodCarbon>,<ore:plateElectrum>]]);//ULTRA ELECTROMAGNETIC COIL

mods.jei.JEI.addDescription(<contenttweaker:speed_gearbox>,"Makes machines 50% faster and consume 60% more power.","Makes generators produce 50% more energy per tick, but produce 80% of the total power output.");

mods.jei.JEI.addDescription(<contenttweaker:power_gearbox>,"Makes machines consume 60% of the total power, but takes 10% longer per operation.","Makes generators produce 25% less energy per tick, but produce 25% more of the total power output.");

mods.jei.JEI.addDescription(<contenttweaker:double_gearbox>,"Makes machines 30% faster and consume 30% less power.","Makes generators produce 33% more energy per tick, and produce 15% more of the total power output.");

mods.jei.JEI.addDescription(<contenttweaker:singular_torsion_speed_gearbox>,"Makes machines 200% faster and consume 100% more power.","Makes generators produce 100% more energy per tick, but produce 80% of the total power output.");

mods.jei.JEI.addDescription(<contenttweaker:singular_torsion_power_gearbox>,"Makes machines consume 40% of the total power, but takes 15% longer per operation.","Makes generators produce 25% less energy per tick, but produce 50% more of the total power output.");

mods.jei.JEI.addDescription(<contenttweaker:singular_torsion_double_gearbox>,"Makes machines 100% faster and consume 45% less power.","Makes generators produce 50% more energy per tick, and produce 30% more of the total power output.");

mods.jei.JEI.addDescription(<contenttweaker:quantum_synchronized_double_gearbox>,"Makes machines 300% faster and consume 605% less power.","Makes generators produce 75% more energy per tick, and produce 40% more of the total power output.");