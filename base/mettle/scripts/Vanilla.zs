# *======= Import =======*
import crafttweaker.oredict.IOreDictEntry;
import crafttweaker.item.IItemStack;
import mods.jei.JEI.removeAndHide as rh;

# *======= Changes =======*
#Stick
recipes.addShapeless(<minecraft:stick>*2, [<dttraverse:autumn_brownseed>]);

#Torch
recipes.remove(<minecraft:torch>);

#Furnace
recipes.remove(<minecraft:furnace>);
recipes.addShaped(<minecraft:furnace>, [
	[<forestry:ash_brick>, <forestry:ash_brick>, <forestry:ash_brick>],
	[<forestry:ash_brick>, null, <forestry:ash_brick>],
	[<minecraft:stone_slab>, <minecraft:stone_slab>, <minecraft:stone_slab>]
]);

#Chest
val siding = mods.betterwithmods.MiniBlocks.getMiniBlock("siding", <ore:plankWood>);
recipes.remove(<minecraft:chest>);
recipes.addShaped(<minecraft:chest>, [
	[<ore:plankWood>, <ore:plankWood>, <ore:plankWood>],
	[<ore:plankWood>, <minecraft:iron_ingot>, <ore:plankWood>],
	[<ore:plankWood>, <ore:plankWood>, <ore:plankWood>]
]);
recipes.addShaped(<minecraft:chest>, [
	[siding, siding, siding],
	[siding, <minecraft:iron_ingot>, siding],
	[siding, siding, siding]
]);

#Enchanter
recipes.addShaped(<minecraft:enchanting_table>, [
	[null, <minecraft:book>, null],
	[<betterwithmods:material:45>, <quark:quilted_wool:14>,<betterwithmods:material:45>],
	[<minecraft:obsidian>, <betterwithmods:material:14>, <minecraft:obsidian>]
]);
	
#Brewing stand
recipes.addShaped(<minecraft:brewing_stand>, [
	[null, <minecraft:blaze_rod>, null],
	[<betterwithmods:material:14>, <betterwithmods:material:14>, <betterwithmods:material:14>]
]);

#Boats 
val boats = [
	<minecraft:boat>,
	<minecraft:spruce_boat>,
	<minecraft:birch_boat>, 
	<minecraft:jungle_boat>,
	<minecraft:acacia_boat>,
	<minecraft:dark_oak_boat>,
	] as IItemStack[];

for item in boats {
	recipes.remove(item);
}

val plank = <minecraft:planks>.definition;
var meta = 0;
for item in boats {
	recipes.addShaped(item, [
		[plank.makeStack(meta), <pyrotech:material:20>, plank.makeStack(meta)],
		[<pyrotech:planks_tarred>, <pyrotech:material:23>, <pyrotech:planks_tarred>]
	]);
	meta += 1;
}

#Colours
val dyeDictionary as IOreDictEntry[] = [
	<ore:dyeWhite>,
	<ore:dyeOrange>,
	<ore:dyeMagenta>,
	<ore:dyeLightBlue>,
	<ore:dyeYellow>,
	<ore:dyeLime>,
	<ore:dyePink>,
	<ore:dyeGray>,
	<ore:dyeLightGray>,
	<ore:dyeCyan>,
	<ore:dyePurple>,
	<ore:dyeBlue>,
	<ore:dyeBrown>,
	<ore:dyeGreen>,
	<ore:dyeRed>,
	<ore:dyeBlack>
	] as IOreDictEntry[];

#Beds
val moulding = mods.betterwithmods.MiniBlocks.getMiniBlock("moulding", <ore:plankWood>);
recipes.remove(<minecraft:bed:*>);
recipes.addShaped(<minecraft:bed>, [
	[<betterwithmods:aesthetic:9>, <betterwithmods:aesthetic:9>, <betterwithmods:aesthetic:9>],
	[moulding, null, moulding]
]);

for i in 0 to 16 {
    recipes.addShapeless(<minecraft:bed>.withDamage(i), [dyeDictionary[i], <minecraft:bed:*>]);
}

#Sleeping bags
recipes.remove(<comforts:sleeping_bag:*>);
recipes.addShaped(<comforts:sleeping_bag>, [
	[<betterwithmods:material:41>, <betterwithmods:material:41>, <betterwithmods:material:41>]
	]);	
	
for i in 0 to 16 {
    recipes.addShapeless(<comforts:sleeping_bag>.withDamage(i), [dyeDictionary[i], <comforts:sleeping_bag:*>]);
}

# *======= Removals =======*
#Bonemeal
recipes.remove(<minecraft:dye:15>);

#Gunpowder
recipes.remove(<minecraft:gunpowder>);

#Paper 
recipes.remove(<minecraft:paper>);