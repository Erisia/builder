//REMOVE RECIPES
recipes.remove(<mekanism:basicblock:8>);//STEEL CASING
recipes.remove(<mekanism:machineblock:8>);//METALLURGIC INFUSER
recipes.remove(<mekanism:machineblock:10>);//ENERGIZED SMELTER
recipes.remove(<mekanism:machineblock:0>);//ENRICHMENT CHAMBER
recipes.remove(<mekanism:machineblock2:4>);//ELECTROLYTIC SEPARATOR
recipes.remove(<mekanism:machineblock:9>);//PURIFICATION CHAMBER
recipes.remove(<mekanism:basicblock:14>);//THERMAL EVAPORATION CONTROLLER
recipes.remove(<mekanism:basicblock2:0>);//THERMAL EVAPORATION BLOCK
recipes.remove(<mekanism:energytablet:0>);//ENERGY TABLET
recipes.remove(<mekanism:machineblock2:2>);//CHEMICAL INFUSER
recipes.remove(<mekanism:machineblock2:3>);//CHEMICAL INJECTION CHAMBER
recipes.remove(<mekanism:teleportationcore>);//TELEPORTATION CORE
recipes.remove(<mekanism:machineblock2:1>);//CHEMICAL OXIDIZER
recipes.remove(<mekanism:machineblock2:8>);//CHEMICAL CRYSTALLIZER
recipes.remove(<mekanism:machineblock2:7>);//CHEMICAL WASHER
recipes.remove(<mekanism:transmitter:0>);//BASIC CABLE
recipes.remove(<mekanismgenerators:generator:0>);//HEAT GENERATOR
recipes.remove(<mekanism:configurator>);//CONFIGURATOR
recipes.remove(<mekanismgenerators:generator:10>);//TURBINE CASING
//ADD RECIPES
recipes.addShaped(<mekanism:machineblock:8>,[[<ore:ingotPalladium>,<ore:itemSlagRich>,<ore:ingotPalladium>],
																[<contenttweaker:empowered_steel_ingot>,<mekanism:basicblock:8>,<contenttweaker:empowered_steel_ingot>],
																[<ore:ingotPalladium>,<ore:itemSlagRich>,<ore:ingotPalladium>]]);//METALLURGIC 
recipes.addShaped(<mekanism:machineblock:10>,[[<ore:ingotPalladium>,<mekanism:controlcircuit:0>,<ore:ingotPalladium>],
																[<thermalfoundation:glass_alloy:6>,<mekanism:basicblock:8>,<thermalfoundation:glass_alloy:6>],
																[<ore:ingotPalladium>,<mekanism:controlcircuit:0>,<ore:ingotPalladium>]]);//ENERGIZED SMELTER
recipes.addShaped(<mekanism:machineblock:0>,[[<ore:ingotPalladium>,<mekanism:controlcircuit:0>,<ore:ingotPalladium>],
																[<ic2:crafting:4>,<mekanism:basicblock:8>,<ic2:crafting:4>],
																[<ore:ingotPalladium>,<mekanism:controlcircuit:0>,<ore:ingotPalladium>]]);//ENRICHMENT CHAMBER
recipes.addShaped(<mekanism:machineblock2:4>,[[<ore:ingotMagnesium>,<mekanism:controlcircuit:0>,<ore:ingotMagnesium>],
																[<mekanism:enrichedalloy>,<mekanism:electrolyticcore>,<mekanism:enrichedalloy>],
																[<ore:ingotPalladium>,<mekanism:controlcircuit:0>,<ore:ingotPalladium>]]);//ELECTROLYTIC SEPARATOR
recipes.addShaped(<mekanism:machineblock:9>,[[<mekanism:enrichedalloy>,<mekanism:controlcircuit:1>,<mekanism:enrichedalloy>],
																[<ore:plateMagnesium>,<mekanism:machineblock:0>,<ore:plateMagnesium>],
																[<mekanism:enrichedalloy>,<thermalexpansion:augment:273>,<mekanism:enrichedalloy>]]);//PURIFICATION CHAMBER
recipes.addShaped(<mekanism:basicblock:14>,[[<mekanism:controlcircuit:2>,<mekanism:controlcircuit:0>,<mekanism:controlcircuit:2>],
																[<contenttweaker:empowered_aluminium_ingot>,<mekanism:machineblock2:11>,<contenttweaker:empowered_aluminium_ingot>],
																[<mekanism:basicblock2:0>,<mekanism:basicblock2:0>,<mekanism:basicblock2:0>]]);//THERMAL EVAPORATION CONTROLLER
recipes.addShaped(<mekanism:basicblock2:0>*4,[[null,<ore:ingotSteel>,null],
																[<ore:ingotSteel>,<contenttweaker:empowered_copper_ingot>,<ore:ingotSteel>],
																[null,<ore:ingotSteel>,null]]);//THERMAL EVAPORATION BLOCK
recipes.addShaped(<mekanism:energytablet:0>*2,[[<actuallyadditions:item_crystal:0>,<contenttweaker:empowered_gold_ingot>,<actuallyadditions:item_crystal:0>],
																[<mekanism:enrichedalloy>,<contenttweaker:empowered_gold_ingot>,<mekanism:enrichedalloy>],
																[<actuallyadditions:item_crystal:0>,<contenttweaker:empowered_gold_ingot>,<actuallyadditions:item_crystal:0>]]);//ENERGY TABLET
recipes.addShaped(<mekanism:machineblock2:2>,[[<mekanism:reinforcedalloy>,<mekanism:controlcircuit:2>,<mekanism:reinforcedalloy>],
																[<mekanism:gastank:0>,<mekanism:basicblock:9>,<mekanism:gastank:0>],
																[<mekanism:reinforcedalloy>,<mekanism:controlcircuit:2>,<mekanism:reinforcedalloy>]]);//CHEMICAL INFUSER
recipes.addShaped(<mekanism:machineblock2:3>,[[<mekanism:reinforcedalloy>,<mekanism:controlcircuit:2>,<mekanism:reinforcedalloy>],
																[<contenttweaker:empowered_gold_ingot>,<mekanism:machineblock:9>,<contenttweaker:empowered_gold_ingot>],
																[<mekanism:reinforcedalloy>,<mekanism:controlcircuit:2>,<mekanism:reinforcedalloy>]]);//CHEMICAL INJECTION CHAMBER
recipes.addShaped(<mekanism:teleportationcore>,[[<jaopca:item_shardcobalt>,<mekanism:atomicalloy>,<jaopca:item_shardcobalt>],
																[<contenttweaker:empowered_lead_ingot>,<extraplanets:tier5_items:8>,<contenttweaker:empowered_lead_ingot>],
																[<jaopca:item_shardcobalt>,<mekanism:atomicalloy>,<jaopca:item_shardcobalt>]]);//TELEPORTATION CORE
recipes.addShaped(<mekanism:machineblock2:1>,[[<mekanism:atomicalloy>,<mekanism:controlcircuit:3>,<mekanism:atomicalloy>],
																[<mekanism:machineblock:13>,<mekanism:machineblock:9>,<mekanism:gastank>],
																[<mekanism:atomicalloy>,<mekanism:controlcircuit:3>,<mekanism:atomicalloy>]]);//CHEMICAL OXIDIZER
recipes.addShaped(<mekanism:machineblock2:8>,[[<mekanism:controlcircuit:2>,<mekanism:gastank>,<mekanism:controlcircuit:2>],
																[<mekanism:atomicalloy>,<mekanism:basicblock:8>,<mekanism:atomicalloy>],
																[<mekanism:controlcircuit:2>,<mekanism:gastank>,<mekanism:controlcircuit:2>]]);//CHEMICAL CRYSTALLIZER
recipes.addShaped(<mekanism:transmitter>.withTag({tier: 0})*16,[[<ore:ingotSteel>,<actuallyadditions:item_crystal_empowered:0>,<ore:ingotSteel>],
																]);//BASIC CABLE
recipes.addShaped(<mekanism:transmitter>.withTag({tier: 1})*8,[[<mekanism:transmitter>.withTag({tier: 0}),<mekanism:transmitter>.withTag({tier: 0}),<mekanism:transmitter>.withTag({tier: 0})],
																[<mekanism:transmitter>.withTag({tier: 0}),<mekanism:enrichedalloy>,<mekanism:transmitter>.withTag({tier: 0})],
																[<mekanism:transmitter>.withTag({tier: 0}),<mekanism:transmitter>.withTag({tier: 0}),<mekanism:transmitter>.withTag({tier: 0})]]);
recipes.addShaped(<mekanism:transmitter>.withTag({tier: 2})*8,[[<mekanism:transmitter>.withTag({tier: 1}),<mekanism:transmitter>.withTag({tier: 1}),<mekanism:transmitter>.withTag({tier: 1})],
																[<mekanism:transmitter>.withTag({tier: 1}),<mekanism:reinforcedalloy>,<mekanism:transmitter>.withTag({tier: 1})],
																[<mekanism:transmitter>.withTag({tier: 1}),<mekanism:transmitter>.withTag({tier: 1}),<mekanism:transmitter>.withTag({tier: 1})]]);
recipes.addShaped(<mekanism:transmitter>.withTag({tier: 3})*8,[[<mekanism:transmitter>.withTag({tier: 2}),<mekanism:transmitter>.withTag({tier: 2}),<mekanism:transmitter>.withTag({tier: 2})],
																[<mekanism:transmitter>.withTag({tier: 2}),<mekanism:atomicalloy>,<mekanism:transmitter>.withTag({tier: 2})],
																[<mekanism:transmitter>.withTag({tier: 2}),<mekanism:transmitter>.withTag({tier: 2}),<mekanism:transmitter>.withTag({tier: 2})]]);
recipes.addShaped(<mekanism:machineblock2:9>,[[<ore:ingotSteel>,<ore:ingotSteel>,<ore:ingotSteel>],
																[<calculator:reinforcedironingot>,<ore:ingotOsmium>,<calculator:reinforcedironingot>],
																[<ore:ingotCopper>,<ic2:te:46>,<ore:ingotCopper>]]);//SEISMIC VIBRATOR
recipes.addShaped(<mekanism:machineblock2:7>,[[<mekanism:controlcircuit:2>,<mekanism:gastank>,<mekanism:controlcircuit:2>],
																[<ic2:cover:1>,<mekanism:basicblock:8>,<ic2:cover:1>],
																[<mekanism:controlcircuit:2>,<ic2:te:32>,<mekanism:controlcircuit:2>]]);//CHEMICAL WASHER
recipes.addShaped(<mekanism:configurator>,[[<ore:circuitBasic>],
																[<actuallyadditions:item_battery:*>],
																[<minecraft:stick>]]);//CONFIGURATOR
recipes.addShaped(<mekanismgenerators:generator:10>*4,[[null,<ore:plateCrystal>,null],
																[<ore:plateCrystal>,<contenttweaker:empowered_steel_ingot>,<ore:plateCrystal>],
																[null,<ore:plateCrystal>,null]]);//TURBINE CASING
recipes.addShapeless(<mekanism:machineblock>,[<mekanism:machineblock>]);
recipes.addShapeless(<mekanism:machineblock:1>,[<mekanism:machineblock:1>]);
recipes.addShapeless(<mekanism:machineblock:3>,[<mekanism:machineblock:3>]);
recipes.addShapeless(<mekanism:machineblock:10>,[<mekanism:machineblock:10>]);
recipes.addShapeless(<mekanism:machineblock2:10>,[<mekanism:machineblock2:10>]);
recipes.addShapeless(<mekanism:machineblock:9>,[<mekanism:machineblock:9>]);
recipes.addShapeless(<mekanism:machineblock2:3>,[<mekanism:machineblock2:3>]);
recipes.addShapeless(<mekanism:machineblock2:6>,[<mekanism:machineblock2:6>]);
															
mods.mekanism.thermalevaporation.addRecipe(<liquid:nital>, <liquid:nital_concentrated>);//CONCENTRATED NITAL
mods.mekanism.chemical.infuser.addRecipe(<gas:nitrousacid>*2, <gas:oxygen>, <gas:nitricacid>*2);
mods.mekanism.chemical.infuser.addRecipe(<gas:nitricacid>*7, <gas:ethanol>*3, <gas:nital>*10);
//METALLURGIC INFUSER----------------------------------------------------------------------------------------------------------------------------
//REMOVE RECIPES
mods.mekanism.infuser.removeRecipe(<mekanism:enrichedalloy>, <minecraft:iron_ingot>, "REDSTONE");//ENRICHED ALLOY
mods.mekanism.infuser.removeRecipe(<mekanism:controlcircuit:0>, <mekanism:ingot:1>, "REDSTONE");//BASIC CIRCUIT
//ADD RECIPES
mods.mekanism.infuser.addRecipe("REDSTONE", 10, <extraplanets:ingot_mercury:0>, <mekanism:enrichedalloy>);//ENRICHED ALLOY
mods.mekanism.infuser.addRecipe("REDSTONE", 10, <galacticraftplanets:item_basic_asteroids:0>, <mekanism:controlcircuit>);//BASIC CIRCUIT
mods.mekanism.infuser.addRecipe("TIN", 30, <immersiveengineering:metal:8>, <ic2:crafting:3>);//ADVANCED ALLOY
mods.mekanism.infuser.addRecipe("TIN", 30, <ic2:ingot:5>, <ic2:crafting:3>);//ADVANCED ALLOY
mods.mekanism.infuser.addRecipe("TIN", 30, <mekanism:ingot:4>, <ic2:crafting:3>);//ADVANCED ALLOY
mods.mekanism.infuser.addRecipe("TIN", 30, <thermalfoundation:material:160>, <ic2:crafting:3>);//ADVANCED ALLOY
mods.mekanism.infuser.addRecipe("TITANIUM", 20, <solarflux:photovoltaic_cell_3>, <solarflux:photovoltaic_cell_4>);//ENRICHED ALLOY
mods.mekatweaker.InfuserType.addTypeObject(<galacticraftplanets:item_basic_asteroids>, "TITANIUM", 40);

mods.mekanism.enrichment.addRecipe(<contenttweaker:mixed_blend>, <contenttweaker:mixed_brick> * 2);