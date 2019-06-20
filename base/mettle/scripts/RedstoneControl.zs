# *======= Import =======*
import mods.jei.JEI.removeAndHide as rh;

# *======= Changes =======*
#Signal wire
recipes.remove(<rs_ctr:wire>);
recipes.addShaped(<rs_ctr:wire>, [
	[<minecraft:redstone>, <immersiveengineering:material:22>, <minecraft:redstone>]
]);

#Wireless signal wire
recipes.remove(<rs_ctr:wireless>);
recipes.addShaped(<rs_ctr:wireless>, [
	[<minecraft:redstone>, <thermalfoundation:material:167>, <minecraft:redstone>]
]);