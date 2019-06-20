# *======= Import =======*
import mods.jei.JEI.removeAndHide as rh;

# *======= Changes =======*
#Ash brick
recipes.remove(<forestry:ash_brick>);
<forestry:ash_brick>.displayName = "Clay Hardened Brick";

#Sturdy casing
recipes.remove(<forestry:sturdy_machine>);
recipes.addShaped(<forestry:sturdy_machine>, [
	[<thermalfoundation:material:355>, <thermalfoundation:material:355>, <thermalfoundation:material:355>],
	[<thermalfoundation:material:355>, null, <thermalfoundation:material:355>],
	[<thermalfoundation:material:355>, <thermalfoundation:material:355>, <thermalfoundation:material:355>]
]);

#Hardened casing
mods.forestry.Carpenter.removeRecipe(<forestry:hardened_machine>);
recipes.addShaped(<forestry:hardened_machine>, [
	[<thermalfoundation:material:160>, <thermalfoundation:material:162>, <thermalfoundation:material:160>],
	[<thermalfoundation:material:291>, null, <thermalfoundation:material:291>],
	[<thermalfoundation:material:160>, <thermalfoundation:material:162>, <thermalfoundation:material:160>]
]);

#Squeezer
recipes.remove(<forestry:squeezer>);
recipes.addShaped(<forestry:squeezer>, [
	[<ore:plankTreatedWood>, <rustic:crushing_tub>, <ore:plankTreatedWood>], 
	[<ore:gearBronze>, <forestry:sturdy_machine>, <ore:gearBronze>], 
	[<ore:plankTreatedWood>, <minecraft:piston>, <ore:plankTreatedWood>]
]);

#Centrifuge													
recipes.remove(<forestry:centrifuge>);
recipes.addShaped(<forestry:centrifuge>, [
	[<ore:plankTreatedWood>, <ore:blockGlass>, <ore:plankTreatedWood>], 
	[<ore:gearBronze>, <forestry:sturdy_machine>, <ore:gearBronze>], 
	[<ore:plankTreatedWood>, <immersiveengineering:wooden_device0:6>, <ore:plankTreatedWood>]
]);

#Still														
recipes.remove(<forestry:still>);
recipes.addShaped(<forestry:still>, [
	[<ore:plankTreatedWood>, <minecraft:iron_bars>, <ore:plankTreatedWood>], 
	[<ore:gearBronze>, <forestry:sturdy_machine>, <ore:gearBronze>], 
	[<ore:plankTreatedWood>, <minecraft:lava_bucket>, <ore:plankTreatedWood>]
]);	

#Fabricator									 
recipes.remove(<forestry:fabricator>);
recipes.addShaped(<forestry:fabricator>, [
	[<pyrotech:refractory_glass>, <thermaldynamics:duct_16:2>, <pyrotech:refractory_glass>], 
	[<ore:gearBronze>, <forestry:hardened_machine>, <ore:gearBronze>], 
	[<ore:ingotSteel>, <ore:ingotSteel>, <ore:ingotSteel>]
]);		

#Carpenter
recipes.remove(<forestry:carpenter>);
recipes.addShaped(<forestry:carpenter>, [
	[<ore:plankTreatedWood>, <thermalfoundation:material:657>, <ore:plankTreatedWood>], 
	[<pneumaticcraft:compressed_iron_gear>, <forestry:hardened_machine>, <pneumaticcraft:compressed_iron_gear>], 
	[<ore:plankTreatedWood>, <thermalexpansion:tank>.withTag({RSControl: 0 as byte, Level: 0 as byte}), <ore:plankTreatedWood>]
]);		

#Bottler
recipes.remove(<forestry:bottler>);
recipes.addShaped(<forestry:bottler>, [
	[<ore:plankTreatedWood>, <minecraft:iron_bars>, <ore:plankTreatedWood>], 
	[<ore:gearBronze>, <forestry:sturdy_machine>, <ore:gearBronze>], 
	[<ore:plankTreatedWood>, <minecraft:glass_bottle>, <ore:plankTreatedWood>]
]);

# *----- Centrifuge -----*
mods.forestry.Centrifuge.addRecipe([(<techreborn:smalldust:47>*2) %80, (<techreborn:smalldust:29>*2) %80, <techreborn:smalldust:52> %50], <techreborn:dust:23>, 100);

# *======= Removals =======*
#Gears
rh(<forestry:gear_bronze>);
rh(<forestry:gear_tin>);
rh(<forestry:gear_copper>);

#Surivalist tools
rh(<forestry:kit_pickaxe>);
rh(<forestry:kit_shovel>);
rh(<forestry:bronze_pickaxe>);
rh(<forestry:broken_bronze_pickaxe>);
rh(<forestry:bronze_shovel>);
rh(<forestry:broken_bronze_shovel>);

