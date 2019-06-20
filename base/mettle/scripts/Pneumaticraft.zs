# *======= Changes =======*
#Pressure chamber wall
recipes.remove(<pneumaticcraft:pressure_chamber_wall>);
recipes.addShaped(<pneumaticcraft:pressure_chamber_wall>*4, [
	[<pneumaticcraft:ingot_iron_compressed>, <thermalfoundation:material:352>, <pneumaticcraft:ingot_iron_compressed>],
	[<thermalfoundation:material:352>, null, <thermalfoundation:material:352>],
	[<pneumaticcraft:ingot_iron_compressed>, <thermalfoundation:material:352>, <pneumaticcraft:ingot_iron_compressed>]
]);
	
#TR circuits
recipes.remove(<techreborn:part:29>);
mods.pneumaticcraft.assembly.addDrillLaserRecipe(<pneumaticcraft:printed_circuit_board>, <techreborn:part:29>);
recipes.remove(<techreborn:part:30>);
mods.pneumaticcraft.assembly.addDrillLaserRecipe(<pneumaticcraft:advanced_pcb>, <techreborn:part:30>);

#AE circuits
mods.pneumaticcraft.assembly.addDrillLaserRecipe(<appliedenergistics2:material:5>, <appliedenergistics2:material:20>);
mods.pneumaticcraft.assembly.addDrillLaserRecipe(<minecraft:gold_ingot>, <appliedenergistics2:material:18>);
mods.pneumaticcraft.assembly.addDrillLaserRecipe(<appliedenergistics2:material:10>, <appliedenergistics2:material:16>);
mods.pneumaticcraft.assembly.addDrillLaserRecipe(<minecraft:diamond>, <appliedenergistics2:material:17>);