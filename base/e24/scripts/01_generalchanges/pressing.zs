import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDict;
import crafttweaker.oredict.IOreDictEntry;




#Slate Prod
addToPressers( <rustic:slate>, <minecraft:clay> );

function addToPressers( output as IIngredient, input as IIngredient ) as void  {

	var defaultenergy as int = 500;
	var defaulttick as int = 20;

	#mods.thermalexpansion.Compactor.addPressRecipe(IItemStack output, IItemStack input, int energy);
	mods.thermalexpansion.Compactor.addPressRecipe( output.items[0], input.items[0],defaultenergy);
	
	#mods.techreborn.compressor.addRecipe(IItemStack output1, IIngredient input, int ticktime, int euTick);
	mods.techreborn.compressor.addRecipe( output.items[0], input, defaulttick, defaultenergy/4);
	
	##Metal Press
	##OutputStack, InputStack, MoldStack, Energy, SizeValue
	##mods.immersiveengineering.MetalPress.addRecipe( output, input, <immersiveengineering:mold>, defaultenergy, 50);
	
}


	
	