//REMOVE RECIPES
recipes.remove(<refinedstorage:quartz_enriched_iron>);//QUARTZ ENRICHED IRON
recipes.remove(<refinedstorage:processor_binding>);//PROCESSOR BINDING
recipes.remove(<refinedstorage:processor:0>);//CUT BASIC PROCESSOR
recipes.remove(<refinedstorage:processor:1>);//CUT IMPROVED PROCESSOR
recipes.remove(<refinedstorage:processor:2>);//CUT ADVANCED PROCESSOR
recipes.remove(<refinedstorage:machine_casing>);//MACHINE CASING
recipes.remove(<refinedstorage:storage_part:0>);//1K STORAGE PART
recipes.remove(<refinedstorage:grid:0>);//GRID
recipes.remove(<refinedstorage:pattern>);//PATTERN
recipes.remove(<appliedenergistics2:network_tool>);//NETWORK TOOL
recipes.remove(<appliedenergistics2:memory_card>);//MEMORY CARD
recipes.remove(<appliedenergistics2:wireless_access_point>);//WIRELESS ACCESS POINT
recipes.remove(<appliedenergistics2:part:360>);//CRAFTING TERMINAL
recipes.remove(<appliedenergistics2:part:280>);//ME LEVEL EMITTER
recipes.remove(<appliedenergistics2:part:281>);//ME FLUID LEVEL EMITTER
recipes.remove(<appliedenergistics2:crafting_unit>);//CRAFTING UNIT
recipes.remove(<appliedenergistics2:material:38>);//64K CRAFTING COMPONENT
recipes.remove(<appliedenergistics2:material:36>);//4K CRAFTING COMPONENT
recipes.remove(<appliedenergistics2:material:37>);//16K CRAFTING COMPONENT
recipes.remove(<appliedenergistics2:material:57>);//64K FLUID COMPONENT
recipes.remove(<appliedenergistics2:material:55>);//4K FLUID COMPONENT
recipes.remove(<appliedenergistics2:material:56>);//16K FLUID COMPONENT
recipes.remove(<appliedenergistics2:dense_energy_cell>);//DENSE ENERGY CELL
recipes.remove(<appliedenergistics2:cell_workbench>);//CELL WORKBENCH
recipes.remove(<appliedenergistics2:material:25>);//BASIC CARD
recipes.remove(<appliedenergistics2:material:28>);//ADVANCED CARD
recipes.remove(<appliedenergistics2:biometric_card>);//BIOMETRIC CARD
recipes.remove(<appliedenergistics2:part:460>);//P2P TUNNEL
recipes.remove(<appliedenergistics2:part:340>);//PATTERN TERMINAL
recipes.remove(<appliedenergistics2:part:480>);//INTERFACE TERMINAL
recipes.remove(<appliedenergistics2:crafting_accelerator>);//CRAFTING COPROCESSOR
recipes.remove(<appliedenergistics2:material:34>);//128^3 STORAGE COMPONENT
recipes.remove(<appliedenergistics2:material:33>);//16^3 STORAGE COMPONENT
recipes.remove(<appliedenergistics2:material:32>);//2^3 STORAGE COMPONENT
recipes.remove(<appliedenergistics2:drive>);//ME DRIVE
recipes.remove(<appliedenergistics2:spatial_io_port>);//SPATIAL IO PORT
recipes.remove(<appliedenergistics2:security_station>);//SECURITY TERMINAL
recipes.remove(<appliedenergistics2:quantum_ring>);//QUANTUM RING
recipes.remove(<appliedenergistics2:controller>);//ME CONTROLLER
recipes.remove(<appliedenergistics2:part:520>);//FLUID TERMINAL
recipes.remove(<appliedenergistics2:part:380>);//ME TERMINAL
recipes.remove(<appliedenergistics2:material:35>);//1K STORAGE
recipes.remove(<appliedenergistics2:material:54>);//1K FLUID STORAGE
recipes.remove(<appliedenergistics2:io_port>);//IO PORT
recipes.remove(<appliedenergistics2:material:43>);//FORMATION CORE
recipes.remove(<appliedenergistics2:material:44>);//ANNIHILATION CORE
recipes.remove(<refinedstorage:controller>);//ANNIHILATION CORE
recipes.remove(<appliedenergistics2:material:41>);//WIRELESS RECEIVER
//ADD RECIPES
recipes.addShaped(<refinedstorage:machine_casing>*2,[[<refinedstorage:quartz_enriched_iron>,<galacticraftplanets:item_basic_mars:2>,<refinedstorage:quartz_enriched_iron>],
																[<galacticraftplanets:item_basic_mars:2>,<thermalexpansion:frame:0>,<galacticraftplanets:item_basic_mars:2>],
																[<refinedstorage:quartz_enriched_iron>,<galacticraftplanets:item_basic_mars:2>,<refinedstorage:quartz_enriched_iron>]]);//MACHINE CASING
recipes.addShaped(<refinedstorage:storage_part:0>,[[<appliedenergistics2:material:0>,<refinedstorage:quartz_enriched_iron>,<appliedenergistics2:material:0>],
																[<appliedenergistics2:quartz_glass>,<actuallyadditions:item_crystal:0>,<appliedenergistics2:quartz_glass>],
																[<appliedenergistics2:material:0>,<appliedenergistics2:quartz_glass>,<appliedenergistics2:material:0>]]);//1K STORAGE PART
recipes.addShaped(<refinedstorage:grid:0>,[[<refinedstorage:processor:4>,<refinedstorage:core:0>,<appliedenergistics2:quartz_glass>],
																[<refinedstorage:quartz_enriched_iron>,<refinedstorage:machine_casing>,<appliedenergistics2:quartz_glass>],
																[<refinedstorage:processor:4>,<refinedstorage:core:1>,<appliedenergistics2:quartz_glass>]]);//GRID
recipes.addShaped(<refinedstorage:pattern>,[[<appliedenergistics2:quartz_glass>,<actuallyadditions:item_crystal:0>,<appliedenergistics2:quartz_glass>],
																[<actuallyadditions:item_crystal:0>,<appliedenergistics2:quartz_glass>,<actuallyadditions:item_crystal:0>],
																[<refinedstorage:quartz_enriched_iron>,<refinedstorage:quartz_enriched_iron>,<refinedstorage:quartz_enriched_iron>]]);//PATTERN
recipes.addShaped(<appliedenergistics2:memory_card>,[[null,null,null],
																[<refinedstorage:processor:3>,<minecraft:iron_ingot>,<minecraft:iron_ingot>],
																[<minecraft:gold_ingot>,<minecraft:redstone>,<minecraft:gold_ingot>]]);//MEMORY CARD
recipes.addShaped(<appliedenergistics2:wireless_access_point>,[[null,<appliedenergistics2:material:41>,null],
																[null,<refinedstorage:processor:3>,null],
																[null,<appliedenergistics2:part:16>,null]]);//WIRELESS ACCESS POINT
recipes.addShaped(<appliedenergistics2:part:360>,[[<appliedenergistics2:part:380>,<ore:workbench>,null],
																[<refinedstorage:processor:3>,null,null],
																[null,null,null]]);//CRAFTING TERMINAL
recipes.addShaped(<appliedenergistics2:crafting_unit>,[[<refinedstorage:quartz_enriched_iron>,<refinedstorage:processor:3>,<refinedstorage:quartz_enriched_iron>],
																[<appliedenergistics2:part:16>,<refinedstorage:processor:4>,<appliedenergistics2:part:16>],
																[<refinedstorage:quartz_enriched_iron>,<refinedstorage:processor:3>,<refinedstorage:quartz_enriched_iron>]]);//CRAFTING UNIT
recipes.addShaped(<appliedenergistics2:material:38>,[[<minecraft:glowstone_dust>,<refinedstorage:processor:3>,<minecraft:glowstone_dust>],
																[<appliedenergistics2:material:37>,<appliedenergistics2:quartz_glass>,<appliedenergistics2:material:37>],
																[<minecraft:glowstone_dust>,<appliedenergistics2:material:37>,<minecraft:glowstone_dust>]]);//64K STORAGE COMPONENT
recipes.addShaped(<appliedenergistics2:material:36>,[[<minecraft:redstone>,<refinedstorage:processor:3>,<minecraft:redstone>],
																[<appliedenergistics2:material:35>,<appliedenergistics2:quartz_glass>,<appliedenergistics2:material:35>],
																[<minecraft:redstone>,<appliedenergistics2:material:35>,<minecraft:redstone>]]);//4K STORAGE COMPONENT
recipes.addShaped(<appliedenergistics2:material:37>,[[<minecraft:glowstone_dust>,<refinedstorage:processor:3>,<minecraft:glowstone_dust>],
																[<appliedenergistics2:material:36>,<appliedenergistics2:quartz_glass>,<appliedenergistics2:material:36>],
																[<minecraft:glowstone_dust>,<appliedenergistics2:material:36>,<minecraft:glowstone_dust>]]);//16K STORAGE COMPONENT
recipes.addShaped(<appliedenergistics2:material:57>,[[<minecraft:dye:4>,<refinedstorage:processor:3>,<minecraft:dye:4>],
																[<appliedenergistics2:material:56>,<appliedenergistics2:quartz_glass>,<appliedenergistics2:material:56>],
																[<minecraft:dye:4>,<appliedenergistics2:material:56>,<minecraft:dye:4>]]);//64K FLUID STORAGE COMPONENT
recipes.addShaped(<appliedenergistics2:material:56>,[[<minecraft:dye:4>,<refinedstorage:processor:3>,<minecraft:dye:4>],
																[<appliedenergistics2:material:55>,<appliedenergistics2:quartz_glass>,<appliedenergistics2:material:55>],
																[<minecraft:dye:4>,<appliedenergistics2:material:55>,<minecraft:dye:4>]]);//16K FLUID STORAGE COMPONENT
recipes.addShaped(<appliedenergistics2:material:55>,[[<minecraft:dye:4>,<refinedstorage:processor:3>,<minecraft:dye:4>],
																[<appliedenergistics2:material:54>,<appliedenergistics2:quartz_glass>,<appliedenergistics2:material:54>],
																[<minecraft:dye:4>,<appliedenergistics2:material:54>,<minecraft:dye:4>]]);//4K FLUID STORAGE COMPONENT
recipes.addShaped(<appliedenergistics2:dense_energy_cell>,[[<appliedenergistics2:energy_cell>,<appliedenergistics2:energy_cell>,<appliedenergistics2:energy_cell>],
																[<appliedenergistics2:energy_cell>,<refinedstorage:processor:3>,<appliedenergistics2:energy_cell>],
																[<appliedenergistics2:energy_cell>,<appliedenergistics2:energy_cell>,<appliedenergistics2:energy_cell>]]);//DENSE ENERGY CELL
recipes.addShaped(<appliedenergistics2:cell_workbench>,[[<ore:wool>,<refinedstorage:processor:3>,<ore:wool>],
																[<appliedenergistics2:material:56>,<ore:chestWood>,<appliedenergistics2:material:56>],
																[<refinedstorage:quartz_enriched_iron>,<refinedstorage:quartz_enriched_iron>,<refinedstorage:quartz_enriched_iron>]]);//CELL WORKBENCH
recipes.addShaped(<appliedenergistics2:material:25>,[[<minecraft:gold_ingot>,<refinedstorage:quartz_enriched_iron>,null],
																[<minecraft:redstone>,<refinedstorage:processor:3>,<refinedstorage:quartz_enriched_iron>],
																[<minecraft:gold_ingot>,<refinedstorage:quartz_enriched_iron>,null]]);//BASIC CARD
recipes.addShaped(<appliedenergistics2:material:28>,[[<minecraft:diamond>,<refinedstorage:quartz_enriched_iron>,null],
																[<minecraft:redstone>,<refinedstorage:processor:3>,<refinedstorage:quartz_enriched_iron>],
																[<minecraft:diamond>,<refinedstorage:quartz_enriched_iron>,null]]);//ADVANCED CARD
recipes.addShaped(<appliedenergistics2:biometric_card>,[[null,null,null],
																[<refinedstorage:processor:5>,<minecraft:iron_ingot>,<minecraft:iron_ingot>],
																[<minecraft:gold_ingot>,<minecraft:redstone>,<minecraft:gold_ingot>]]);//BIOMETRIC CARD
recipes.addShaped(<appliedenergistics2:part:460>,[[null,<refinedstorage:quartz_enriched_iron>,null],
																[<refinedstorage:quartz_enriched_iron>,<refinedstorage:processor:5>,<refinedstorage:quartz_enriched_iron>],
																[<ore:gemFluix>,<ore:gemFluix>,<ore:gemFluix>]]);//P2P TUNNEL
recipes.addShaped(<appliedenergistics2:part:460>,[[null,<refinedstorage:quartz_enriched_iron>,null],
																[<refinedstorage:quartz_enriched_iron>,<refinedstorage:processor:5>,<refinedstorage:quartz_enriched_iron>],
																[<ore:crystalPureFluix>,<ore:crystalPureFluix>,<ore:crystalPureFluix>]]);//P2P TUNNEL
recipes.addShaped(<appliedenergistics2:material:34>,[[<minecraft:glowstone_dust>,<appliedenergistics2:material:33>,<minecraft:glowstone_dust>],
																[<appliedenergistics2:material:33>,<refinedstorage:processor:5>,<appliedenergistics2:material:33>],
																[<minecraft:glowstone_dust>,<appliedenergistics2:material:33>,<minecraft:glowstone_dust>]]);//128^3 SPATIAL STORAGE COMPONENT
recipes.addShaped(<appliedenergistics2:material:33>,[[<minecraft:glowstone_dust>,<appliedenergistics2:material:32>,<minecraft:glowstone_dust>],
																[<appliedenergistics2:material:32>,<refinedstorage:processor:5>,<appliedenergistics2:material:32>],
																[<minecraft:glowstone_dust>,<appliedenergistics2:material:32>,<minecraft:glowstone_dust>]]);//16^3 SPATIAL STORAGE COMPONENT
recipes.addShaped(<appliedenergistics2:material:32>,[[<minecraft:glowstone_dust>,<appliedenergistics2:material:9>,<minecraft:glowstone_dust>],
																[<appliedenergistics2:material:9>,<refinedstorage:processor:5>,<appliedenergistics2:material:9>],
																[<minecraft:glowstone_dust>,<appliedenergistics2:material:9>,<minecraft:glowstone_dust>]]);//2^3 SPATIAL STORAGE COMPONENT
recipes.addShaped(<appliedenergistics2:drive>,[[<refinedstorage:quartz_enriched_iron>,<refinedstorage:processor:5>,<refinedstorage:quartz_enriched_iron>],
																[<appliedenergistics2:part:16>,null,<appliedenergistics2:part:16>],
																[<refinedstorage:quartz_enriched_iron>,<refinedstorage:processor:5>,<refinedstorage:quartz_enriched_iron>]]);//ME DRIVE
recipes.addShaped(<appliedenergistics2:spatial_io_port>,[[<ore:blockGlass>,<ore:blockGlass>,<ore:blockGlass>],
																[<appliedenergistics2:part:16>,<appliedenergistics2:io_port>,<appliedenergistics2:part:16>],
																[<refinedstorage:quartz_enriched_iron>,<refinedstorage:processor:5>,<refinedstorage:quartz_enriched_iron>]]);//SPATIAL IO PORT
recipes.addShaped(<appliedenergistics2:security_station>,[[<refinedstorage:quartz_enriched_iron>,<appliedenergistics2:chest>,<refinedstorage:quartz_enriched_iron>],
																[<appliedenergistics2:part:16>,<appliedenergistics2:material:37>,<appliedenergistics2:part:16>],
																[<refinedstorage:quartz_enriched_iron>,<refinedstorage:processor:5>,<refinedstorage:quartz_enriched_iron>]]);//SECURITY TERMINAL
recipes.addShaped(<appliedenergistics2:quantum_ring>,[[<refinedstorage:quartz_enriched_iron>,<refinedstorage:processor:4>,<refinedstorage:quartz_enriched_iron>],
																[<refinedstorage:processor:5>,<appliedenergistics2:energy_cell>,<appliedenergistics2:part:76>],
																[<refinedstorage:quartz_enriched_iron>,<refinedstorage:processor:4>,<refinedstorage:quartz_enriched_iron>]]);//QUANTUM RING
recipes.addShaped(<appliedenergistics2:controller>,[[<appliedenergistics2:smooth_sky_stone_block>,<appliedenergistics2:material:12>,<appliedenergistics2:smooth_sky_stone_block>],
																[<appliedenergistics2:material:12>,<refinedstorage:processor:5>,<appliedenergistics2:material:12>],
																[<appliedenergistics2:smooth_sky_stone_block>,<appliedenergistics2:material:12>,<appliedenergistics2:smooth_sky_stone_block>]]);//ME CONTROLLER
recipes.addShaped(<appliedenergistics2:material:35>,[[<minecraft:redstone>,<appliedenergistics2:material:0>,<minecraft:redstone>],
																[<appliedenergistics2:material:0>,<refinedstorage:processor:4>,<appliedenergistics2:material:0>],
																[<minecraft:redstone>,<appliedenergistics2:material:0>,<minecraft:redstone>]]);//1K STORAGE
recipes.addShaped(<appliedenergistics2:material:54>,[[<minecraft:dye:4>,<appliedenergistics2:material:0>,<minecraft:dye:4>],
																[<appliedenergistics2:material:0>,<refinedstorage:processor:4>,<appliedenergistics2:material:0>],
																[<minecraft:dye:4>,<appliedenergistics2:material:0>,<minecraft:dye:4>]]);//1K FLUID STORAGE
recipes.addShaped(<appliedenergistics2:io_port>,[[<ore:blockGlass>,<ore:blockGlass>,<ore:blockGlass>],
																[<appliedenergistics2:drive>,<appliedenergistics2:part:16>,<appliedenergistics2:drive>],
																[<refinedstorage:quartz_enriched_iron>,<refinedstorage:processor:4>,<refinedstorage:quartz_enriched_iron>]]);//IO PORT
recipes.addShaped(<refinedstorage:controller>,[[<refinedstorage:quartz_enriched_iron>,<appliedenergistics2:smooth_sky_stone_block>,<refinedstorage:quartz_enriched_iron>],
																[<appliedenergistics2:smooth_sky_stone_block>,<refinedstorage:processor:5>,<appliedenergistics2:smooth_sky_stone_block>],
																[<refinedstorage:quartz_enriched_iron>,<appliedenergistics2:smooth_sky_stone_block>,<refinedstorage:quartz_enriched_iron>]]);//RS CONTROLLER
recipes.addShaped(<appliedenergistics2:material:41>,[[null,<appliedenergistics2:material:9>,null],
																[<refinedstorage:quartz_enriched_iron>,<appliedenergistics2:part:140>,<refinedstorage:quartz_enriched_iron>],
																[null,<refinedstorage:quartz_enriched_iron>,null]]);//WIRELESS RECEIVER
recipes.addShapeless(<refinedstorage:grid:0>,[<appliedenergistics2:part:380>]);//GRID
recipes.addShapeless(<appliedenergistics2:part:380>,[<refinedstorage:grid:0>]);//
recipes.addShapeless(<refinedstorage:grid:1>,[<appliedenergistics2:part:360>]);//CRAFTING
recipes.addShapeless(<appliedenergistics2:part:360>,[<refinedstorage:grid:1>]);//
recipes.addShapeless(<refinedstorage:grid:2>,[<appliedenergistics2:part:340>]);//PATTERN
recipes.addShapeless(<appliedenergistics2:part:340>,[<refinedstorage:grid:2>]);//
recipes.addShapeless(<refinedstorage:grid:3>,[<appliedenergistics2:part:520>]);//FLUID
recipes.addShapeless(<appliedenergistics2:part:520>,[<refinedstorage:grid:3>]);//
recipes.addShapeless(<appliedenergistics2:network_tool>,[<ore:itemIlluminatedPanel>, <ore:chestWood>, <ore:itemQuartzWrench>, <refinedstorage:processor:3>]);
recipes.addShapeless(<appliedenergistics2:part:280>,[<minecraft:redstone_torch>, <refinedstorage:processor:3>]);//ME LEVEL EMITTER
recipes.addShapeless(<appliedenergistics2:part:281>,[<minecraft:redstone_torch>, <refinedstorage:processor:3>, <ore:dyeBlue>]);//ME FLUID LEVEL EMITTER
recipes.addShapeless(<appliedenergistics2:part:340>,[<appliedenergistics2:part:360>, <refinedstorage:processor:5>]);//PATTERN TERMINAL
recipes.addShapeless(<appliedenergistics2:part:480>,[<ore:itemIlluminatedPanel>, <refinedstorage:processor:5>, <appliedenergistics2:interface>]);//INTERFACE TERMINAL
recipes.addShapeless(<appliedenergistics2:part:520>,[<appliedenergistics2:part:380>, <refinedstorage:processor:4>, <minecraft:dye:4>]);//FLUID TERMINAL
recipes.addShapeless(<appliedenergistics2:part:380>,[<ore:itemIlluminatedPanel>, <refinedstorage:processor:4>, <appliedenergistics2:material:43>, <appliedenergistics2:material:44>]);//TERMINAL
recipes.addShapeless(<appliedenergistics2:material:43>*2,[<ore:gemCertusQuartz>, <refinedstorage:processor:4>, <appliedenergistics2:material:8>]);//FORMATION CORE
recipes.addShapeless(<appliedenergistics2:material:44>*2,[<ore:gemQuartz>, <refinedstorage:processor:4>, <appliedenergistics2:material:8>]);//ANNIHILATION CORE
recipes.addShapeless(<appliedenergistics2:crafting_accelerator>,[<appliedenergistics2:crafting_unit>, <refinedstorage:processor:5>]);//CRAFTING COPROCESSOR
mods.thermalexpansion.InductionSmelter.addRecipe(<refinedstorage:quartz_enriched_iron>*4, <minecraft:iron_ingot> * 4, <botania:quartztypered:0> * 4, 10000);
mods.thermalexpansion.InductionSmelter.addRecipe(<appliedenergistics2:sky_stone_block>*2, <minecraft:end_stone>, <galacticraftcore:basic_block_moon:5>, 2500);//SKY STONE
mods.thermalexpansion.Sawmill.addRecipe(<refinedstorage:processor_binding>, <refinedstorage:silicon>, 5000);
mods.thermalexpansion.Sawmill.addRecipe(<refinedstorage:processor_binding>, <galacticraftcore:basic_item:2>, 5000);
mods.thermalexpansion.Sawmill.addRecipe(<refinedstorage:processor_binding>, <appliedenergistics2:material:5>, 5000);
mods.thermalexpansion.Sawmill.addRecipe(<refinedstorage:processor_binding>, <nuclearcraft:gem:6>, 5000);
mods.thermalexpansion.Sawmill.addRecipe(<refinedstorage:processor_binding>, <refinedstorage:silicon>, 5000);