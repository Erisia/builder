/* Thermal _________
   Tweaks and Alterations */
   
// Dynamics
recipes.addShapeless(<ThermalDynamics:ThermalDynamics_32:6>.withTag({DenseType: 1 as byte}), [<ThermalDynamics:ThermalDynamics_32:6>, <ore:dustLead>]);
recipes.addShapeless(<ThermalDynamics:ThermalDynamics_32:6>.withTag({DenseType: 2 as byte}), [<ThermalDynamics:ThermalDynamics_32:6>, <ore:dustSilver>]);
recipes.addShapeless(<ThermalDynamics:ThermalDynamics_32:7>.withTag({DenseType: 1 as byte}), [<ThermalDynamics:ThermalDynamics_32:7>, <ore:dustLead>]);
recipes.addShapeless(<ThermalDynamics:ThermalDynamics_32:7>.withTag({DenseType: 2 as byte}), [<ThermalDynamics:ThermalDynamics_32:7>, <ore:dustSilver>]);

 /*Thermal Expansion*/
//Compressed Sawdust oredict crafting
recipes.remove(<ThermalExpansion:material:513>);
recipes.addShaped(<ThermalExpansion:material:513>, [[<ore:pulpWood>, <ore:pulpWood>, <ore:pulpWood>], [<ore:pulpWood>, null, <ore:pulpWood>], [<ore:pulpWood>, <ore:pulpWood>, <ore:pulpWood>]]);


//Induction Smelter
mods.thermalexpansion.Smelter.addRecipe(800, <bluepower:zinc_ingot>, <ThermalFoundation:material:64> * 3, <bluepower:brass_ingot> * 4);
mods.thermalexpansion.Smelter.addRecipe(800, <ThermalFoundation:material:66>, <bluepower:teslatite_dust> * 4, <bluepower:blue_alloy_ingot>);
mods.thermalexpansion.Smelter.addRecipe(800, <ThermalFoundation:material:64>, <minecraft:redstone> * 4, <bluepower:red_alloy_ingot>);
mods.thermalexpansion.Smelter.addRecipe(800, <bluepower:red_alloy_ingot>, <bluepower:blue_alloy_ingot>, <bluepower:purple_alloy_ingot>);
mods.thermalexpansion.Smelter.addRecipe(800, <bluepower:infused_teslatite_dust> * 8, <minecraft:gold_ingot>, <bluepower:purple_alloy_ingot>);
mods.thermalexpansion.Smelter.addRecipe(800, <minecraft:coal> * 8, <minecraft:sand> * 8, <bluepower:silicon_boule>);
mods.thermalexpansion.Smelter.addRecipe(800, <bluepower:silicon_wafer>, <bluepower:teslatite_dust> * 4, <bluepower:blue_doped_wafer>);
mods.thermalexpansion.Smelter.addRecipe(800, <minecraft:iron_ingot> * 2, <bluepower:zinc_ingot>, <bluepower:zincplate> * 4);
mods.thermalexpansion.Smelter.addRecipe(800, <minecraft:obsidian> *5, <bluepower:sapphire_glass>, <bluepower:reinforced_sapphire_glass>);