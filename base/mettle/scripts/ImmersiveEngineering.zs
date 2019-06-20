# *======= Import =======*
import crafttweaker.item.IItemStack as IItemStack;
import mods.jei.JEI.removeAndHide as rh;

# *======= Changes =======*
#Treated wood with coal tar
recipes.addShaped(<immersiveengineering:treated_wood>*8, [
	[<ore:plankWood>, <ore:plankWood>, <ore:plankWood>],
	[<ore:plankWood>, <forge:bucketfilled>.withTag({FluidName: "coal_tar", Amount: 1000}), <ore:plankWood>],
	[<ore:plankWood>, <ore:plankWood>, <ore:plankWood>]
]);

#Cloche
recipes.remove(<immersiveengineering:metal_device1:13>);
<immersiveengineering:metal_device1:13>.addTooltip(format.red("WIP"));

#Conveyor belts
recipes.remove(<immersiveengineering:conveyor>.withTag({conveyorType: "immersiveengineering:conveyor"}));

recipes.addShapeless(<immersiveengineering:conveyor>.withTag({conveyorType: "immersiveengineering:conveyor"}),
	[<immersiveengineering:conveyor>.withTag({conveyorType: "immersiveengineering:uncontrolled"})]);
	
recipes.addShaped(<immersiveengineering:conveyor>.withTag({conveyorType: "immersiveengineering:conveyor"})*8, [
	[<techreborn:part:32>, <techreborn:part:32>, <techreborn:part:32>],
	[<ore:ingotSteel>, <minecraft:redstone>, <ore:ingotSteel>]
]);
	
recipes.addShaped(<immersiveengineering:conveyor>.withTag({conveyorType: "immersiveengineering:conveyor"})*8, [
	[<ore:leather>, <ore:leather>, <ore:leather>],
	[<ore:ingotSteel>, <minecraft:redstone>, <ore:ingotSteel>]
]);

#Redstone engineering block
recipes.remove(<immersiveengineering:metal_decoration0:3>);
recipes.addShaped(<immersiveengineering:metal_decoration0:3>, [
	[<ore:ingotSteel>, <techreborn:plates:4>, <ore:ingotSteel>],
	[<techreborn:plates:4>, <immersiveengineering:material:27>, <techreborn:plates:4>],
	[<ore:ingotSteel>, <techreborn:plates:4>, <ore:ingotSteel>]
]);

#Workbench 
recipes.remove(<immersiveengineering:wooden_device0:2>);
recipes.addShaped(<immersiveengineering:wooden_device0:2>, [
	[<ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>],
	[<minecraft:crafting_table>, <ore:ingotSteel>, <immersiveengineering:wooden_decoration>]
]);
	
#Windmill 
recipes.remove(<immersiveengineering:wooden_device1:1>);
recipes.addShaped(<immersiveengineering:wooden_device1:1>, [
	[<immersiveengineering:material:11>, <immersiveengineering:material:11>, <immersiveengineering:material:11>],
	[<immersiveengineering:material:11>, <ore:ingotSteel>, <immersiveengineering:material:11>],
	[<immersiveengineering:material:11>, <immersiveengineering:material:11>, <immersiveengineering:material:11>]
]);

#Blast furnace
recipes.remove(<immersiveengineering:stone_decoration:1>);
recipes.addShaped(<immersiveengineering:stone_decoration:1>, [
	[<minecraft:netherbrick>, <pyrotech:material:5>, <minecraft:netherbrick>],
	[<pyrotech:material:5>, <betterwithmods:aesthetic:7>, <pyrotech:material:5>],
	[<minecraft:netherbrick>, <pyrotech:material:5>, <minecraft:netherbrick>]
]);
	
#Coke furnace
recipes.remove(<immersiveengineering:stone_decoration>);
recipes.addShaped(<immersiveengineering:stone_decoration>, [
	[<minecraft:brick>, <pyrotech:material:5>, <minecraft:brick>],
	[<pyrotech:material:5>, <minecraft:hardened_clay>, <pyrotech:material:5>],
	[<minecraft:brick>, <pyrotech:material:5>, <minecraft:brick>]
]);

#Alloy kiln
recipes.remove(<immersiveengineering:stone_decoration:10>);
recipes.addShaped(<immersiveengineering:stone_decoration:10>, [
	[<pyrotech:material:5>, <embers:plate_caminite>, <pyrotech:material:5>],
	[<embers:plate_caminite>, <minecraft:hardened_clay>, <embers:plate_caminite>],
	[<pyrotech:material:5>, <embers:plate_caminite>, <pyrotech:material:5>]
]);

#Treated hammer
recipes.remove(<immersiveengineering:tool>);
recipes.addShaped(<immersiveengineering:tool>, [
	[null, <contenttweaker:wroughtiron>, <pyrotech:material:26>],
	[null, <immersiveengineering:material>, <contenttweaker:wroughtiron>],
	[<immersiveengineering:material>]
]);
	
#Wire cutters
recipes.remove(<immersiveengineering:tool:1>);
recipes.addShaped(<immersiveengineering:tool:1>, [
	[<immersiveengineering:material>, <contenttweaker:wroughtiron>],
	[null, <immersiveengineering:material>],
]);

#Wires
val wires = [
	<immersiveengineering:material:20>,
	<immersiveengineering:material:21>,
	<immersiveengineering:material:22>,
	<immersiveengineering:material:23>
	] as IItemStack[];
	
for item in wires {
	recipes.remove(item);
}
	
val wireMetals = [
	<thermalfoundation:material:320>,
	<thermalfoundation:material:353>,
	<thermalfoundation:material:324>,
	<thermalfoundation:material:352>
	] as IItemStack[];

val wire = <immersiveengineering:material>.definition;
var wireID = 20;
for item in wireMetals {
	recipes.addShapeless(wire.makeStack(wireID), [<immersiveengineering:tool:1>, item]);
	wireID += 1;
}
	
#Components blueprint
recipes.remove(<immersiveengineering:blueprint>.withTag({blueprint: "components"}));
recipes.addShaped(<immersiveengineering:blueprint>.withTag({blueprint: "components"}), [
	[<ore:ingotCopper>, <ore:ingotLead>, <ore:ingotIron>],
	[<ore:dyeBlue>, <ore:dyeBlue>, <ore:dyeBlue>],
	[<minecraft:paper>, <minecraft:paper>, <minecraft:paper>]
]);
	
# *======= Alloy Smelter =======*
#Wrought iron
mods.immersiveengineering.AlloySmelter.addRecipe(<contenttweaker:wroughtiron>, <ore:sand>, <minecraft:iron_ingot>, 600);

# *======= Blast Furnace =======*
#Must remove IE metal

#fuel removal
mods.immersiveengineering.BlastFurnace.removeFuel(<minecraft:coal:1>);
mods.immersiveengineering.BlastFurnace.removeFuel(<thermalfoundation:storage_resource>);

#Steel
mods.immersiveengineering.BlastFurnace.removeRecipe(<immersiveengineering:metal:8>);
mods.immersiveengineering.BlastFurnace.removeRecipe(<immersiveengineering:storage:8>);
mods.immersiveengineering.BlastFurnace.addRecipe(<thermalfoundation:material:160>, <thermalfoundation:material:96>, 1200, <immersiveengineering:material:7>);

# *======= Plate press =======*
#Compressed iron gear
mods.immersiveengineering.MetalPress.addRecipe(<pneumaticcraft:compressed_iron_gear>, <pneumaticcraft:ingot_iron_compressed>, <immersiveengineering:mold:1>, 2000, 4);

#Redstone plate
mods.immersiveengineering.MetalPress.addRecipe(<techreborn:plates:4>, <minecraft:redstone>, <immersiveengineering:mold>, 2000);

#Iridium plate removal
mods.immersiveengineering.MetalPress.removeRecipe(<techreborn:plates:37>);

# *======= Arc Furnace =======* 
#Must remove IE metal

#Aluminium
mods.immersiveengineering.ArcFurnace.removeRecipe(<immersiveengineering:metal:1>);
mods.immersiveengineering.ArcFurnace.addRecipe(<thermalfoundation:material:132>, <techreborn:ore:4>, <immersiveengineering:material:7>, 2000, 2048);

#TR ingots removal
mods.immersiveengineering.ArcFurnace.removeRecipe(<techreborn:ingot:3>);
mods.immersiveengineering.ArcFurnace.removeRecipe(<techreborn:ingot:14>);
mods.immersiveengineering.ArcFurnace.removeRecipe(<techreborn:ingot:15>);

# *======= Removals =======*
#Hammer - plates
val plates = <immersiveengineering:metal>.definition;
for i in 30 to 41{
    recipes.removeShapeless(plates.makeStack(i), [<*>, <immersiveengineering:tool>]);
} 

#Crafted rods
recipes.remove(<immersiveengineering:material:1>);
recipes.remove(<immersiveengineering:material:2>);
recipes.remove(<immersiveengineering:material:3>);

#Hemp cloth 
rh(<immersiveengineering:material:5>);

#Hemp fiber
rh(<immersiveengineering:material:4>);
<immersiveengineering:seed>.addTooltip(format.red("Immersive Engineering hemp is disabled in favour of Better With Mods', please use theirs instead!"));

#Crusher - tungsten ore
mods.immersiveengineering.Crusher.removeRecipesForInput(<techreborn:ore:8>);