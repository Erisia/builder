/*  The main purpose of this file is to let you convert a default recipe to a custom one using gamestages
 *  
 *  shapedRecipes 2D array contains the item being changed and then the recipe for the item in the custom gamestage
 */


import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDict;
import crafttweaker.oredict.IOreDictEntry;

//Building Materials
var steelCasing = <mekanism:basicblock:8>;
var blockSteel = <ore:blockSteel>;
var blockFluix = <appliedenergistics2:fluix_block>;
var blockQuartz = <ore:blockQuartz>;
var blockGlass = <ore:blockGlass>;
var blockOsmium = <ore:blockOsmium>;
var chestWood = <ore:chestWood>;
var blockMenril = <integrateddynamics:crystalized_menril_block>;
var blockRestonia = <actuallyadditions:block_crystal>;
var blockEnderPearl = <actuallyadditions:block_misc:6>;
var blockObsidian = <ore:obsidian>;
var blockGold = <ore:blockGold>;
var advancedCoil = <actuallyadditions:item_misc:8>;
var electroCore = <mekanism:electrolyticcore>;
var atomicAlloy = <mekanism:atomicalloy>;
var alloyUlt = <ore:alloyUltimate>;
var circuitUlt = <ore:circuitUltimate>;
var blockDiamond = <ore:blockDiamond>;
var blockTin = <ore:blockTin>;
var furnace = <minecraft:furnace>;
var enrichedAlloy = <mekanism:enrichedalloy>;
var blockRedstone = <ore:blockRedstone>;
var alloyBasic = <ore:alloyBasic>;
var alloyElite = <ore:alloyElite>;
var alloyAdvanced = <ore:alloyAdvanced>;
var circuitBasic = <ore:circuitBasic>;
var circuitAdvanced = <ore:circuitAdvanced>;
var circuitElite = <ore:circuitElite>;
var bucket = <minecraft:bucket>;
var cobblestone = <ore:cobblestone>;
var blockLapis = <ore:blockLapis>;
var enderEye = <minecraft:ender_eye>;
var shapeCard = <rftools:shape_card>;
var doubleCompSteel = <gt:double_compressed_steel>;
var tripleCompSteel = <gt:triple_compressed_steel>;
var gearTin = <ore:gearTin>;
var blockGlassHard = <ore:blockGlassHardened>;
var blockLead = <ore:blockLead>;
var leadFluxDuct = <thermaldynamics:duct_0>;
var blockElectrum = <ore:blockElectrum>;
var plateTin = <ore:plateTin>;
var opDuct = <thermaldynamics:duct_32:1>;
var blockInvar = <ore:blockInvar>;
var gearBronze = <ore:gearBronze>;
var gearSilver = <ore:gearSilver>;
var blockSignalum = <ore:blockSignalum>;
var gearElectrum = <ore:gearElectrum>;
var blockEnderium = <ore:blockEnderium>;
var gearLumium = <ore:gearLumium>;
var dustPyro = <thermalfoundation:material:1024>;
var blockSilver = <ore:blockSilver>;
var logWood = <ore:logWood>;
var blockBlackQuartz = <actuallyadditions:block_misc:2>;
var ingotTin = <ore:ingotTin>;
var grainInfinity = <enderio:item_material:20>;
var barsIron = <ore:barsIron>;
var conduitBinder = <enderio:item_material:4>;
var blockPulsatingIron = <ore:blockPulsatingIron>;
var blockConductiveIron = <ore:blockConductiveIron>;
var blockEnergeticAlloy = <ore:blockEnergeticAlloy>;
var blockVibrantAlloy = <ore:blockVibrantAlloy>;
var ingotSteel = <ore:ingotSteel>;
var tpCore = <mekanism:teleportationcore>;
var blockCertusQuartz = <appliedenergistics2:quartz_block>;
var logicProcessor = <appliedenergistics2:material:22>;
var basicCoil = <actuallyadditions:item_misc:7>;
var livingWood = <ore:livingwood>;


//Any item in this array will be added to the kitchen gamestage, removed from default, then added to the heavy stage with the recipe listed
var shapedRecipes as IIngredient[][][][IItemStack] = {
	//Steel Casing
	<mekanism:basicblock:8> : [
		[[blockSteel, blockGlass, blockSteel], [blockGlass, blockOsmium, blockGlass], [blockSteel, blockGlass, blockSteel]]
	],
	//Digital Miner
    <mekanism:machineblock:4> : [
		[[atomicAlloy, circuitUlt, atomicAlloy], [blockDiamond, tripleCompSteel, blockDiamond], [tpCore, circuitUlt, tpCore]]
	],
	//Infuser
    <mekanism:machineblock:8> : [
		[[blockSteel, furnace, blockSteel], [blockRedstone, blockOsmium, blockRedstone], [blockSteel, furnace, blockSteel]]
	],
	//Basic Universal Cable
    <mekanism:transmitter>.withTag({tier: 0}) : [
		[[ingotSteel, blockRedstone, ingotSteel], [blockGlassHard, blockGlassHard, blockGlassHard], [ingotSteel, blockRedstone, ingotSteel]]
	],
	//Rftools-----------------------------------------------
	//RFTools Machine Frame
	<rftools:machine_frame> : [
		[[blockSteel, blockLapis, alloyUlt], [blockGold, enderEye, blockGold], [blockSteel, blockLapis, blockSteel]]
	],
	//Quarry Card
	<rftools:shape_card:2> : [
		[[blockRedstone, blockDiamond, blockRedstone], [doubleCompSteel, shapeCard, doubleCompSteel], [blockRedstone, blockDiamond, blockRedstone]]
	],
	//Thermal Expansion--------------------------------------
	//TE Machine Frame
	<thermalexpansion:frame:0> : [
		[[blockSteel, blockGlass, blockSteel], [blockGlass, gearTin, blockGlass], [blockSteel, blockGlass, blockSteel]]
	],
	//Lead Fluxduct
	<thermaldynamics:duct_0> : [
		[[conduitBinder, blockRedstone, conduitBinder], [blockLead, blockGlassHard, blockLead], [conduitBinder, blockRedstone, conduitBinder]]
	],
	//Electrum Fluxduct
	<thermaldynamics:duct_0:6> : [
		[[null, null, null], [blockElectrum, leadFluxDuct, blockElectrum], [null, null, null]]
	],
	//Opaque Fluxduct
	<thermaldynamics:duct_32:1> : [
		[[plateTin, plateTin, plateTin], [blockTin, blockGlassHard, blockTin], [plateTin, plateTin, plateTin]]
	],
	//Itemduct
	<thermaldynamics:duct_32> : [
		[[null, null, null], [null, opDuct, null], [null, null, null]]
	],
	//Hard Kit
    <thermalfoundation:upgrade>: [
		[[null, blockInvar, null], [blockInvar, gearBronze, blockInvar], [null, blockInvar, null]]
	],
	//rein Kit
	<thermalfoundation:upgrade:1> : [
		[[null, blockElectrum, null], [blockElectrum, gearSilver, blockElectrum], [null, blockElectrum, null]]
	],
	//Sig Kit
	<thermalfoundation:upgrade:2>: [
		[[null, blockSignalum, null], [blockSignalum, gearElectrum, blockSignalum], [null, blockSignalum, null]]
	],
	//Res Kit
	<thermalfoundation:upgrade:3> : [
		[[null, blockEnderium, null], [blockEnderium, gearLumium, blockEnderium], [dustPyro, blockEnderium, dustPyro]]
	],
	//Trans Coil
	<thermalfoundation:material:514>: [
		[[null, null, blockRedstone], [null, blockSilver, null], [blockRedstone, null, null]]
	],
	//Rec Coil
	<thermalfoundation:material:513> : [
		[[null, null, blockRedstone], [null, blockGold, null], [blockRedstone, null, null]]
	],
	//Conductance Coil
	<thermalfoundation:material:515>: [
		[[blockRedstone, null, null], [null, blockElectrum, null], [null, null, blockRedstone]]
	],
	//Servo
	<thermalfoundation:material:512> : [
		[[null, blockRedstone, null], [null, blockSteel, null], [null, blockRedstone, null]]
	],
	//Actually Additions-----------------------------
	// Iron Casing
	<actuallyadditions:block_misc:9> : [
		[[blockSteel, logWood, blockSteel], [logWood, blockBlackQuartz, logWood], [blockSteel, logWood, blockSteel]]
	],
	//Energy Laser
	<actuallyadditions:block_laser_relay> : [
		[[blockObsidian, blockRestonia, blockObsidian], [blockBlackQuartz, advancedCoil, blockBlackQuartz], [blockObsidian, blockRestonia, blockObsidian]]
	],
	//Basic Coil
	<actuallyadditions:item_misc:7> : [
		[[null, blockRestonia, null], [blockRestonia, blockBlackQuartz, blockRestonia], [null, blockRestonia, null]]
	],
	//Ranged Collector
	<actuallyadditions:block_ranged_collector> : [
		[[null, <minecraft:diamond>, null], [blockEnderPearl, <minecraft:hopper>, blockEnderPearl], [null, <actuallyadditions:block_misc:9>, null]]
	],
	
	//Tech Reborn--------------------------------
	// Basic Machine Frame
	<techreborn:machine_frame>: [
		[[blockSteel, ingotTin, blockSteel], [ingotTin, null, ingotTin], [blockSteel, ingotTin, blockSteel]]
	],
	//ENDERIO---------------------
	// Basic Mahcine Frame
	<enderio:item_material>: [
		[[barsIron, blockSteel, barsIron], [blockSteel, grainInfinity, blockSteel], [barsIron, blockSteel, barsIron]]
	],
	//Item Conduit
	<enderio:item_item_conduit>: [
		[[conduitBinder, conduitBinder, conduitBinder], [blockRedstone, blockPulsatingIron, blockRedstone], [conduitBinder, conduitBinder, conduitBinder]]
	],
	// Energy Conduit
	<enderio:item_power_conduit>: [
		[[conduitBinder, conduitBinder, conduitBinder], [blockRedstone, blockConductiveIron, blockRedstone], [conduitBinder, conduitBinder, conduitBinder]]
	],
	//Enhanced Energy Conduit
	<enderio:item_power_conduit:1>: [
		[[conduitBinder, conduitBinder, conduitBinder], [blockRedstone, blockEnergeticAlloy, blockRedstone], [conduitBinder, conduitBinder, conduitBinder]]
	],
	//Ender Energy Conduit
	<enderio:item_power_conduit:2>: [
		[[conduitBinder, conduitBinder, conduitBinder], [blockRedstone, blockVibrantAlloy, blockRedstone], [conduitBinder, conduitBinder, conduitBinder]]
	],
	//Fluid Conduit
	<enderio:item_liquid_conduit>: [
		[[conduitBinder, conduitBinder, conduitBinder], [ingotSteel, blockGlass, ingotSteel], [conduitBinder, conduitBinder, conduitBinder]]
	],
	//Pressure Fluid Conduit
	<enderio:item_liquid_conduit:1>: [
		[[conduitBinder, conduitBinder, conduitBinder], [ingotSteel, blockGlassHard, ingotSteel], [conduitBinder, conduitBinder, conduitBinder]]
	],
	//Ender Fluid Conduit
	<enderio:item_liquid_conduit:2>: [
		[[conduitBinder, conduitBinder, conduitBinder], [blockGlassHard, blockVibrantAlloy, blockGlassHard], [conduitBinder, conduitBinder, conduitBinder]]
	],
	//AE2 --------------------------------------------
	//Quartz Fiber
	<appliedenergistics2:part:140>: [
		[[blockGlassHard, blockGlassHard, blockGlassHard], [blockQuartz, blockQuartz, blockQuartz], [blockGlassHard, blockGlassHard, blockGlassHard]]
	],
	//Glass Cable
	<appliedenergistics2:part:16>: [
		[[blockFluix, <appliedenergistics2:part:140>, null], [null, blockFluix, null], [null, null, null]]
	],
	
	//Energy Acceptor
	<appliedenergistics2:energy_acceptor>: [
		[[blockSteel, blockGlassHard, blockSteel], [blockGlassHard, blockFluix, blockGlassHard], [blockSteel, blockGlassHard, blockSteel]]
	],
	//1k
	<appliedenergistics2:material:35>: [
		[[blockRedstone, blockCertusQuartz, blockRedstone], [blockCertusQuartz, logicProcessor, blockCertusQuartz], [blockRedstone, blockCertusQuartz, blockRedstone]]
	],
	//LP--------------------
	//Unrouted
	<logisticspipes:pipe_transport_basic>: [
		[[ingotSteel, blockRedstone, ingotSteel], [blockGlassHard, null, blockGlassHard], [ingotSteel, blockRedstone, ingotSteel]]
	],
	//Integrated Dynamics--------------------
	//logic cable
	<integrateddynamics:cable>: [
		[[blockMenril, blockRedstone, blockMenril], [blockGlassHard, blockSteel, blockGlassHard], [blockMenril, blockRedstone, blockMenril]]
	],
	//energy interface
	<integratedtunnels:part_interface_energy_item>: [
		[[blockMenril, blockSteel, blockMenril], [blockEnderPearl, <integrateddynamics:energy_battery>, blockEnderPearl], [blockMenril, blockSteel, blockMenril]]
	],
	//item interface
	<integratedtunnels:part_interface_item_item>: [
		[[blockMenril, blockSteel, blockMenril], [blockEnderPearl, chestWood, blockEnderPearl], [blockMenril, blockSteel, blockMenril]]
	],
	//fluid interface
	<integratedtunnels:part_interface_fluid_item>: [
		[[blockMenril, blockSteel, blockMenril], [blockEnderPearl, bucket, blockEnderPearl], [blockMenril, blockSteel, blockMenril]]
	],
	//Botania--------------------------------
	//Mana Spreader
	<botania:spreader>: [
		[[livingWood, livingWood, livingWood], [blockGold, <actuallyadditions:block_ranged_collector>, blockGold], [livingWood, livingWood, livingWood]]
	]
};




for item, recipesForItem in shapedRecipes {

	//get default recipe and store into temp as a List
	var temp = recipes.getRecipesFor(item);

	//remove recipe for item
	recipes.remove(item);

	//temp will be a list
	for returnedrecipes in temp  {
	  //add default recipe to kitchen sink stage
	    mods.recipestages.Recipes.addShaped(STAGES.kitchen, item, returnedrecipes.ingredients2D);
	}  //end inner kitchen loop

	for recipe in recipesForItem {
		//add different recipe to heavy
		mods.recipestages.Recipes.addShaped(STAGES.heavy, item, recipe);
	}  //end inner heavy loop

}  //end outer loop
