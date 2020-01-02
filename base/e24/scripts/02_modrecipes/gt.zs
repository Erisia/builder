import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDict;
import crafttweaker.oredict.IOreDictEntry;

//Map steel to compressed steel
recipes.remove(<gt:compressed_steel>);
recipes.addShaped(<gt:compressed_steel>, [[<ore:blockSteel>, <ore:blockSteel>, <ore:blockSteel>],[<ore:blockSteel>, <ore:blockSteel>, <ore:blockSteel>], [<ore:blockSteel>, <ore:blockSteel>, <ore:blockSteel>]]);