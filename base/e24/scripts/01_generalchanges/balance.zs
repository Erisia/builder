import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDict;
import crafttweaker.oredict.IOreDictEntry;

var flint = <minecraft:flint>;
var gunpowder = <minecraft:gunpowder>;
var oreSaltPeter = <ore:dustSaltpeter>;
var oreSulfur = <ore:dustSulfur>;


##=========== Make Gunpowder require sulfur + salt + coal

## Remove only sulfur crafting of gunpowder
recipes.removeShapeless(gunpowder, [oreSulfur, oreSulfur, oreSulfur, oreSulfur]);

var blockSteel = <ore:blockSteel>;
var ingotSteel = <ore:ingotSteel>;
var doubleSteel as IIngredient = <thermalfoundation:material:160> * 2;
var ingotIron = <minecraft:iron_ingot>;
var dustIron = <thermalfoundation:material:0>;
var coal = <minecraft:coal>;
var charcoal = <minecraft:coal:1>;
var coke = <thermalfoundation:material:802>;
var dustCharcoal = <thermalfoundation:material:769>;
var dustCoal = <thermalfoundation:material:768>;

##============== Steel Ingot Removal
#Nuclearcraft
mods.nuclearcraft.alloy_furnace.removeRecipeWithOutput(blockSteel);
mods.nuclearcraft.alloy_furnace.removeRecipeWithOutput(ingotSteel);
mods.nuclearcraft.alloy_furnace.removeRecipeWithOutput(doubleSteel);

#EnderIO
mods.enderio.AlloySmelter.removeRecipe(ingotSteel.items[0]);

#Thermal - the mod that seems to hate oreDict for some reason
mods.thermalexpansion.InductionSmelter.removeRecipe(ingotIron, coke);
mods.thermalexpansion.InductionSmelter.removeRecipe(ingotIron, dustCharcoal);
mods.thermalexpansion.InductionSmelter.removeRecipe(ingotIron, dustCoal);
mods.thermalexpansion.InductionSmelter.removeRecipe(dustIron, coke);
mods.thermalexpansion.InductionSmelter.removeRecipe(dustIron, dustCharcoal);
mods.thermalexpansion.InductionSmelter.removeRecipe(dustIron, dustCoal);

##========Multiarea Mining

#TE Drill
var drillHead = <thermalfoundation:material:656>;
var plateIron = <ore:plateIron>;
var blockCopper = <ore:blockCopper>;

recipes.remove(drillHead);
recipes.addShaped(drillHead, [[null, blockSteel, null],[plateIron, blockCopper, plateIron], [plateIron, blockCopper, plateIron]]);


#AA Drill
var drillCore = <actuallyadditions:item_misc:16>;
var blockEnori = <actuallyadditions:block_crystal:5>;
var blockRestonia = <actuallyadditions:block_crystal>;
var basicCoil = <actuallyadditions:item_misc:7>;

recipes.remove(drillCore);
recipes.addShaped(drillCore, [[blockEnori, basicCoil, blockSteel],[basicCoil, blockRestonia, basicCoil], [blockSteel, basicCoil, blockEnori]]);

#PSI
var assembler = <psi:cad_assembler>;
var piston = <minecraft:piston>;

recipes.remove(assembler);
recipes.addShaped(assembler, [[ingotSteel, piston, ingotSteel],[ingotSteel, null, ingotSteel], [null, blockSteel, null]]);

##============ Miners

#Lens of the Miner
var blockEnder = <actuallyadditions:block_misc:6>;
var energizer = <actuallyadditions:block_energizer>;
var miningLens = <actuallyadditions:item_mining_lens>;
var lens = <actuallyadditions:item_misc:18>;

recipes.remove(miningLens);
recipes.addShaped(miningLens, [[energizer, drillCore, energizer],[blockEnder, lens, blockEnder], [energizer, drillCore, energizer]]);

#RFTools Quarry Card
var quarryCard = <rftools:shape_card:2>;
var shapeCard = <rftools:shape_card>;
var advancedPowercell = <rftools:powercell_advanced>;
var remoteScanner = <rftools:remote_scanner>;
var locator = <rftools:locator>;

recipes.remove(quarryCard);
recipes.addShaped(quarryCard, [[advancedPowercell, remoteScanner, advancedPowercell],[blockSteel, shapeCard, blockSteel], [advancedPowercell, locator, advancedPowercell]]);

#Mek Digital Miner 
var logSorter = <mekanism:machineblock:15>;
var tpCore = <mekanism:teleportationcore>;
var atomicAlloy = <mekanism:atomicalloy>;
var diamond = <ore:gemDiamond>;
var circuitBasic = <ore:circuitBasic>;

#Teleportation Core
recipes.remove(tpCore);
recipes.addShaped(tpCore, [[diamond, atomicAlloy, diamond],[ingotSteel, blockEnder, ingotSteel], [diamond, atomicAlloy, diamond]]);

#Logistical Sorter
recipes.remove(logSorter);
recipes.addShaped(logSorter, [[ingotSteel, piston, ingotSteel],[ingotSteel, circuitBasic, ingotSteel], [ingotSteel, blockSteel, ingotSteel]]);



##================Flight

#Simply Jetpacks
var leatherStrap = <simplyjetpacks:metaitem:4>;
var leather = <ore:leather>;

recipes.remove(leatherStrap);
recipes.addShaped(leatherStrap, [[null, null, null],[leather, ingotSteel, leather], [leather, ingotSteel, leather]]);