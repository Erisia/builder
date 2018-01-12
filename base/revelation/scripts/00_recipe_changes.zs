#Name: recipe_changes.zs
#Author: Feed the Beast

print("Initializing 'recipe_changes.zs'...");

#Iridium conversion between TE and IC2.
recipes.addShapeless(<ic2:misc_resource:1>), [<thermalfoundation:wrench>, <thermalfoundation:material:135>]);

#Remove ChunkLoaders (use FTBU to manage chunkloading)
recipes.remove(<ic2:te:82>);
recipes.remove(<opencomputers:upgrade:4>);

#Atempt to fix TiC grout shapless recipe
recipes.addShapeless(<tconstruct:soil> * 2, [<minecraft:sand>, <minecraft:gravel>, <minecraft:clay_ball>]);

#Fix wood gear recipe in grindstone
recipes.remove(<appliedenergistics2:material:40>);

#Remove ExU2 Sickles to prevent overlap with Thermal Foundation Sickles
recipes.remove(<extrautils2:sickle_wood>);
recipes.remove(<extrautils2:sickle_stone>);
recipes.remove(<extrautils2:sickle_iron>);
recipes.remove(<extrautils2:sickle_gold>);
recipes.remove(<extrautils2:sickle_diamond>);

#Changed Bark recipe to prevent overlap with Wood piles
recipes.remove(<quark:bark:5>);
recipes.addShaped(<quark:bark:5> * 2, [[<minecraft:log2:1>, <minecraft:log2:1>, <minecraft:log2:1>], [<minecraft:log2:1>, <minecraft:log2:1>, <minecraft:log2:1>], [<minecraft:log2:1>, <minecraft:log2:1>, <minecraft:log2:1>]]);
recipes.remove(<quark:bark:4>);
recipes.addShaped(<quark:bark:4> * 2, [[<minecraft:log2>, <minecraft:log2>, <minecraft:log2>], [<minecraft:log2>, <minecraft:log2>, <minecraft:log2>], [<minecraft:log2>, <minecraft:log2>, <minecraft:log2>]]);
recipes.remove(<quark:bark:3>);
recipes.addShaped(<quark:bark:3> * 2, [[<minecraft:log:3>, <minecraft:log:3>, <minecraft:log:3>], [<minecraft:log:3>, <minecraft:log:3>, <minecraft:log:3>], [<minecraft:log:3>, <minecraft:log:3>, <minecraft:log:3>]]);
recipes.remove(<quark:bark:2>);
recipes.addShaped(<quark:bark:2> * 2, [[<minecraft:log:2>, <minecraft:log:2>, <minecraft:log:2>], [<minecraft:log:2>, <minecraft:log:2>, <minecraft:log:2>], [<minecraft:log:2>, <minecraft:log:2>, <minecraft:log:2>]]);
recipes.remove(<quark:bark:1>);
recipes.addShaped(<quark:bark:1> * 2, [[<minecraft:log:1>, <minecraft:log:1>, <minecraft:log:1>], [<minecraft:log:1>, <minecraft:log:1>, <minecraft:log:1>], [<minecraft:log:1>, <minecraft:log:1>, <minecraft:log:1>]]);
recipes.remove(<quark:bark>);
recipes.addShaped(<quark:bark> * 2, [[<minecraft:log>, <minecraft:log>, <minecraft:log>], [<minecraft:log>, <minecraft:log>, <minecraft:log>], [<minecraft:log>, <minecraft:log>, <minecraft:log>]]);

#Convert Quark deco adds to vanilla equiv
recipes.addShapeless(<minecraft:trapped_chest>, [<quark:custom_chest_trap:4>]);
recipes.addShapeless(<minecraft:trapped_chest>, [<quark:custom_chest_trap:3>]);
recipes.addShapeless(<minecraft:trapped_chest>, [<quark:custom_chest_trap:2>]);
recipes.addShapeless(<minecraft:trapped_chest>, [<quark:custom_chest_trap:1>]);
recipes.addShapeless(<minecraft:trapped_chest>, [<quark:custom_chest_trap>]);
recipes.addShapeless(<minecraft:chest>, [<quark:custom_chest:4>]);
recipes.addShapeless(<minecraft:chest>, [<quark:custom_chest:3>]);
recipes.addShapeless(<minecraft:chest>, [<quark:custom_chest:2>]);
recipes.addShapeless(<minecraft:chest>, [<quark:custom_chest:1>]);
recipes.addShapeless(<minecraft:chest>, [<quark:custom_chest>]);

#adds ability to exchange trapdoors from malisisdoors and quark
recipes.remove(<malisisdoors:trapdoor_spruce>);
recipes.remove(<malisisdoors:trapdoor_jungle>);
recipes.remove(<malisisdoors:trapdoor_dark_oak>);
recipes.remove(<malisisdoors:trapdoor_birch>);
recipes.remove(<malisisdoors:trapdoor_acacia>);
recipes.addShapeless(<malisisdoors:trapdoor_spruce>, [<quark:spruce_trapdoor>]);
recipes.addShapeless(<quark:spruce_trapdoor>, [<malisisdoors:trapdoor_spruce>]);
recipes.addShapeless(<quark:jungle_trapdoor>, [<malisisdoors:trapdoor_jungle>]);
recipes.addShapeless(<malisisdoors:trapdoor_jungle>, [<quark:jungle_trapdoor>]);
recipes.addShapeless(<malisisdoors:trapdoor_dark_oak>, [<quark:dark_oak_trapdoor>]);
recipes.addShapeless(<quark:dark_oak_trapdoor>, [<malisisdoors:trapdoor_dark_oak>]);
recipes.addShapeless(<malisisdoors:trapdoor_birch>, [<quark:birch_trapdoor>]);
recipes.addShapeless(<quark:birch_trapdoor>, [<malisisdoors:trapdoor_birch>]);
recipes.addShapeless(<quark:acacia_trapdoor>, [<malisisdoors:trapdoor_acacia>]);
recipes.addShapeless(<malisisdoors:trapdoor_acacia>, [<quark:acacia_trapdoor>]);

#Items removed due to bugs
recipes.remove(<extrautils2:bagofholding>);
<extrautils2:bagofholding>.addTooltip(format.darkRed("Disabled due to bug!"));
recipes.remove(<nuclearcraft:water_source>);
<nuclearcraft:water_source>.addTooltip(format.darkRed("Disabled due to bug!"));

#Changed Iron Lattice recipe to fix conflict with iron gears
recipes.remove(<rustic:iron_lattice>);
recipes.addShaped(<rustic:iron_lattice> * 4, [[null, <minecraft:iron_nugget>, null], [<minecraft:iron_nugget>, <minecraft:iron_nugget>, <minecraft:iron_nugget>], [null, <minecraft:iron_nugget>, null]]);

#Reduce crafting of bronze ingots to 2 from 4 in crafting table, various machine outputs are still 4
recipes.remove(<forestry:ingot_bronze>);
recipes.addShapeless(<thermalfoundation:material:163> * 2, [<ore:ingotCopper>, <ore:ingotCopper>, <ore:ingotCopper>, <ore:ingotTin>]);

#Add Open Computers Diamond Chip recipe
recipes.remove(<opencomputers:material:29>);
recipes.addShapeless(<opencomputers:material:29>, [<ore:nuggetDiamond>, <ore:nuggetDiamond>]);

#Fix bronze gear recipe
recipes.addShaped(<thermalfoundation:material:291>, [[null, <ore:ingotBronze>, null], [<ore:ingotBronze>, <minecraft:iron_ingot>, <ore:ingotBronze>], [null, <ore:ingotBronze>, null]]);

#Experience Solidifier
recipes.remove(<actuallyadditions:block_xp_solidifier>);
recipes.addShaped(<actuallyadditions:block_xp_solidifier>, [[<minecraft:emerald>, <minecraft:emerald>, <minecraft:emerald>], [<actuallyadditions:block_crystal_empowered:2>, <actuallyadditions:item_misc:8>, <actuallyadditions:block_crystal_empowered:2>], [<minecraft:emerald>, <minecraft:emerald>, <minecraft:emerald>]]);

#Auto Breaker (Embers)
recipes.remove(<embers:breaker>);
recipes.addShaped(<embers:breaker>, [[<embers:plate_dawnstone>, <minecraft:iron_ingot>, <embers:plate_dawnstone>], [<ore:ingotLead>, <ore:dustRedstone>, <ore:ingotLead>], [<ore:ingotLead>, null, <ore:ingotLead>]]);

#AdvRock Seat
recipes.remove(<advancedrocketry:seat>);
recipes.addShaped(<advancedrocketry:seat>, [[null, <ore:blockWool>, null], [null, <ore:blockWool>, null], [null, <ore:blockWool>, <ore:blockWool>]]);

print("Initialized 'recipe_changes.zs'");

