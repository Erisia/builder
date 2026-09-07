import mods.actuallyadditions.Crusher;

//Crusher Recipes
//------------------------------------------------------------------------------------------------------------
//REMOVE RECIPES
Crusher.removeRecipe(<thermalfoundation:ore>);
Crusher.removeRecipe(<minecraft:gold_ore>);
Crusher.removeRecipe(<minecraft:iron_ore>);
Crusher.removeRecipe(<thermalfoundation:ore:3>);
Crusher.removeRecipe(<thermalfoundation:ore:2>);
Crusher.removeRecipe(<thermalfoundation:ore:1>);
Crusher.removeRecipe(<draconicevolution:draconium_ore>);
Crusher.removeRecipe(<nuclearcraft:ore:6>);
mods.actuallyadditions.Crusher.removeRecipe(<ic2:dust:7>);
mods.actuallyadditions.Crusher.removeRecipe(<ic2:dust:4>);
mods.actuallyadditions.Crusher.removeRecipe(<ic2:dust:8>);
mods.actuallyadditions.Crusher.removeRecipe(<ic2:dust:10>);
mods.actuallyadditions.Crusher.removeRecipe(<ic2:dust:14>);
mods.actuallyadditions.Crusher.removeRecipe(<ic2:dust:17>);
mods.actuallyadditions.Crusher.removeRecipe(<thermalfoundation:material>);
mods.actuallyadditions.Crusher.removeRecipe(<thermalfoundation:material:1>);
mods.actuallyadditions.Crusher.removeRecipe(<thermalfoundation:material:64>);
mods.actuallyadditions.Crusher.removeRecipe(<thermalfoundation:material:65>);
mods.actuallyadditions.Crusher.removeRecipe(<thermalfoundation:material:66>);
mods.actuallyadditions.Crusher.removeRecipe(<thermalfoundation:material:67>);
mods.actuallyadditions.Crusher.removeRecipe(<mekanism:dust>);
mods.actuallyadditions.Crusher.removeRecipe(<actuallyadditions:item_dust>);
mods.actuallyadditions.Crusher.removeRecipe(<immersiveengineering:metal:18>);
mods.actuallyadditions.Crusher.removeRecipe(<bloodmagic:component:19>);
mods.actuallyadditions.Crusher.removeRecipe(<bloodmagic:component:20>);
mods.actuallyadditions.Crusher.removeRecipe(<astralsorcery:itemcraftingcomponent:2>);
mods.actuallyadditions.Crusher.removeRecipe(<ic2:dust:5>*6);
//ADD RECIPES
Crusher.addRecipe(<thermalfoundation:material:64>,<thermalfoundation:ore>,<ic2:dust:19>*2,100);//COPPER
Crusher.addRecipe(<thermalfoundation:material>,<minecraft:iron_ore>,<ic2:dust:21>*2,100);//IRON
Crusher.addRecipe(<thermalfoundation:material:1>,<minecraft:gold_ore>,<ic2:dust:20>*2,100);//GOLD
Crusher.addRecipe(<thermalfoundation:material:67>,<thermalfoundation:ore:3>,<ic2:dust:23>*2,100);//LEAD
Crusher.addRecipe(<thermalfoundation:material:66>,<thermalfoundation:ore:2>,<ic2:dust:26>*2,100);//SILVER
Crusher.addRecipe(<thermalfoundation:material:65>,<thermalfoundation:ore:1>,<ic2:dust:28>*2,100);//TIN
Crusher.addRecipe(<thermalfoundation:material:1>, <minecraft:gold_ingot>);//GOLD DUST
Crusher.addRecipe(<thermalfoundation:material:66>, <thermalfoundation:material:130>);//SILVER DUST
Crusher.addRecipe(<astralsorcery:itemcraftingcomponent:2>, <astralsorcery:itemcraftingcomponent:1>);//STARDUST
Crusher.addRecipe(<thermalfoundation:material:67>, <ore:ingotLead>);//LEAD DUST
//------------------------------------------------------------------------------------------------------------

//RECIPES
//------------------------------------------------------------------------------------------------------------
//REMOVE RECIPES
recipes.remove(<actuallyadditions:block_atomic_reconstructor>);//ATOMIC RECONSTRUCTOR
recipes.remove(<actuallyadditions:block_misc:9>);//IRON CASING
recipes.remove(<actuallyadditions:block_grinder>);//GRINDER
recipes.remove(<actuallyadditions:block_furnace_double>);//DOUBLE FURNACE
recipes.remove(<actuallyadditions:block_coal_generator>); //REMOVE COAL GEN
recipes.remove(<actuallyadditions:item_drill:3>);// REMOVE DRILL
recipes.remove(<actuallyadditions:item_misc:16>);//REMOVE DRILL CORE
recipes.remove(<actuallyadditions:item_misc:8>);//ADVANCED COILS
recipes.remove(<actuallyadditions:block_display_stand>);//DISPLAY STAND
recipes.remove(<actuallyadditions:block_empowerer>);//EMPOWERER
recipes.remove(<actuallyadditions:block_miner>);//VERTICAL DIGGER
recipes.remove(<actuallyadditions:item_wings_of_the_bats>);//WINGS OF THE BATS
recipes.remove(<actuallyadditions:block_oil_generator>);//OIL GENERATOR
recipes.remove(<actuallyadditions:block_farmer>);//FARMER
recipes.remove(<actuallyadditions:block_giant_chest>);//SMALL CRATE
recipes.remove(<actuallyadditions:wooden_paxel>);//
recipes.remove(<actuallyadditions:stone_paxel>);//
recipes.remove(<actuallyadditions:iron_paxel>);//
recipes.remove(<actuallyadditions:gold_paxel>);//
recipes.remove(<actuallyadditions:diamond_paxel>);//
recipes.remove(<actuallyadditions:emerald_paxel>);//
recipes.remove(<actuallyadditions:item_paxel_crystal_red>);//
recipes.remove(<actuallyadditions:item_paxel_crystal_blue>);//
recipes.remove(<actuallyadditions:item_paxel_crystal_black>);//
recipes.remove(<actuallyadditions:item_paxel_crystal_white>);//
recipes.remove(<actuallyadditions:item_paxel_crystal_green>);//
recipes.remove(<actuallyadditions:item_paxel_crystal_light_blue>);//
recipes.remove(<actuallyadditions:obsidian_paxel>);//
recipes.remove(<actuallyadditions:quartz_paxel>);//
recipes.remove(<actuallyadditions:item_bag>);//SACK
recipes.remove(<actuallyadditions:item_mining_lens>);//MINING LENS
recipes.remove(<actuallyadditions:item_pickaxe_emerald>);//EMERALD PICKAXE
recipes.remove(<actuallyadditions:item_sword_emerald>);//EMERALD PICKAXE
recipes.remove(<actuallyadditions:item_axe_emerald>);//EMERALD PICKAXE
recipes.remove(<actuallyadditions:item_shovel_emerald>);//EMERALD PICKAXE
recipes.remove(<actuallyadditions:item_hoe_emerald>);//EMERALD PICKAXE
mods.actuallyadditions.Empowerer.removeRecipe(<actuallyadditions:item_crystal_empowered:2>);
mods.actuallyadditions.Empowerer.removeRecipe(<actuallyadditions:block_crystal_empowered:2>);
mods.actuallyadditions.Empowerer.removeRecipe(<actuallyadditions:item_crystal_empowered:1>);
mods.actuallyadditions.Empowerer.removeRecipe(<actuallyadditions:block_crystal_empowered:1>);
//ADD RECIPES
recipes.addShaped(<actuallyadditions:block_atomic_reconstructor>,[[<contenttweaker:duskstone_ingot>,<minecraft:redstone>,<contenttweaker:duskstone_ingot>],
																[<minecraft:redstone>,<botania:spreader:1>,<minecraft:redstone>],
																[<contenttweaker:duskstone_ingot>,<actuallyadditions:block_misc:9>,<contenttweaker:duskstone_ingot>]]);

recipes.addShaped(<actuallyadditions:block_misc:9>,[[<ore:plateIron>,<sonarcore:reinforcedstoneblock>,<ore:plateIron>],
												   [<sonarcore:reinforcedstoneblock>,<actuallyadditions:item_misc:5>,<sonarcore:reinforcedstoneblock>],
												   [<ore:plateIron>,<sonarcore:reinforcedstoneblock>,<ore:plateIron>]]);

recipes.addShaped(<actuallyadditions:block_grinder>,[[<actuallyadditions:item_crystal>,<calculator:shardamethyst>,<contenttweaker:mixed_brick_block>],
													[<actuallyadditions:item_misc:7>,<actuallyadditions:block_misc:9>,<actuallyadditions:item_misc:7>],
													[<contenttweaker:mixed_brick_block>,<calculator:shardamethyst>,<actuallyadditions:item_crystal>]]);

recipes.addShaped(<actuallyadditions:block_furnace_double>,[[<contenttweaker:bedrock_crystal>,<actuallyadditions:item_misc:7>,<contenttweaker:mixed_brick_block>],
													[<minecraft:furnace>,<actuallyadditions:block_misc:9>,<minecraft:furnace>],
													[<contenttweaker:mixed_brick_block>,<actuallyadditions:item_misc:7>,<contenttweaker:bedrock_crystal>]]);

recipes.addShaped(<actuallyadditions:block_coal_generator>,[[<ore:cobblestone>,<ore:coal>,<ore:cobblestone>],
														  [<contenttweaker:mixed_brick_block>,<actuallyadditions:block_misc:9>,<contenttweaker:mixed_brick_block>],
														  [<ore:cobblestone>,<contenttweaker:bedrock_crystal>,<ore:cobblestone>]]);

recipes.addShaped(<actuallyadditions:item_drill:3>.withTag({Energy: 0}),[[<actuallyadditions:block_crystal:2>,<actuallyadditions:block_crystal:2>,<actuallyadditions:block_crystal:2>],
																		[<actuallyadditions:item_misc:8>,<actuallyadditions:item_misc:16>,<actuallyadditions:item_misc:8>],
																		[<actuallyadditions:block_crystal:5>,<actuallyadditions:block_crystal:5>,<actuallyadditions:block_crystal:5>]]); //ADD DRILL

recipes.addShaped(<actuallyadditions:item_misc:16>,[[<ic2:plate:12>,<actuallyadditions:item_misc:7>,<ic2:plate:12>],
												   [<actuallyadditions:item_misc:8>,<actuallyadditions:item_crystal>,<actuallyadditions:item_misc:8>],
												   [<ic2:plate:12>,<actuallyadditions:item_misc:7>,<ic2:plate:12>]]); //ADD DRILL CORE

recipes.addShapeless(<actuallyadditions:item_drill:3>,[<ic2:diamond_drill:26>]);

recipes.addShaped(<actuallyadditions:item_misc:8>,[[<actuallyadditions:item_crystal>,<calculator:enrichedgoldingot>,<actuallyadditions:item_crystal>],
												  [<calculator:enrichedgoldingot>,<actuallyadditions:item_misc:7>,<calculator:enrichedgoldingot>],
												  [<actuallyadditions:item_crystal>,<calculator:enrichedgoldingot>,<actuallyadditions:item_crystal>]]); //ADVANCED COIL

recipes.addShaped(<actuallyadditions:block_display_stand>,[[<ic2:crafting:5>,<actuallyadditions:item_misc:8>,<ic2:crafting:5>],
														 [<actuallyadditions:block_testifi_bucks_green_wall>,<actuallyadditions:block_testifi_bucks_green_wall>,<actuallyadditions:block_testifi_bucks_green_wall>],
														 [<actuallyadditions:block_testifi_bucks_white_wall>,<ic2:te:73>,<actuallyadditions:block_testifi_bucks_white_wall>]]);//DISPLAY STAND

recipes.addShaped(<actuallyadditions:block_display_stand>,[[null,<actuallyadditions:item_misc:8>,null],
														 [<actuallyadditions:block_testifi_bucks_green_wall>,<actuallyadditions:block_testifi_bucks_green_wall>,<actuallyadditions:block_testifi_bucks_green_wall>],
														 [<actuallyadditions:block_testifi_bucks_white_wall>,<thermalexpansion:cell>.withTag({Recv: 1000, RSControl: 0 as byte, Facing: 3 as byte, Energy: 0, SideCache: [2, 1, 1, 1, 1, 1] as byte[] as byte[], Level: 0 as byte, Send: 1000}),<actuallyadditions:block_testifi_bucks_white_wall>]]);//DISPLAY STAND

recipes.addShaped(<actuallyadditions:block_empowerer>,[[<ic2:dust:11>,<actuallyadditions:item_crystal>,<ic2:dust:11>],
													  [<ic2:charging_re_battery>.withTag({charge: 40000.0}),<actuallyadditions:item_battery_double>.withTag({Energy: 350000}),<ic2:charging_re_battery>.withTag({charge: 40000.0})],
													  [<actuallyadditions:block_misc:9>,<actuallyadditions:block_display_stand>,<actuallyadditions:block_misc:9>]]);//EMPOWERER

recipes.addShaped(<actuallyadditions:block_empowerer>,[[<thermalfoundation:material:98>,<actuallyadditions:item_crystal>,<thermalfoundation:material:98>],
													  [<thermalexpansion:capacitor>.withTag({Active: 0 as byte, Energy: 0}),<actuallyadditions:item_battery_double>.withTag({Energy: 350000}),<thermalexpansion:capacitor>.withTag({Active: 0 as byte, Energy: 0})],
													  [<actuallyadditions:block_misc:9>,<actuallyadditions:block_display_stand>,<actuallyadditions:block_misc:9>]]);//EMPOWERER

recipes.addShaped(<actuallyadditions:block_miner>,[[<actuallyadditions:block_misc:9>,<botania:rfgenerator>,<actuallyadditions:block_misc:9>],
													[<botania:rfgenerator>,<actuallyadditions:block_crystal:3>,<botania:rfgenerator>],
													[<actuallyadditions:block_misc:9>,<actuallyadditions:item_drill:3>,<actuallyadditions:block_misc:9>]]);//VERTICAL DIGGER

recipes.addShaped(<actuallyadditions:block_oil_generator>,[[<minecraft:iron_ingot>,<actuallyadditions:block_misc:9>,<minecraft:iron_ingot>],
																[<ore:ingotSteel>,<actuallyadditions:item_misc:13>,<ore:ingotSteel>],
																[<minecraft:iron_ingot>,<actuallyadditions:block_misc:9>,<minecraft:iron_ingot>]]);//OIL GENERATOR
//FARMER
recipes.addShaped(<actuallyadditions:block_farmer>, [[<actuallyadditions:block_crystal:5>,<forestry:thermionic_tubes:5>,<actuallyadditions:block_crystal:5>],
													 [<forestry:fruits:1>,<actuallyadditions:block_misc:9>,<forestry:fruits:1>],
													 [<actuallyadditions:block_crystal:5>,<forestry:thermionic_tubes:5>,<actuallyadditions:block_crystal:5>]]);
recipes.addShaped(<actuallyadditions:block_giant_chest>, [[<ore:chestWood>,<actuallyadditions:item_crystal:5>,<ore:chestWood>],
													 [<ore:plankWood>,<ironchest:iron_chest:4>,<ore:plankWood>],
													 [<ore:chestWood>,<actuallyadditions:item_crystal:5>,<ore:chestWood>]]);//SMALL CRATE
recipes.addShaped(<actuallyadditions:item_bag>, [[<botania:manaresource:16>,<minecraft:leather>,<botania:manaresource:16>],
													 [<botania:manaresource:16>,<ironbackpacks:backpack>.withTag({packInfo: {upgrade: [], type: "ironbackpacks:iron", spec: "STORAGE"}}),<botania:manaresource:16>],
													 [<minecraft:leather>,<actuallyadditions:block_crystal:3>,<minecraft:leather>]]);//SACK
recipes.addShaped(<actuallyadditions:item_mining_lens>, [[<contenttweaker:empowered_aluminium_ingot>,<contenttweaker:empowered_gold_ingot>,<ore:ingotMeteoricIron>],
													 [<contenttweaker:empowered_copper_ingot>,<actuallyadditions:item_misc:18>,<contenttweaker:empowered_steel_ingot>],
													 [<galacticraftcore:item_basic_moon:2>,<contenttweaker:empowered_silver_ingot>,<contenttweaker:empowered_lead_ingot>]]);//LENS OF THE MINER
//AIOTS
recipes.addShapeless(<actuallyadditions:item_paxel_crystal_red>,[<actuallyadditions:item_shovel_crystal_red>, <actuallyadditions:item_pickaxe_crystal_red>, <actuallyadditions:item_sword_crystal_red>, <actuallyadditions:item_axe_crystal_red> ,<actuallyadditions:item_hoe_crystal_red>, <contenttweaker:tool_core>]);//RESTONIA AIOT
recipes.addShapeless(<actuallyadditions:item_paxel_crystal_black>,[<actuallyadditions:item_shovel_crystal_black>, <actuallyadditions:item_pickaxe_crystal_black>, <actuallyadditions:item_sword_crystal_black>, <actuallyadditions:item_axe_crystal_black> ,<actuallyadditions:item_hoe_crystal_black>, <contenttweaker:tool_core>]);
recipes.addShapeless(<actuallyadditions:item_paxel_crystal_blue>,[<actuallyadditions:item_shovel_crystal_blue>, <actuallyadditions:item_pickaxe_crystal_blue>, <actuallyadditions:item_sword_crystal_blue>, <actuallyadditions:item_axe_crystal_blue> ,<actuallyadditions:item_hoe_crystal_blue>, <contenttweaker:tool_core>]);
recipes.addShapeless(<actuallyadditions:item_paxel_crystal_green>,[<actuallyadditions:item_shovel_crystal_green>, <actuallyadditions:item_pickaxe_crystal_green>, <actuallyadditions:item_sword_crystal_green>, <actuallyadditions:item_axe_crystal_green> ,<actuallyadditions:item_hoe_crystal_green>, <contenttweaker:tool_core>]);
recipes.addShapeless(<actuallyadditions:item_paxel_crystal_light_blue>,[<actuallyadditions:item_shovel_crystal_light_blue>, <actuallyadditions:item_pickaxe_crystal_light_blue>, <actuallyadditions:item_sword_crystal_light_blue>, <actuallyadditions:item_axe_crystal_light_blue> ,<actuallyadditions:item_hoe_crystal_light_blue>, <contenttweaker:tool_core>]);
recipes.addShapeless(<actuallyadditions:item_paxel_crystal_white>,[<actuallyadditions:item_shovel_crystal_white>, <actuallyadditions:item_pickaxe_crystal_white>, <actuallyadditions:item_sword_crystal_white>, <actuallyadditions:item_axe_crystal_white> ,<actuallyadditions:item_hoe_crystal_white>, <contenttweaker:tool_core>]);
recipes.addShapeless(<actuallyadditions:block_oil_generator>,[<actuallyadditions:block_oil_generator:*>]);
recipes.addShapeless(<xreliquary:mob_ingredient:5>,[<actuallyadditions:item_misc:15>]);
mods.actuallyadditions.Empowerer.addRecipe(<actuallyadditions:item_crystal_empowered:2>, <actuallyadditions:item_crystal:2>, <minecraft:clay>, <ore:dyeLightBlue>, <quark:crystal:5>, <minecraft:ice>, 7500, 75, [0.0, 0.9, 0.9]);
mods.actuallyadditions.Empowerer.addRecipe(<actuallyadditions:block_crystal_empowered:2>, <actuallyadditions:block_crystal:2>, <minecraft:clay>, <ore:dyeLightBlue>, <quark:crystal:5>, <minecraft:ice>, 50000, 500, [0.0, 0.9, 0.9]);
mods.actuallyadditions.Empowerer.addRecipe(<actuallyadditions:item_crystal_empowered:1>, <actuallyadditions:item_crystal:1>, <mysticalagriculture:water_essence>, <ore:dyeCyan>, <quark:crystal:6>, <minecraft:prismarine_shard>, 4000, 75, [0.2, 0.2, 0.9]);
mods.actuallyadditions.Empowerer.addRecipe(<actuallyadditions:block_crystal_empowered:1>, <actuallyadditions:block_crystal:1>, <mysticalagriculture:water_essence>, <ore:dyeCyan>, <quark:crystal:6>, <minecraft:prismarine_shard>, 30000, 500, [0.2, 0.2, 0.9]);
mods.actuallyadditions.Empowerer.addRecipe(<contenttweaker:singular_torsion_power_gearbox>, <contenttweaker:power_gearbox>, <ore:plateSignalum>, <ore:plateCarbon>, <ore:plateSignalum>, <ore:plateCarbon>, 30000, 500, [0.9, 0.0, 0.0]);
mods.actuallyadditions.Empowerer.addRecipe(<contenttweaker:singular_torsion_speed_gearbox>, <contenttweaker:speed_gearbox>, <ore:plateEnderium>, <ore:plateCarbon>, <ore:plateEnderium>, <ore:plateCarbon>, 30000, 500, [0.0, 0.0, 0.9]);
mods.actuallyadditions.Empowerer.addRecipe(<contenttweaker:singular_torsion_double_gearbox>, <contenttweaker:double_gearbox>, <ore:ingotRefinedObsidian>, <ore:gemWhiteGem>, <ore:ingotRefinedObsidian>, <ore:gemWhiteGem>, 30000, 500, [0.7, 0.0, 0.9]);
//--------------------------------------------------------------------------------------------------------------