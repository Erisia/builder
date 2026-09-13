//RECIPES
//------------------------------------------------------------------------------------------------------------
//REMOVE RECIPES
recipes.remove(<galacticraftcore:machine2:4>);//CIRCUIT FABRICATOR
recipes.remove(<galacticraftcore:machine:12>);//COMPRESSOR
recipes.remove(<galacticraftcore:machine2>);//ELECTRIC COMPRESSOR
recipes.remove(<galacticraftcore:rocket_workbench>);//NASA WORKBENCH
recipes.remove(<galacticraftcore:rocket_fins>);//ROCKET FINS
recipes.remove(<galacticraftcore:engine>);//ROCKET ENGINE
recipes.remove(<galacticraftplanets:carbon_fragments>);//FRAMGENTED CARBON
recipes.remove(<galacticraftcore:machine:0>);//COAL GENERATOR
recipes.remove(<galacticraftcore:air_vent>);//OXYGEN VENT
recipes.remove(<galacticraftcore:oxygen_compressor:0>);//OXYGEN COMPRESSOR
recipes.remove(<galacticraftcore:fuel_loader>);//FUEL LOADER
recipes.remove(<galacticraftcore:machine2:12>);//DECONSTRUCTOR
recipes.remove(<galacticraftplanets:item_basic_asteroids:9>);//TITANIUM DUST
recipes.remove(<galacticraftcore:oxygen_compressor:4>);//OXYGEN DECOMPRESSOR
recipes.remove(<galacticraftcore:machine2:8>);//OXYGEN STORAGE
recipes.remove(<galacticraftcore:aluminum_wire>);//WIRE
//ADD RECIPES
recipes.addShaped(<galacticraftcore:machine2:4>,[[<contenttweaker:empowered_steel_ingot>,<contenttweaker:empowered_gold_ingot>,<contenttweaker:empowered_steel_ingot>],
												 [<contenttweaker:empowered_copper_ingot>,<ic2:resource:13>,<contenttweaker:empowered_copper_ingot>],
												 [<contenttweaker:empowered_silver_ingot>,<contenttweaker:empowered_gold_ingot>,<contenttweaker:empowered_silver_ingot>]]);//CIRCUIT FABRICATOR

recipes.addShaped(<galacticraftcore:machine:12>,[[<contenttweaker:empowered_steel_ingot>,<minecraft:anvil>,<contenttweaker:empowered_steel_ingot>],
												 [<contenttweaker:empowered_steel_ingot>,<ore:ingotBronze>,<contenttweaker:empowered_steel_ingot>],
												 [<contenttweaker:empowered_steel_ingot>,<galacticraftcore:basic_item:13>,<contenttweaker:empowered_steel_ingot>]]);//COMPRESSOR

recipes.addShaped(<galacticraftcore:machine2>,[[<galacticraftcore:basic_item:9>,<minecraft:anvil>,<galacticraftcore:basic_item:9>],
											   [<galacticraftcore:basic_item:10>,<galacticraftcore:machine:12>,<galacticraftcore:basic_item:10>],
											   [<contenttweaker:empowered_silver_ingot>,<galacticraftcore:basic_item:14>,<contenttweaker:empowered_silver_ingot>]]);//ELECTRIC COMPRESSOR

recipes.addShaped(<galacticraftcore:rocket_workbench>,[[<contenttweaker:empowered_steel_ingot>,<extrautils2:crafter>,<contenttweaker:empowered_steel_ingot>],
													   [<contenttweaker:empowered_silver_ingot>,<galacticraftcore:basic_item:14>,<contenttweaker:empowered_silver_ingot>],
													   [<galacticraftcore:basic_item:9>,<contenttweaker:empowered_gold_ingot>,<galacticraftcore:basic_item:9>]]);//NASA WORKBENCH

recipes.addShaped(<galacticraftcore:rocket_fins>,[[null,<contenttweaker:empowered_steel_ingot>,null],
												  [<galacticraftcore:heavy_plating>,<contenttweaker:empowered_steel_ingot>,<galacticraftcore:heavy_plating>],
												  [<galacticraftcore:heavy_plating>,null,<galacticraftcore:heavy_plating>]]);//ROCKET FINS

recipes.addShaped(<galacticraftcore:engine>,[[<galacticraftcore:heavy_plating>,<galacticraftcore:canister>,<galacticraftcore:heavy_plating>],
											 [<galacticraftcore:heavy_plating>,<galacticraftcore:air_vent>,<galacticraftcore:heavy_plating>],
											 [<contenttweaker:empowered_lead_ingot>,<contenttweaker:empowered_gold_ingot>,<contenttweaker:empowered_lead_ingot>]]);//ROCKET ENGINE

recipes.addShaped(<galacticraftcore:dungeonfinder>,[[null,<galacticraftcore:basic_block_moon:14>,null],
											 [<galacticraftplanets:mars:7>,<galacticraftplanets:basic_item_venus:2>,<galacticraftplanets:mars:7>],
											 [null,<galacticraftcore:basic_block_moon:14>,null]]);
recipes.addShapeless(<galacticraftplanets:carbon_fragments>*8,[<extraplanets:tier4_items:5>]);
recipes.addShapeless(<galacticraftcore:air_vent>,[<contenttweaker:empowered_gold_ingot>,<ore:compressedTin>,<ore:compressedTin>,<galacticraftcore:basic_item:9>]);//AIR VENT
recipes.addShaped(<galacticraftcore:oxygen_compressor:0>,[[<ore:compressedSteel>,<contenttweaker:empowered_aluminium_ingot>,<ore:compressedSteel>],
											 [<contenttweaker:empowered_aluminium_ingot>,<galacticraftcore:oxygen_concentrator>,<contenttweaker:empowered_aluminium_ingot>],
											 [<ore:compressedSteel>,<ore:compressedBronze>,<ore:compressedSteel>]]);//OXYGEN COMPRESSOR
recipes.addShaped(<galacticraftcore:fuel_loader>,[[<contenttweaker:empowered_copper_ingot>,<contenttweaker:empowered_copper_ingot>,<contenttweaker:empowered_copper_ingot>],
											 [<contenttweaker:empowered_copper_ingot>,<galacticraftcore:canister:0>,<contenttweaker:empowered_copper_ingot>],
											 [<contenttweaker:empowered_lead_ingot>,<galacticraftcore:basic_item:13>,<contenttweaker:empowered_lead_ingot>]]);//FUEL LOADER
recipes.addShapeless(<galacticraftplanets:item_basic_asteroids:9>,[<galacticraftcore:ic2compat:7>,<galacticraftcore:ic2compat:7>,<galacticraftcore:ic2compat:7>,<galacticraftcore:ic2compat:7>]);
recipes.addShaped(<extraplanets:advanced_launch_pad:0>*5,[[null,null,null],
											 [<ore:ingotDesh>,<ore:ingotDesh>,<ore:ingotDesh>],
											 [<ore:plateInvar>,<ore:plateInvar>,<ore:plateInvar>]]);//TIER 2 LAUNCH PAD
//------------------------------------------------------------------------------------------------------------