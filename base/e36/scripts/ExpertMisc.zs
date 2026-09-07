//REMOVE RECIPES
recipes.remove(<fluxnetworks:fluxcore>);//FLUX CORE
recipes.remove(<bigreactors:reactorcasingcores>);//REACTOR CASING CORE
recipes.remove(<bigreactors:reactorcasing:0>);//REACTOR CASING
recipes.remove(<bigreactors:turbinehousingcores>);//TURBINE HOUSING CORE
recipes.remove(<bigreactors:turbinehousing:0>);//TURBINE HOUSING
recipes.remove(<woot:stygianironore>);//STYGIAN IRON ORE
recipes.remove(<extendedcrafting:material:14>);//BASIC COMPONENT
recipes.remove(<extendedcrafting:material:7>);//LUMINESSENCE
recipes.remove(<extendedcrafting:material:8>);//BASIC CATALYST
recipes.remove(<extendedcrafting:material:15>);//ADVANCED COMPONENT
recipes.remove(<extendedcrafting:material:16>);//ELITE COMPONENT
recipes.remove(<extendedcrafting:material:17>);//ULTIMATE COMPONENT
recipes.remove(<extendedcrafting:table_basic>);//BASIC CRAFTING TABLE
recipes.remove(<extendedcrafting:table_advanced>);//ADVANCED CRAFTING TABLE
recipes.remove(<extendedcrafting:table_elite>);//ELITE CRAFTING TABLE
recipes.remove(<extendedcrafting:table_ultimate>);//ULTIMATE CRAFTING TABLE
recipes.remove(<extendedcrafting:crafting_core>);//CRAFTING CORE
recipes.remove(<extendedcrafting:material:9>);//ADVANCED CATALYST
recipes.remove(<extendedcrafting:material:10>);//ELITE CATALYST
recipes.remove(<extendedcrafting:material:11>);//ULTIMATE CATALYST
recipes.remove(<mysticalagriculture:infusion_crystal>);//INFUSION CRYSTAL
recipes.remove(<environmentaltech:litherite_crystal>);//LITHERITE CRYSTAL
recipes.remove(<environmentaltech:connector>);//CONNECTOR
recipes.remove(<environmentaltech:diode>);//DIODE
recipes.remove(<cookingforblockheads:milk_jar>);//MILK JAR
recipes.remove(<solarflux:mirror>);//MIRROR
recipes.remove(<solarflux:solar_panel_1>);//SOLAR PANEL I
recipes.remove(<solarflux:solar_panel_2>);//SOLAR PANEL II
recipes.remove(<solarflux:solar_panel_3>);//SOLAR PANEL II
recipes.remove(<solarflux:solar_panel_4>);//SOLAR PANEL IV
recipes.remove(<solarflux:solar_panel_5>);//SOLAR PANEL V
recipes.remove(<solarflux:solar_panel_6>);//SOLAR PANEL VI
recipes.remove(<solarflux:solar_panel_7>);//SOLAR PANEL VII
recipes.remove(<solarflux:solar_panel_8>);//SOLAR PANEL VIII
recipes.remove(<solarflux:photovoltaic_cell_1>);//PHOTOVOLTAIC CELL I
recipes.remove(<solarflux:photovoltaic_cell_2>);//PHOTOVOLTAIC CELL II
recipes.remove(<solarflux:photovoltaic_cell_3>);//PHOTOVOLTAIC CELL III
recipes.remove(<solarflux:photovoltaic_cell_4>);//PHOTOVOLTAIC CELL IV
recipes.remove(<solarflux:photovoltaic_cell_5>);//PHOTOVOLTAIC CELL V
recipes.remove(<solarflux:photovoltaic_cell_6>);//PHOTOVOLTAIC CELL VI
recipes.remove(<quantumstorage:quantum_tank>);//QUANTUM TANK
recipes.remove(<quantumstorage:quantum_storage_unit>);//QUANTUM STORAGE UNIT
recipes.remove(<quantumstorage:quantumcrafter>);//QUANTUM CRAFTER
recipes.remove(<quantumstorage:chest_iron>);//IRON CRATE
recipes.remove(<quantumstorage:chest_gold>);//GOLD CRATE
recipes.remove(<quantumstorage:chest_diamond>);//DIAMOND CRATE
recipes.remove(<quantumstorage:chest_quantum>);//QUANTUM CRATE
recipes.remove(<quantumstorage:quantum_battery>);//QUANTUM BATTERY
recipes.remove(<quantumstorage:remote>);//STORAGE REMOTE
recipes.remove(<xreliquary:ender_staff>);//ENDER STAFF
recipes.remove(<avaritia:neutron_collector>);//NEUTRON COLLECTOR
recipes.remove(<mysticalagriculture:master_infusion_crystal>);//MASTER INFUSION CRYSTAL
recipes.remove(<avaritia:extreme_crafting_table>);//EXTREME CRAFTING TABLE
recipes.remove(<woot:cell:2>);//PREMIUM POWER CELL
recipes.remove(<woot:yahhammer>);//YAH HAMMER
recipes.remove(<woot:anvil>);//STYGIAN IRON ANVIL
recipes.remove(<woot:structure:9>);//TIER IV CAP
recipes.remove(<woot:stygianironplate>);//STYGIAN IRON PLATE
<ore:oreTin>.remove(<extraplanets:neptune:4>);//TIN REMOVAL
<ore:ingotIridium>.add(<ic2:misc_resource:1>);//IRIDIUM OREDICT
recipes.remove(<ae2wtlib:infinity_booster_card>);//INFINITY BOOSTER CARD
furnace.remove(<ore:ingotTin>, <extraplanets:neptune:4>);
<extraplanets:neptune:4>.displayName = "Iridium Ore";
mods.mekanism.purification.removeRecipe(<mekanism:clump:4>, <extraplanets:neptune:4>, <gas:oxygen>);
mods.mekanism.chemical.dissolution.removeRecipe(<gas:tin>, <extraplanets:neptune:4>);
mods.mekanism.chemical.injection.removeRecipe(<mekanism:shard:4>, <extraplanets:neptune:4>, <gas:hydrogenchloride>);
mods.mekanism.enrichment.removeRecipe(<ore:dustTin>, <extraplanets:neptune:4>);
mods.nuclearcraft.melter.removeRecipeWithInput([<extraplanets:neptune:4>]);
mods.mekanism.enrichment.addRecipe(<extraplanets:neptune:4>, <ic2:misc_resource:2> * 2);
mods.mekanism.chemical.dissolution.addRecipe(<extraplanets:neptune:4>, <gas:slurryIridium>*100);
mods.jei.JEI.hideCategory("Avatitia.Extreme");
recipes.remove(<minecraft:obsidian>);//OBSIDIAN
recipes.remove(<enderstorage:ender_storage>);//ENDER CHEST
recipes.remove(<enderstorage:ender_storage:1>);//ENDER TANK
//ADD RECIPES
recipes.addShaped(<quark:crystal:0>*4,[[null,<minecraft:glass>,null],
																[<minecraft:glass>,<ore:dyeWhite>,<minecraft:glass>],
																[null,<minecraft:glass>,null]]);//WHITE CAVE CRYSTAL
recipes.addShaped(<quark:crystal:1>*4,[[null,<minecraft:glass>,null],
																[<minecraft:glass>,<ore:dyeRed>,<minecraft:glass>],
																[null,<minecraft:glass>,null]]);//RED CAVE CRYSTAL
recipes.addShaped(<quark:crystal:2>*4,[[null,<minecraft:glass>,null],
																[<minecraft:glass>,<ore:dyeOrange>,<minecraft:glass>],
																[null,<minecraft:glass>,null]]);//ORANGE CAVE CRYSTAL
recipes.addShaped(<quark:crystal:3>*4,[[null,<minecraft:glass>,null],
																[<minecraft:glass>,<ore:dyeYellow>,<minecraft:glass>],
																[null,<minecraft:glass>,null]]);//YELLOW CAVE CRYSTAL
recipes.addShaped(<quark:crystal:4>*4,[[null,<minecraft:glass>,null],
																[<minecraft:glass>,<ore:dyeLime>,<minecraft:glass>],
																[null,<minecraft:glass>,null]]);//GREEN CAVE CRYSTAL
recipes.addShaped(<quark:crystal:5>*4,[[null,<minecraft:glass>,null],
																[<minecraft:glass>,<ore:dyeLightBlue>,<minecraft:glass>],
																[null,<minecraft:glass>,null]]);//BLUE CAVE CRYSTAL
recipes.addShaped(<quark:crystal:6>*4,[[null,<minecraft:glass>,null],
																[<minecraft:glass>,<ore:dyeBlue>,<minecraft:glass>],
																[null,<minecraft:glass>,null]]);//INDIGO CAVE CRYSTAL
recipes.addShaped(<quark:crystal:7>*4,[[null,<minecraft:glass>,null],
																[<minecraft:glass>,<ore:dyePurple>,<minecraft:glass>],
																[null,<minecraft:glass>,null]]);//VIOLET CAVE CRYSTAL
recipes.addShaped(<quark:crystal:8>*4,[[null,<minecraft:glass>,null],
																[<minecraft:glass>,<ore:dyeBlack>,<minecraft:glass>],
																[null,<minecraft:glass>,null]]);//BLACK CAVE CRYSTAL
recipes.addShaped(<fluxnetworks:fluxcore>*6,[[<fluxnetworks:flux>,<mekanism:ingot:0>,<fluxnetworks:flux>],
																[<mekanism:ingot:0>,<minecraft:ender_eye>,<mekanism:ingot:0>],
																[<fluxnetworks:flux>,<mekanism:ingot:0>,<fluxnetworks:flux>]]);//FLUX CORE
recipes.addShaped(<bigreactors:reactorcasingcores>*2,[[<mekanism:ingot:0>,<ore:ingotUranium>,<mekanism:ingot:0>],
																[<mekanism:ingot:3>,<actuallyadditions:item_crystal_empowered:0>,<mekanism:ingot:3>],
																[<mekanism:ingot:0>,<ore:ingotUranium>,<mekanism:ingot:0>]]);//REACTOR CASING CORE
recipes.addShaped(<bigreactors:reactorcasing:0>*8,[[<mekanism:ingot:0>,<ore:ingotYellorium>,<mekanism:ingot:0>],
																[<ore:ingotUranium>,<bigreactors:reactorcasingcores>,<ore:ingotUranium>],
																[<mekanism:ingot:0>,<ore:ingotUranium>,<mekanism:ingot:0>]]);//REACTOR CASING
recipes.addShaped(<bigreactors:turbinehousingcores>*2,[[<mekanism:ingot:0>,<ore:ingotUranium>,<mekanism:ingot:0>],
																[<mekanism:ingot:3>,<actuallyadditions:item_crystal_empowered:1>,<mekanism:ingot:3>],
																[<mekanism:ingot:0>,<ore:ingotUranium>,<mekanism:ingot:0>]]);//TURBINE HOUSING CORE
recipes.addShaped(<bigreactors:turbinehousing:0>*4,[[<mekanism:ingot:0>,<ore:ingotUranium>,<mekanism:ingot:0>],
																[<ore:ingotUranium>,<bigreactors:turbinehousingcores>,<ore:ingotUranium>],
																[<mekanism:ingot:0>,<ore:ingotUranium>,<mekanism:ingot:0>]]);//TURBINE HOUSING
recipes.addShaped(<extendedcrafting:material:14>,[[<jaopca:item_platedarkiron>,<extendedcrafting:material:7>,null],
																[<extraplanets:tier5_items:5>,<extraplanets:tier5_items:5>,null],
																[null,null,null]]);//BASIC COMPONENT
recipes.addShaped(<extendedcrafting:material:7>,[[<thermalfoundation:material:1024>,<botania:manaresource:23>,null],
																[<mekanism:otherdust:5>,<astralsorcery:itemcraftingcomponent:2>,null],
																[null,null,null]]);//LUMINESSENCE
recipes.addShaped(<extendedcrafting:material:8>,[[null,<extendedcrafting:material:14>,null],
																[<extendedcrafting:material:14>,<extraplanets:tier10_items:5>,<extendedcrafting:material:14>],
																[null,<extendedcrafting:material:14>,null]]);//BASIC CATALYST
recipes.addShaped(<extendedcrafting:material:15>,[[<jaopca:item_platedarkiron>,<extendedcrafting:material:7>,null],
																[<mekanism:ingot:3>,<mekanism:ingot:3>,null],
																[null,null,null]]);//ADVANCED COMPONENT
recipes.addShaped(<extendedcrafting:material:16>,[[<jaopca:item_platedarkiron>,<extendedcrafting:material:7>,null],
																[<calculator:flawlessdiamond>,<calculator:flawlessdiamond>,null],
																[null,null,null]]);//ELITE COMPONENT
recipes.addShaped(<extendedcrafting:material:17>,[[<jaopca:item_platedarkiron>,<extendedcrafting:material:7>,null],
																[<contenttweaker:empowered_lead_ingot>,<contenttweaker:empowered_lead_ingot>,null],
																[null,null,null]]);//ULTIMATE COMPONENT
recipes.addShaped(<extendedcrafting:table_basic>,[[<extendedcrafting:material:14>,<extendedcrafting:material:8>,<extendedcrafting:material:14>],
																[<galacticraftcore:magnetic_table>,<actuallyadditions:block_crystal_empowered:5>,<botania:opencrate:1>],
																[<extendedcrafting:material:14>,<jaopca:item_platedarkiron>,<extendedcrafting:material:14>]]);//BASIC CRAFTING TABLE
recipes.addShaped(<extendedcrafting:table_advanced>,[[<extendedcrafting:material:15>,<draconicevolution:chaotic_core>,<extendedcrafting:material:15>],
																[<extendedcrafting:material:9>,<extendedcrafting:table_basic>.reuse(),<extendedcrafting:material:9>],
																[<extendedcrafting:material:15>,<draconicevolution:chaotic_core>,<extendedcrafting:material:15>]]);//ADVANCED CRAFTING TABLE
recipes.addShaped(<extendedcrafting:table_elite>,[[<extendedcrafting:material:16>,<mysticalagradditions:insanium>,<extendedcrafting:material:16>],
																[<extendedcrafting:material:10>,<extendedcrafting:table_advanced>.reuse(),<extendedcrafting:material:10>],
																[<extendedcrafting:material:16>,<mysticalagradditions:insanium>,<extendedcrafting:material:16>]]);//ELITE CRAFTING TABLE
recipes.addShaped(<extendedcrafting:table_ultimate>,[[<extendedcrafting:material:17>,<avaritia:singularity:11>,<extendedcrafting:material:17>],
																[<extendedcrafting:material:11>,<extendedcrafting:table_elite>.reuse(),<extendedcrafting:material:11>],
																[<extendedcrafting:material:17>,<avaritia:singularity:11>,<extendedcrafting:material:17>]]);//ULTIMATE CRAFTING TABLE
recipes.addShaped(<extendedcrafting:material:9>,[[null,<extendedcrafting:material:15>,null],
																[<extendedcrafting:material:15>,<extraplanets:tier10_items:5>,<extendedcrafting:material:15>],
																[null,<extendedcrafting:material:15>,null]]);//ADVANCED CATALYST
recipes.addShaped(<extendedcrafting:material:10>,[[null,<extendedcrafting:material:16>,null],
																[<extendedcrafting:material:16>,<extraplanets:tier10_items:5>,<extendedcrafting:material:16>],
																[null,<extendedcrafting:material:16>,null]]);//ELITE CATALYST
recipes.addShaped(<extendedcrafting:material:11>,[[null,<extendedcrafting:material:17>,null],
																[<extendedcrafting:material:17>,<extraplanets:tier10_items:5>,<extendedcrafting:material:17>],
																[null,<extendedcrafting:material:17>,null]]);//ULTIMATE CATALYST
mods.extendedcrafting.TableCrafting.addShaped(0, <mysticalagriculture:infusion_crystal>, [
	[null, null, <ore:blockInferiumEssence>, null, null], 
	[null, <ore:ingotCrystalMatrix>, <contenttweaker:draconium_crystal>, <ore:ingotCrystalMatrix>, null], 
	[<ore:blockInferiumEssence>, <contenttweaker:draconium_crystal>, <astralsorcery:itemcelestialcrystal>, <contenttweaker:draconium_crystal>, <ore:blockInferiumEssence>], 
	[null, <ore:ingotCrystalMatrix>, <contenttweaker:draconium_crystal>, <ore:ingotCrystalMatrix>, null], 
	[null, null, <ore:blockInferiumEssence>, null, null]
]);//INFUSION CRYSTAL
mods.extendedcrafting.TableCrafting.addShaped(0, <mysticalagriculture:master_infusion_crystal>, [
	[<ore:crystalPureNetherQuartz>, <ore:crystalPureFluix>, <ore:slimecrystal>, <contenttweaker:runeofday>, <ore:slimecrystal>, <ore:crystalPureFluix>, <ore:crystalPureNetherQuartz>], 
	[<ore:crystalPureFluix>, <ore:blockSupremiumEssence>, <ore:blockCrystalFlux>, <draconicevolution:energy_crystal:2>, <ore:blockCrystalFlux>, <ore:blockSupremiumEssence>, <ore:crystalPureFluix>], 
	[<bloodmagic:item_demon_crystal:3>, <ic2:lapotron_crystal>, <astralsorcery:itemcelestialcrystal>, <actuallyadditions:item_crystal_empowered:4>, <astralsorcery:itemcelestialcrystal>, <ic2:lapotron_crystal>, <bloodmagic:item_demon_crystal:3>], 
	[<ore:crystalArdite>, <draconicevolution:energy_crystal:2>, <actuallyadditions:item_crystal_empowered:4>, <mysticalagriculture:infusion_crystal>, <actuallyadditions:item_crystal_empowered:4>, <draconicevolution:energy_crystal:2>, <ore:crystalArdite>], 
	[<bloodmagic:item_demon_crystal:3>, <ic2:lapotron_crystal>, <astralsorcery:itemcelestialcrystal>, <actuallyadditions:item_crystal_empowered:4>, <astralsorcery:itemcelestialcrystal>, <ic2:lapotron_crystal>, <bloodmagic:item_demon_crystal:3>], 
	[<ore:crystalPureFluix>, <ore:blockSupremiumEssence>, <ore:blockCrystalFlux>, <draconicevolution:energy_crystal:2>, <ore:blockCrystalFlux>, <ore:blockSupremiumEssence>, <ore:crystalPureFluix>], 
	[<ore:crystalPureNetherQuartz>, <ore:crystalPureFluix>, <ore:slimecrystal>, <contenttweaker:runeofnight>, <ore:slimecrystal>, <ore:crystalPureFluix>, <ore:crystalPureNetherQuartz>]
	]);//MASTER INFUSION CRYSTAL
mods.extendedcrafting.TableCrafting.addShaped(0, <avaritia:neutron_collector>, [
	[<mekanism:polyethene:2>, <ore:gemDimensionalShard>, <ore:gemDimensionalShard>, <ore:gemDimensionalShard>, <mekanism:polyethene:2>], 
	[<mekanism:polyethene:2>, <ore:plateIridium>, <mekanism:machineblock3:1>, <ore:plateIridium>, <mekanism:polyethene:2>], 
	[<mekanism:polyethene:2>, <ore:plateIridium>, <draconicevolution:draconic_core>, <ore:plateIridium>, <mekanism:polyethene:2>], 
	[<mekanism:polyethene:2>, <ore:plateIridium>, <draconicevolution:crafting_injector>, <ore:plateIridium>, <mekanism:polyethene:2>], 
	[<mekanism:polyethene:2>, <ore:ingotZinc>, <ore:ingotZinc>, <ore:ingotZinc>, <mekanism:polyethene:2>]
]);
recipes.addShaped(<environmentaltech:litherite_crystal>*2,[[null,<thermalfoundation:material:864>,null],
																[<thermalfoundation:material:864>,<jaopca:item_crystaluranium>,<thermalfoundation:material:864>],
																[null,<thermalfoundation:material:864>,null]]);//LITHERITE CRYSTAL
recipes.addShaped(<environmentaltech:connector>*4,[[<thermalfoundation:material:893>,<thermalfoundation:material:162>,<thermalfoundation:material:893>],
																[<thermalfoundation:material:162>,<thermalfoundation:material:893>,<thermalfoundation:material:162>],
																[<thermalfoundation:material:893>,<thermalfoundation:material:162>,<thermalfoundation:material:893>]]);//CONNECTOR
recipes.addShaped(<environmentaltech:diode>,[[<extrautils2:ineffableglass>,<extrautils2:ineffableglass>,<extrautils2:ineffableglass>],
																[<extrautils2:ineffableglass>,<thermalfoundation:material:893>,<extrautils2:ineffableglass>],
																[<extrautils2:ineffableglass>,<thermalfoundation:material:162>,<extrautils2:ineffableglass>]]);//DIODE
recipes.addShaped(<cookingforblockheads:milk_jar>,[[<ore:blockGlass>,<botania:livingwood>,<ore:blockGlass>],
																[<ore:blockGlass>,null,<ore:blockGlass>],
																[<ore:blockGlass>,<ore:blockGlass>,<ore:blockGlass>]]);//MILK JAR
recipes.addShaped(<cookingforblockheads:cow_jar>,[[null,<industrialforegoing:animal_resource_harvester>,null],
																[null,<thermalexpansion:morb:0>,null],
																[null,<cookingforblockheads:milk_jar>,null]]);//COWJAR
recipes.addShaped(<solarflux:mirror>*6,[[null,null,null],
																[<thermalfoundation:glass:3>,<thermalfoundation:glass:3>,<thermalfoundation:glass:3>],
																[null,<ore:ingotInvar>,null]]);//MIRROR
recipes.addShaped(<solarflux:solar_panel_1>,[[<solarflux:mirror>,<solarflux:mirror>,<solarflux:mirror>],
																[<sonarcore:reinforcedstoneblock>,<actuallyadditions:item_crystal:0>,<sonarcore:reinforcedstoneblock>],
																[<sonarcore:reinforcedstoneblock>,<sonarcore:reinforcedstoneblock>,<sonarcore:reinforcedstoneblock>]]);//SOLAR PANEL I
recipes.addShaped(<solarflux:solar_panel_2>,[[<solarflux:solar_panel_1>,<solarflux:solar_panel_1>,<solarflux:solar_panel_1>],
																[<solarflux:solar_panel_1>,<actuallyadditions:item_misc:8>,<solarflux:solar_panel_1>],
																[<solarflux:solar_panel_1>,<solarflux:solar_panel_1>,<solarflux:solar_panel_1>]]);//SOLAR PANEL II
recipes.addShaped(<solarflux:solar_panel_3>*2,[[<solarflux:photovoltaic_cell_1>,<solarflux:photovoltaic_cell_1>,<solarflux:photovoltaic_cell_1>],
																[<solarflux:solar_panel_2>,<thermalfoundation:material:513>,<solarflux:solar_panel_2>],
																[<solarflux:solar_panel_2>,<contenttweaker:blockcasing_steel>,<solarflux:solar_panel_2>]]);//SOLAR PANEL III
recipes.addShaped(<solarflux:solar_panel_4>*2,[[<solarflux:photovoltaic_cell_2>,<solarflux:photovoltaic_cell_2>,<solarflux:photovoltaic_cell_2>],
																[<solarflux:solar_panel_3>,<thermalfoundation:material:514>,<solarflux:solar_panel_3>],
																[<solarflux:solar_panel_3>,<contenttweaker:blockcasing_empoweredredsteel>,<solarflux:solar_panel_3>]]);//SOLAR PANEL IV
recipes.addShaped(<solarflux:solar_panel_5>*2,[[<solarflux:photovoltaic_cell_3>,<solarflux:photovoltaic_cell_3>,<solarflux:photovoltaic_cell_3>],
																[<solarflux:solar_panel_4>,<thermalfoundation:material:515>,<solarflux:solar_panel_4>],
																[<solarflux:solar_panel_4>,<contenttweaker:blockcasing_enderium>,<solarflux:solar_panel_4>]]);//SOLAR PANEL V
recipes.addShaped(<solarflux:solar_panel_6>*2,[[<solarflux:photovoltaic_cell_4>,<solarflux:photovoltaic_cell_4>,<solarflux:photovoltaic_cell_4>],
																[<solarflux:solar_panel_5>,<mekanism:controlcircuit:1>,<solarflux:solar_panel_5>],
																[<solarflux:solar_panel_5>,<contenttweaker:blockcasing_refinedglowstone>,<solarflux:solar_panel_5>]]);//SOLAR PANEL VI
recipes.addShaped(<solarflux:photovoltaic_cell_1>*2,[[<minecraft:glass>,<minecraft:glass>,<minecraft:glass>],
																[<actuallyadditions:item_crystal_empowered:1>,<actuallyadditions:item_crystal_empowered:1>,<actuallyadditions:item_crystal_empowered:1>],
																[<solarflux:mirror>,<solarflux:mirror>,<solarflux:mirror>]]);//PHOTOVOLTAIC CELL I
recipes.addShaped(<solarflux:solar_panel_7>*2,[[<solarflux:photovoltaic_cell_5>,<solarflux:photovoltaic_cell_5>,<solarflux:photovoltaic_cell_5>],
																[<solarflux:solar_panel_6>,<extraplanets:tier7_items:7>,<solarflux:solar_panel_6>],
																[<solarflux:solar_panel_6>,<extraplanets:tier7_items:7>,<solarflux:solar_panel_6>]]);//SOLAR PANEL VII
recipes.addShaped(<solarflux:solar_panel_8>*2,[[<solarflux:photovoltaic_cell_6>,<solarflux:photovoltaic_cell_6>,<solarflux:photovoltaic_cell_6>],
																[<solarflux:solar_panel_7>,<minecraft:dragon_egg>,<solarflux:solar_panel_7>],
																[<solarflux:solar_panel_7>,<contenttweaker:blockcasing_awakeneddraconium>,<solarflux:solar_panel_7>]]);//SOLAR PANEL VIII
recipes.addShapeless(<minecraft:chest>,[<ore:chestWood>]);//CHEST CONVERSION
recipes.addShaped(<bd:dimensionchecker>,[[<sonarcore:stablestone_lime>,<minecraft:stained_glass:11>,<sonarcore:stablestone_lime>],
																[<minecraft:stained_glass:11>,<contenttweaker:duplication_core>,<minecraft:stained_glass:11>],
																[<sonarcore:stablestone_lime>,<minecraft:stained_glass:11>,<sonarcore:stablestone_lime>]]);//DIMENSION CHECKER
mods.extendedcrafting.TableCrafting.addShaped(0, <avaritia:neutronium_compressor>, [
	[null, null, null, null, null, null, null], 
	[<extraplanets:tier9_items:3>, <ore:gemDimensionalShard>, <ore:gemDimensionalShard>, <ore:gemDimensionalShard>, <ore:gemDimensionalShard>, <ore:gemDimensionalShard>, <extraplanets:tier9_items:3>], 
	[<extraplanets:tier9_items:3>, <ore:gearEnderium>, <ore:ingotIridium>, <ore:ingotIridium>, <ore:ingotIridium>, <ore:gearEnderium>, <extraplanets:tier9_items:3>], 
	[<extraplanets:tier9_items:3>, <ore:ingotCosmicNeutronium>, <ore:ingotInsanium>, <ic2:te:43>, <ore:ingotInsanium>, <ore:ingotCosmicNeutronium>, <extraplanets:tier9_items:3>], 
	[<extraplanets:tier9_items:3>, <ore:gearEnderium>, <ore:ingotIridium>, <ore:ingotIridium>, <ore:ingotIridium>, <ore:gearEnderium>, <extraplanets:tier9_items:3>], 
	[<extraplanets:tier9_items:3>, <ore:gemDimensionalShard>, <ore:gemDimensionalShard>, <ore:gemDimensionalShard>, <ore:gemDimensionalShard>, <ore:gemDimensionalShard>, <extraplanets:tier9_items:3>], 
	[null, null, null, null, null, null, null]
]);//NEUTRONIUM COMPRESSOR
recipes.addShaped(<contenttweaker:simulation_core>,[[<extraplanets:tier10_items:5>,<minecraft:stained_glass:14>,<extraplanets:tier10_items:5>],
																[<minecraft:stained_glass:14>,<contenttweaker:duplication_core>,<minecraft:stained_glass:14>],
																[<extraplanets:tier10_items:5>,<minecraft:stained_glass:14>,<extraplanets:tier10_items:5>]]);//SIMULATION CORE
recipes.addShaped(<woot:yahhammer>,[[null,<minecraft:blaze_powder>,<minecraft:skull:2>],
																[null,<tconstruct:materials:17>,<minecraft:blaze_powder>],
																[<tconstruct:materials:17>,null,null]]);//YAH HAMMER
recipes.addShaped(<woot:anvil>,[[<woot:stygianironingot>,<woot:stygianiron>,<woot:stygianironingot>],
																[null,<galacticraftplanets:mars:4>,null],
																[<galacticraftplanets:mars:4>,<galacticraftplanets:mars:4>,<galacticraftplanets:mars:4>]]);//STYGIAN IRON ANVIL
recipes.addShaped(<draconicevolution:draconium_ingot>,[[<mysticalagriculture:draconium_essence>,<mysticalagriculture:draconium_essence>,<mysticalagriculture:draconium_essence>],
																[<mysticalagriculture:draconium_essence>,null,<mysticalagriculture:draconium_essence>],
																[<mysticalagriculture:draconium_essence>,<mysticalagriculture:draconium_essence>,<mysticalagriculture:draconium_essence>]]);//DRACONIUM INGOT
recipes.addShaped(<ae2wtlib:infinity_booster_card>,[[<ore:ingotMagnesium>,<appliedenergistics2:material:41>,<ore:ingotMagnesium>],
																[<ic2:crafting:4>,<appliedenergistics2:material:42>,<ic2:crafting:4>],
																[<ore:ingotMagnesium>,<ore:ingotDesh>,<ore:ingotMagnesium>]]);//INFINITY BOOSTER
recipes.addShaped(<environmentaltech:lonsdaleite_crystal>*4,[[<fluxnetworks:flux>,<environmentaltech:litherite_crystal>,<fluxnetworks:flux>],
																[<environmentaltech:litherite_crystal>,<ore:dustMithril>,<environmentaltech:litherite_crystal>],
																[<fluxnetworks:flux>,<environmentaltech:litherite_crystal>,<fluxnetworks:flux>]]);//LONSDALEITE
recipes.addShaped(<extendedcrafting:crafting_core>,[[<ore:ingotDarkIron>,<extendedcrafting:material:10>,<ore:ingotDarkIron>],
																[<extendedcrafting:material:16>,<extendedcrafting:frame>,<extendedcrafting:material:16>],
																[<ore:ingotDarkIron>,<avaritia:singularity:10>,<ore:ingotDarkIron>]]);//CRAFTING CORE


recipes.addShaped(<minecraft:obsidian>*12,[[<mysticalagriculture:obsidian_essence>,<mysticalagriculture:obsidian_essence>,<mysticalagriculture:obsidian_essence>],
																[<mysticalagriculture:obsidian_essence>,null,<mysticalagriculture:obsidian_essence>],
																[<mysticalagriculture:obsidian_essence>,<mysticalagriculture:obsidian_essence>,<mysticalagriculture:obsidian_essence>]]);//CRAFTING CORE
recipes.addShaped(<thermalfoundation:material:135>*2,[[<mysticalagriculture:iridium_essence>,<mysticalagriculture:iridium_essence>,<mysticalagriculture:iridium_essence>],
																[<mysticalagriculture:iridium_essence>,null,<mysticalagriculture:iridium_essence>],
																[<mysticalagriculture:iridium_essence>,<mysticalagriculture:iridium_essence>,<mysticalagriculture:iridium_essence>]]);//IRIDIUM

recipes.addShaped(<ic2:misc_resource:1>*2,[[<mysticalagriculture:iridium_ore_essence>,<mysticalagriculture:iridium_ore_essence>,<mysticalagriculture:iridium_ore_essence>],
																[<mysticalagriculture:iridium_ore_essence>,null,<mysticalagriculture:iridium_ore_essence>],
																[<mysticalagriculture:iridium_ore_essence>,<mysticalagriculture:iridium_ore_essence>,<mysticalagriculture:iridium_ore_essence>]]);//IRIDIUM ORE

mods.extendedcrafting.TableCrafting.addShaped(0, <avaritia:resource:5>, [
	[<ore:fuelCoke>, <actuallyadditions:item_crystal_empowered:3>, <astralsorcery:itemcraftingcomponent:4>, <ore:plateAdvancedAlloy>, <appliedenergistics2:material:6>, <ore:plateAdvancedAlloy>, <astralsorcery:itemcraftingcomponent:4>, <actuallyadditions:item_crystal_empowered:5>, <ore:fuelCoke>], 
	[<actuallyadditions:item_crystal_empowered:1>, <ore:itemRubber>, <ore:blockGlassHardened>, <ore:plateAquamarine>, <ore:plateCarbon>, <ore:plateQuartzBlack>, <ore:blockGlassHardened>, <ore:itemRubber>, <actuallyadditions:item_crystal_empowered:1>], 
	[<bloodmagic:slate:2>, <ore:blockGlassHardened>, <ore:ingotElvenElementium>, <botania:specialflower>.withTag({type: "hopperhock"}), <extraplanets:wafer:3>, <botania:specialflower>.withTag({type: "hopperhock"}), <ore:ingotElvenElementium>, <ore:blockGlassHardened>, <bloodmagic:slate:2>], 
	[<ore:plateAdvancedAlloy>, <ore:plateEnderium>, <thermalfoundation:fertilizer:2>, <ore:elvenPixieDust>, <ore:circuitUltimate>, <ore:elvenPixieDust>, <thermalfoundation:fertilizer:2>, <ore:plateEnderium>, <ore:plateAdvancedAlloy>], 
	[<appliedenergistics2:material:6>, <contenttweaker:bloodshine_ingot>, <refinedstorage:processor:4>, <mekanism:plasticblock:5>, <ore:ingotInfinity>, <mekanism:plasticblock:5>, <refinedstorage:processor:4>, <contenttweaker:bloodshine_ingot>, <appliedenergistics2:material:6>], 
	[<ore:plateAdvancedAlloy>, <ore:plateLumium>, <thermalfoundation:material:832>, <ore:elvenPixieDust>, <ore:circuitUltimate>, <ore:elvenPixieDust>, <thermalfoundation:material:832>, <ore:plateLumium>, <ore:plateAdvancedAlloy>], 
	[<bloodmagic:slate:2>, <ore:blockGlassHardened>, <ore:ingotElvenElementium>, <botania:specialflower>.withTag({type: "thermalily"}), <extraplanets:wafer:3>, <botania:specialflower>.withTag({type: "thermalily"}), <ore:ingotElvenElementium>, <ore:blockGlassHardened>, <bloodmagic:slate:2>], 
	[<actuallyadditions:item_crystal_empowered>, <ore:itemRubber>, <ore:blockGlassHardened>, <ore:plateAquamarine>, <ore:plateCarbon>, <ore:plateQuartzBlack>, <ore:blockGlassHardened>, <ore:itemRubber>, <actuallyadditions:item_crystal_empowered>], 
	[<ore:fuelCoke>, <actuallyadditions:item_crystal_empowered:3>, <astralsorcery:itemcraftingcomponent:4>, <ore:plateAdvancedAlloy>, <appliedenergistics2:material:6>, <ore:plateAdvancedAlloy>, <astralsorcery:itemcraftingcomponent:4>, <actuallyadditions:item_crystal_empowered:5>, <ore:fuelCoke>]]);

	recipes.addShaped(<refinedstorage:quartz_enriched_iron>*2,[[<mysticalagriculture:quartz_enriched_iron_essence>,<mysticalagriculture:quartz_enriched_iron_essence>,<mysticalagriculture:quartz_enriched_iron_essence>],
																[<mysticalagriculture:quartz_enriched_iron_essence>,null,<mysticalagriculture:quartz_enriched_iron_essence>],
																[<mysticalagriculture:quartz_enriched_iron_essence>,<mysticalagriculture:quartz_enriched_iron_essence>,<mysticalagriculture:quartz_enriched_iron_essence>]]);//QUARTZ ENRICHED IRON

recipes.addShaped(<enderstorage:ender_storage>,[[<ore:ingotEnderium>,<minecraft:wool:*>,<ore:ingotEnderium>],
																[<minecraft:blaze_rod>,<ore:chestWood>,<minecraft:blaze_rod>],
																[<ore:ingotEnderium>,<minecraft:blaze_rod>,<ore:ingotEnderium>]]);//ENDER CHEST
recipes.addShaped(<enderstorage:ender_storage:1>,[[<ore:ingotEnderium>,<minecraft:wool:*>,<ore:ingotEnderium>],
																[<minecraft:blaze_rod>,<minecraft:bucket>,<minecraft:blaze_rod>],
																[<ore:ingotEnderium>,<minecraft:blaze_rod>,<ore:ingotEnderium>]]);//ENDER TANK

recipes.addShaped(<quantumstorage:chest_diamond>,[[<actuallyadditions:block_misc:4>,<minecraft:glass>,<actuallyadditions:block_misc:4>],
																[<contenttweaker:empowered_aluminium_ingot>,<ironchest:iron_chest:5>,<contenttweaker:empowered_aluminium_ingot>],
																[<actuallyadditions:block_misc:4>,<minecraft:glass>,<actuallyadditions:block_misc:4>]]);//DIAMOND STORAGE CRATE
recipes.addShaped(<quantumstorage:quantum_tank>,[[<ore:ingotBlackIron>,<ore:glassHardened>,<ore:ingotBlackIron>],
																[<contenttweaker:empowered_silver_ingot>,<extrautils2:drum:3>,<contenttweaker:empowered_silver_ingot>],
																[<ore:ingotBlackIron>,<ore:glassHardened>,<ore:ingotBlackIron>]]);//QUANTUM TANK