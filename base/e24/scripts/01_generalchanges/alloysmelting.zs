import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDict;
import crafttweaker.oredict.IOreDictEntry;

import mods.enderio.AlloySmelter;
import mods.thermalexpansion.InductionSmelter;
import mods.techreborn.alloySmelter;
//import mods.immersiveengineering.AlloySmelter;

## Add Sky Stone as an Alloy
addToAlloySmelt( <appliedenergistics2:sky_stone_block>, <minecraft:obsidian>, <ore:dyeCyan> );
## Aby Stone
addToAlloySmelt( <railcraft:generic:8>, <ore:stone>, <ore:dyeBlack> );
## Quarried Stone
addToAlloySmelt( <railcraft:generic:9>, <ore:stone>, <ore:dyeWhite> );
#Jaspers
addToAlloySmelt( <quark:jasper>, <ore:stone>, <ore:dyeRed> );
#Brimstone
addToAlloySmelt( <quark:biome_cobblestone>, <minecraft:netherrack>, <ore:dustSulfur> );
#Permafrost
addToAlloySmelt( <quark:biome_cobblestone:1>, <ore:stone>, <minecraft:ice> );



function addToAlloySmelt( output as IIngredient, input1 as IIngredient, input2 as IIngredient ) as void  {
	
	var defaultpower as int = 1500;
	var defaulttick as int = 20;

	##mods.thermalexpansion.InductionSmelter.addRecipe(IItemStack primaryOutput, IItemStack primaryInput, IItemStack secondaryInput, int energy, @Optional IItemStack secondaryOutput
	mods.thermalexpansion.InductionSmelter.addRecipe(output.items[0], input1.items[0], input2.items[0], defaultpower );
	
	##mods.techreborn.alloySmelter.addRecipe(IItemStack output, IIngredient input1, IIngredient input2, int ticktime, int euTick)
	mods.techreborn.alloySmelter.addRecipe( output.items[0], input1, input2, defaulttick, defaultpower / 4);
	
	##addRecipe(IItemStack output, IIngredient[] input, @Optional int energyCost, @Optional float xp)
	mods.enderio.AlloySmelter.addRecipe( output.items[0], [input1, input2], defaultpower );
	
	##mods.immersiveengineering.AlloySmelter.addRecipe(ItemStack output, IIngredient first, IIngredient second, int time)
	mods.immersiveengineering.AlloySmelter.addRecipe( output.items[0], input1, input2, defaulttick );

}