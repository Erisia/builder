//REMOVE RECIPES
recipes.remove(<rftools:machine_frame>);//MACHINE FRAME
recipes.remove(<rftools:storage_scanner>);//STORAGE SCANNER
recipes.remove(<rftools:powercell_simple>);//SIMPLE POWERCELL
recipes.remove(<rftools:powercell>);//POWERCELL
recipes.remove(<rftoolsdim:empty_dimension_tab>);//EMPTY DIMENSION TAB
recipes.remove(<rftools:storage_module_tablet>);//STORAGE TABLET
recipes.remove(<rftools:elevator>);//ELEVATOR
recipes.remove(<rftools:screen_controller>);//SCREEN CONTROLLER
recipes.remove(<rftools:smartwrench>);//SMART WRENCH
//ADD RECIPES
mods.extendedcrafting.TableCrafting.addShaped(0, <rftools:machine_frame>*4, [
	[<ore:ingotTungsten>, <ore:ingotDraconiumAwakened>, <ore:ingotRefinedObsidian>, <ore:ingotDraconiumAwakened>, <ore:ingotTungsten>], 
	[<ore:ingotDraconiumAwakened>, <ore:ingotRefinedObsidian>, <calculator:reinforcedironingot>, <ore:ingotRefinedObsidian>, <ore:ingotDraconiumAwakened>], 
	[<ore:ingotRefinedObsidian>, <calculator:reinforcedironingot>, <ore:gaiaIngot>, <calculator:reinforcedironingot>, <ore:ingotRefinedObsidian>], 
	[<ore:ingotDraconiumAwakened>, <ore:ingotRefinedObsidian>, <calculator:reinforcedironingot>, <ore:ingotRefinedObsidian>, <ore:ingotDraconiumAwakened>], 
	[<ore:ingotTungsten>, <ore:ingotDraconiumAwakened>, <ore:ingotRefinedObsidian>, <ore:ingotDraconiumAwakened>, <ore:ingotTungsten>]
]);//MACHINE FRAME
recipes.addShaped(<rftools:storage_scanner>,[[<ore:plateSteel>,<minecraft:ender_pearl>,<ore:plateSteel>],
																[<actuallyadditions:item_crystal:1>,<ic2:resource:13>,<actuallyadditions:item_crystal:1>],
																[<ore:plateSteel>,<ore:chestWood>,<ore:plateSteel>]]);//STORAGE SCANNER
recipes.addShaped(<rftools:powercell>,[[<thermaldynamics:duct_0:2>,<appliedenergistics2:material:41>,<thermaldynamics:duct_0:2>],
																[<actuallyadditions:item_crystal_empowered:1>,<thermalexpansion:frame:0>,<actuallyadditions:item_crystal_empowered:1>],
																[<thermaldynamics:duct_0:2>,<actuallyadditions:item_crystal_empowered:0>,<thermaldynamics:duct_0:2>]]);//POWERCELL
recipes.addShaped(<rftoolsdim:empty_dimension_tab>,[[null,<minecraft:paper>,null],
																[<actuallyadditions:item_crystal_empowered:0>,<ore:plateZinc>,<actuallyadditions:item_crystal_empowered:0>],
																[null,<actuallyadditions:item_crystal_empowered:2>,null]]);//EMPTY DIMENSION TAB
recipes.addShaped(<rftools:elevator>,[[<ore:dustRedstone>,<minecraft:ender_pearl>,<ore:dustRedstone>],
																[<ore:gearIron>,<immersiveengineering:metal_decoration0:5>,<ore:gearIron>],
																[<ore:dustRedstone>,<minecraft:redstone_torch>,<ore:dustRedstone>]]);//ELEVATOR
recipes.addShaped(<rftools:screen_controller>,[[<ore:dustRedstone>,<minecraft:ender_pearl>,<ore:dustRedstone>],
																[<minecraft:glass>,<rftools:screen>,<minecraft:glass>],
																[<ore:dustRedstone>,<minecraft:redstone_torch>,<ore:dustRedstone>]]);//SCREEN CONTROLLER
recipes.addShaped(<rftools:screen_controller>,[[<ore:ingotIron>,null,null],
																[null,<ore:dyeBlue>,null],
																[null,null,<ore:dyeBlue>]]);//SMART WRENCH