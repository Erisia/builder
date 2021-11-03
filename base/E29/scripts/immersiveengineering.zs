//Blast Furnace
mods.immersiveengineering.BlastFurnace.removeRecipe(<immersiveengineering:metal:8>);
mods.immersiveengineering.BlastFurnace.addRecipe(<immersiveengineering:metal:8>, <ore:ingotIron>, 220, <immersiveengineering:material:7>);
mods.immersiveengineering.BlastFurnace.removeRecipe(<immersiveengineering:storage:8>);
mods.immersiveengineering.BlastFurnace.addRecipe(<immersiveengineering:storage:8>, <ore:blockIron>, 2000, <immersiveengineering:material:7> * 9);
recipes.addShaped(<artisanworktables:workshop:1>, [[<minecraft:iron_ingot>, <ore:logWood>, <minecraft:iron_ingot>],[<immersiveengineering:treated_wood>, <immersiveengineering:treated_wood>, <immersiveengineering:treated_wood>], [<minecraft:iron_ingot>, <immersiveengineering:treated_wood>, <minecraft:iron_ingot>]]);
recipes.addShaped(<artisanworktables:workshop:9>, [[<minecraft:iron_ingot>, <extratan:tempered_glass_block>, <minecraft:iron_ingot>], [<immersiveengineering:treated_wood>, <immersiveengineering:treated_wood>, <immersiveengineering:treated_wood>], [<minecraft:iron_ingot>, <immersiveengineering:treated_wood>, <minecraft:iron_ingot>]]);
recipes.addShaped(<artisanworktables:workshop:0>, [[<minecraft:iron_ingot>, <magneticraft:crafting:6>, <minecraft:iron_ingot>],[<immersiveengineering:treated_wood>, <immersiveengineering:treated_wood>, <immersiveengineering:treated_wood>], [<minecraft:iron_ingot>, <immersiveengineering:treated_wood>, <minecraft:iron_ingot>]]);

//Refinery
mods.immersiveengineering.Refinery.addRecipe(<liquid:diesel> * 500, <liquid:ethanol> *250, <liquid:oil> * 250, 512);

//Fermenter
val ethanol = <liquid:ethanol>;
val seed = <contenttweaker:dust_ddg>;
mods.immersiveengineering.Fermenter.addRecipe(seed, ethanol *100, <harvestcraft:cornitem>, 80);

//Portable Gen Fuel
mods.immersivepetroleum.PortableGenerator.registerPortableGenFuel(<liquid:diesel>, 256, 20);

//Arc Furnace
mods.immersiveengineering.ArcFurnace.removeRecipe(<enderio:item_alloy_ingot:7>);
