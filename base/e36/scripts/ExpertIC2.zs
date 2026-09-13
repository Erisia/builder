//REMOVE RECIPES
recipes.remove(<ic2:forge_hammer>);//FORGE HAMMER
recipes.remove(<ic2:resource:12>);//BASIC MACHINE CASING
recipes.remove(<ic2:te:3>);//GENERATOR
recipes.remove(<ic2:te:47>);//MACERATOR
recipes.remove(<ic2:te:44>);//ELECTRIC FURNACE
recipes.remove(<ic2:te:43>);//COMPRESSOR
recipes.remove(<ic2:te:45>);//EXTRACTOR
recipes.remove(<ic2:crafting:5>);//COIL
recipes.remove(<ic2:drill>);//MINING DRILL
recipes.remove(<ic2:diamond_drill>);//DIAMOND DRILL
recipes.remove(<ic2:te:77>);//LV-TRANSFORMER
recipes.remove(<ic2:te:78>);//MV-TRANSFORMER
recipes.remove(<ic2:te:52>);//THERMAL CENTRIFUGE
recipes.remove(<ic2:te:9>);//STIRLING GENERATOR
recipes.remove(<ic2:crafting:1>);//ELECTRONIC CIRCUIT
recipes.remove(<ic2:crafting:37>);//JETPACK ATTACHMENT PLATE
recipes.remove(<ic2:resource:8>);//STEEL BLOCK
recipes.remove(<bigreactors:blocksteel>);//STEEL BLOCK
recipes.remove(<thermalfoundation:storage_alloy>);//STEEL BLOCK
recipes.remove(<immersiveengineering:storage:8>);//STEEL BLOCK
recipes.remove(<ic2:ingot:5>);//STEEL INGOT
recipes.remove(<bigreactors:ingotsteel>);//STEEL INGOT
recipes.remove(<ic2:te:12>);//ELECTRIC HEAT GENERATOR
recipes.remove(<ic2:jetpack>);//JETPACK
recipes.remove(<ic2:jetpack_electric>);//ELECTRIC JETPACK
recipes.addShaped(<ic2:forge_hammer>,[[<ore:ingotSteel>,<ore:ingotSteel>,null],
																[<ore:ingotSteel>,<immersiveengineering:material:0>,<immersiveengineering:material:0>],
																[<ore:ingotSteel>,<ore:ingotSteel>,null]]);//FORGE HAMMER
recipes.addShaped(<ic2:forge_hammer>,[[null,<ore:ingotSteel>,<ore:ingotSteel>],
																[<immersiveengineering:material:0>,<immersiveengineering:material:0>,<ore:ingotSteel>],
																[null,<ore:ingotSteel>,<ore:ingotSteel>]]);//FORGE HAMMER
recipes.addShaped(<ic2:resource:12>,[[<ore:plateIron>,<ore:plateIron>,<ore:plateIron>],
																[<ore:plateIron>,<immersiveengineering:metal_decoration0:5>,<ore:plateIron>],
																[<ore:plateIron>,<ore:plateIron>,<ore:plateIron>]]);//BASIC MACHINE CASING
recipes.addShapeless(<ic2:te:3>, [<ic2:re_battery:*>,<actuallyadditions:block_coal_generator>]);// GENERATOR
recipes.addShapeless(<ic2:plate:7>, [<ic2:forge_hammer>.anyDamage().transformDamage(),<ore:ingotSteel>]);// STEEL PLATE
recipes.addShaped(<ic2:te:47>,[[<actuallyadditions:item_crystal_shard:2>,<actuallyadditions:block_grinder>.transformDamage(0),<actuallyadditions:item_crystal_shard:2>],
																[<sonarcore:reinforcedstoneblock>,<ic2:resource:12>,<sonarcore:reinforcedstoneblock>],
																[<sonarcore:reinforcedstoneblock>,<ore:circuitBasic>,<sonarcore:reinforcedstoneblock>]]);//MACERATOR
recipes.addShaped(<ic2:te:44>,[[null,<actuallyadditions:block_furnace_double>.transformDamage(0),null],
																[<actuallyadditions:item_crystal:0>,<ic2:resource:12>,<actuallyadditions:item_crystal:0>],
																[<actuallyadditions:item_crystal:0>,<ore:circuitBasic>,<actuallyadditions:item_crystal:0>]]);//ELECTRIC FURNACE
recipes.addShaped(<ic2:te:43>,[[<sonarcore:reinforcedstoneblock>,null,<sonarcore:reinforcedstoneblock>],
																[<sonarcore:reinforcedstoneblock>,<ic2:resource:12>,<sonarcore:reinforcedstoneblock>],
																[<sonarcore:reinforcedstoneblock>,<ore:circuitBasic>,<sonarcore:reinforcedstoneblock>]]);//COMPRESSOR
recipes.addShaped(<ic2:crafting:5>,[[<ic2:cable:0>,<ic2:cable:0>,<ic2:cable:0>],
																[<ic2:cable:0>,<actuallyadditions:item_misc:8>,<ic2:cable:0>],
																[<ic2:cable:0>,<ic2:cable:0>,<ic2:cable:0>]]);//COIL
recipes.addShaped(<ic2:te:45>,[[null,<ic2:electric_treetap>,null],
																[null,<ic2:resource:12>,null],
																[null,<ore:circuitBasic>,null]]);//EXTRACTOR
recipes.addShapeless(<ic2:diamond_drill>, [<actuallyadditions:item_drill:3>]);//DIAMOND DRILL
recipes.addShaped(<ic2:te:77>,[[<immersiveengineering:treated_wood:0>,<ic2:cable:0>,<immersiveengineering:treated_wood:0>],
																[<immersiveengineering:treated_wood:0>,<ic2:crafting:5>,<immersiveengineering:treated_wood:0>],
																[<immersiveengineering:treated_wood:0>,<ic2:cable:0>,<immersiveengineering:treated_wood:0>]]);//LV-TRANSFORMER
recipes.addShaped(<ic2:te:52>,[[<ic2:crafting:5>,<ic2:mining_laser>.anyDamage(),<ic2:crafting:5>],
																[<ore:plateSteel>,<ic2:resource:13>,<ore:plateSteel>],
																[<ore:plateSteel>,<ic2:crafting:6>,<ore:plateSteel>]]);//THERMAL CENTRIFUGE
recipes.addShaped(<ic2:te:9>,[[<ic2:casing:5>,<ic2:crafting:7>,<ic2:casing:5>],
																[<ic2:casing:5>,<ic2:te:3>,<ic2:casing:5>],
																[<ic2:casing:5>,<ore:dustLithium>,<ic2:casing:5>]]);//STIRLING GENERATOR
recipes.addShapeless(<contenttweaker:insulated_dense_copper_cable>, [<ic2:cable>.withTag({type: 0 as byte, insulation: 1 as byte}),<ic2:cable>.withTag({type: 0 as byte, insulation: 1 as byte}),<ic2:cable>.withTag({type: 0 as byte, insulation: 1 as byte}),<ic2:cable>.withTag({type: 0 as byte, insulation: 1 as byte}),<ic2:cable>.withTag({type: 0 as byte, insulation: 1 as byte}),<ic2:cable>.withTag({type: 0 as byte, insulation: 1 as byte})]);//
recipes.addShaped(<ic2:te:78>,[[null,<ic2:cable:0>,null],
																[<galacticraftcore:basic_item:13>,<thermalexpansion:frame:0>,<galacticraftcore:basic_item:13>],
																[null,<ic2:cable:0>,null]]);//MV-TRANSFORMER

recipes.addShaped(<thermalfoundation:material:160>,[[<mysticalagriculture:steel_essence>,<mysticalagriculture:steel_essence>,<mysticalagriculture:steel_essence>],
																[<mysticalagriculture:steel_essence>,null,<mysticalagriculture:steel_essence>],
																[<mysticalagriculture:steel_essence>,<mysticalagriculture:steel_essence>,<mysticalagriculture:steel_essence>]]);//STEEL INGOT

recipes.addShaped(<ic2:jetpack_electric>,[[<ic2:crafting:3>,<ore:circuitAdvanced>,<ic2:crafting:3>],
																[<ic2:crafting:3>,<simplyjetpacks:itemjetpack:10>,<ic2:crafting:3>],
																[<ore:dustGlowstone>,null,<ore:dustGlowstone>]]);//ELECTRIC JETPACK

mods.jei.JEI.addDescription(<ic2:te:64>,"Supported UU patterns are as follows:", "Advanced Coil (AA)", "Machine Frame (TE)", "Machine Case (IF)", "Steel Casing (Mekanism)", "Redstone Reception Coil", "Iridium Reinforced Plate", "RS Processors", "RS Crafter and ME Interface", "Chaos Shard", "Basic and Advanced Casings (IC2)", "ET Crystals", "ME Controller");

mods.jei.JEI.addDescription(<ic2:te:63>,"Supported UU patterns are as follows:", "Advanced Coil (AA)", "Machine Frame (TE)", "Machine Case (IF)", "Steel Casing (Mekanism)", "Redstone Reception Coil", "Iridium Reinforced Plate", "RS Processors", "RS Crafter and ME Interface", "Chaos Shard", "Basic and Advanced Casings (IC2)", "ET Crystals", "ME Controller");