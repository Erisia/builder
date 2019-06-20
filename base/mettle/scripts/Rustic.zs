# *======= Import =======*
import mods.jei.JEI.removeAndHide as rh;

# *======= Changes =======*
#Fertile soil
rh(<rustic:fertile_soil>);

#Tallow
rh(<rustic:tallow>);

# *------- Drying basin -------*
#Menril 
mods.rustic.EvaporatingBasin.addRecipe(<integrateddynamics:crystalized_menril_block>, <liquid:menrilresin>*1000);

#Chorus
mods.rustic.EvaporatingBasin.addRecipe(<integrateddynamics:crystalized_chorus_block>, <liquid:liquidchorus>*1000);

#Drying basin
recipes.remove(<rustic:evaporating_basin>);
recipes.addShaped(<rustic:evaporating_basin>, [
	[<minecraft:netherbrick>, null, <minecraft:netherbrick>],
	[null, <minecraft:netherbrick>]
]);

#Iron lattice
recipes.remove(<rustic:iron_lattice>);
recipes.addShaped(<rustic:iron_lattice>*8, [
	[null, <contenttweaker:wroughtiron>],
	[<contenttweaker:wroughtiron>, <contenttweaker:wroughtiron>, <contenttweaker:wroughtiron>],
	[null, <contenttweaker:wroughtiron>]
]);
	
#Rope
recipes.remove(<rustic:rope>);
recipes.addShaped(<rustic:rope>, [
	[null, <betterwithmods:material:3>],
	[null, <minecraft:string>], 
	[null, <betterwithmods:material:3>]
]);

#Crushing tub
recipes.remove(<rustic:crushing_tub>);
recipes.addShaped(<rustic:crushing_tub>, [
	[<ore:plankWood>, null, <ore:plankWood>],
	[<contenttweaker:wroughtiron>, null, <contenttweaker:wroughtiron>],
	[<ore:slabWood>, <ore:slabWood>, <ore:slabWood>]
]);

#Brewing Barrel
recipes.remove(<rustic:brewing_barrel>);
recipes.addShaped(<rustic:brewing_barrel>, [
	[<ore:plankWood>, <contenttweaker:wroughtiron>, <ore:plankWood>],
	[<ore:slabWood>, null, <ore:slabWood>],
	[<ore:plankWood>, <contenttweaker:wroughtiron>, <ore:plankWood>]
]);

#Barrel 
recipes.remove(<rustic:barrel>);
recipes.addShaped(<rustic:barrel>, [
	[<ore:plankWood>, <ore:slabWood>, <ore:plankWood>],
	[<contenttweaker:wroughtiron>, null, <contenttweaker:wroughtiron>],
	[<ore:plankWood>, <ore:slabWood>, <ore:plankWood>]
]);

#Liquid barrel 
recipes.remove(<rustic:liquid_barrel>);
recipes.addShaped(<rustic:liquid_barrel>, [
	[<ore:plankWood>, null, <ore:plankWood>],
	[<contenttweaker:wroughtiron>, null, <contenttweaker:wroughtiron>],
	[<ore:plankWood>, <ore:slabWood>, <ore:plankWood>]
]);
	
#Seed tooltips
<rustic:chili_pepper_seeds>.addTooltip(format.gray("Fertile Seasons:"));
<rustic:chili_pepper_seeds>.addTooltip(format.green(" Spring"));
<rustic:chili_pepper_seeds>.addTooltip(format.yellow(" Summer"));
<rustic:chili_pepper_seeds>.addTooltip(format.red(" Autumn"));

<rustic:tomato_seeds>.addTooltip(format.gray("Fertile Seasons:"));
<rustic:tomato_seeds>.addTooltip(format.green(" Spring"));
<rustic:tomato_seeds>.addTooltip(format.yellow(" Summer"));
<rustic:tomato_seeds>.addTooltip(format.red(" Autumn"));