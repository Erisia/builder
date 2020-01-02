import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDict;
import crafttweaker.oredict.IOreDictEntry;



#Fuel
furnace.setFuel(<ore:logWood>, 1000);

##Bread
furnace.remove(<minecraft:bread>);
furnace.remove(<actuallyadditions:item_food:17>);

#Marble
furnace.addRecipe(<astralsorcery:blockmarble>, <ore:stoneDiorite>);


##=====Dirt
#Coarse Loamy Dirt to Dirt
furnace.addRecipe(<minecraft:dirt>, <biomesoplenty:dirt:8>);
#Loamy Dirt to Dirt
furnace.addRecipe(<minecraft:dirt>, <biomesoplenty:dirt:8>);
//Loamy Grass Block
furnace.addRecipe(<minecraft:dirt>, <biomesoplenty:grass:2>);
//Origin Grass Block
furnace.addRecipe(<minecraft:dirt>, <biomesoplenty:grass:5>);
//Overgrown Netherrack
furnace.addRecipe(<minecraft:dirt>, <biomesoplenty:grass:6>);
//Flowering Grass Block
furnace.addRecipe(<minecraft:dirt>, <biomesoplenty:grass:7>);
//Mycelial Netherrack
furnace.addRecipe(<minecraft:dirt>, <biomesoplenty:grass:8>);
//Coarse Dirt
furnace.addRecipe(<minecraft:dirt>, <minecraft:dirt:1>);
//Podzol
furnace.addRecipe(<minecraft:dirt>, <minecraft:dirt:2>);
//Grass
furnace.addRecipe(<minecraft:dirt>, <minecraft:grass>);
