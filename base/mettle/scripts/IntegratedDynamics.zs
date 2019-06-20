# *======= Import =======*
import mods.jei.JEI.removeAndHide as rh;

# *======= Changes =======*
#Stone torch
recipes.remove(<integrateddynamics:menril_torch_stone>);
recipes.addShaped(<integrateddynamics:menril_torch_stone>, [
	[null, <integrateddynamics:menril_berries>],
	[null, <microblockcbe:stone_rod>]
]);

#Wood torch
recipes.remove(<integrateddynamics:menril_torch>);
recipes.addShaped(<integrateddynamics:menril_torch>, [
	[null, <integrateddynamics:menril_berries>],
	[null, <ore:stickWood>]
]);

#Battery(Must be shaped?)
recipes.removeShaped(<integrateddynamics:energy_battery>, [
	[<integrateddynamics:crystalized_menril_chunk>, <integrateddynamics:crystalized_menril_block>, <integrateddynamics:crystalized_menril_chunk>],
	[<integrateddynamics:crystalized_menril_chunk>, <minecraft:redstone_block>, <integrateddynamics:crystalized_menril_chunk>], 
	[<integrateddynamics:crystalized_menril_chunk>, <integrateddynamics:crystalized_menril_block>, <integrateddynamics:crystalized_menril_chunk>]
]); 
recipes.addShaped(<integrateddynamics:energy_battery>.withTag({}), [
	[<integrateddynamics:crystalized_menril_block>, <immersiveengineering:treated_wood>, <integrateddynamics:crystalized_menril_block>],
	[<immersiveengineering:treated_wood>, <techreborn:part:29>, <immersiveengineering:treated_wood>],
	[<integrateddynamics:crystalized_menril_block>, <immersiveengineering:treated_wood>, <integrateddynamics:crystalized_menril_block>]
]);

#Logic programmer
recipes.remove(<integrateddynamics:logic_programmer>);
recipes.addShaped(<integrateddynamics:logic_programmer>, [
	[<integrateddynamics:crystalized_menril_chunk>, <immersiveengineering:treated_wood>, <integrateddynamics:crystalized_menril_chunk>],
	[<immersiveengineering:treated_wood>, <techreborn:part:29>, <immersiveengineering:treated_wood>],	
	[<integrateddynamics:crystalized_menril_chunk>, <immersiveengineering:treated_wood>, <integrateddynamics:crystalized_menril_chunk>]	
]); 

#Generator
recipes.remove(<integrateddynamics:coal_generator>);
recipes.addShaped(<integrateddynamics:coal_generator>, [
	[<integrateddynamics:crystalized_menril_block>, <techreborn:rebattery>.withTag({energy: 0}), <integrateddynamics:crystalized_menril_block>],
	[<integrateddynamics:crystalized_menril_block>, <minecraft:furnace>, <integrateddynamics:crystalized_menril_block>],
	[<thermalfoundation:material:352>, <thermalfoundation:material:352>, <thermalfoundation:material:352>]
]);

# *======= Removals =======*
rh(<integrateddynamics:squeezer>);
