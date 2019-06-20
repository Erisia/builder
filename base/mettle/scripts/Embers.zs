# *======= Import =======*
import mods.jei.JEI.removeAndHide as rh;
import crafttweaker.item.IItemStack;

# *======= Changes =======*
#Melter
recipes.remove(<embers:block_furnace>);
recipes.addShaped(<embers:block_furnace>, [
	[<embers:brick_caminite>, <embers:plate_caminite>, <embers:brick_caminite>],
	[<embers:brick_caminite>, <betterwithmods:material:17>, <embers:brick_caminite>],
	[<ore:ingotIron>, <betterwithmods:cooking_pot>, <ore:ingotIron>]
]);
	
#Activator
recipes.remove(<embers:ember_activator>);
recipes.addShaped(<embers:ember_activator>, [
	[<ore:ingotCopper>, <ore:ingotCopper>, <ore:ingotCopper>],
	[<ore:ingotCopper>, <betterwithmods:material:17>, <ore:ingotCopper>],
	[<embers:brick_caminite>, <minecraft:furnace>, <embers:brick_caminite>]
]);

#Tinker hammer
#Must be shaped?
recipes.removeShaped(<embers:tinker_hammer>, [
	[<minecraft:iron_ingot>, <thermalfoundation:material:131>, <minecraft:iron_ingot>],
	[<minecraft:iron_ingot>, <minecraft:stick>, <minecraft:iron_ingot>], 
	[null, <minecraft:stick>, null]
]); 

recipes.addShaped(<embers:tinker_hammer>.withTag({}), [
	[<contenttweaker:wroughtiron>, <contenttweaker:wroughtiron>, <contenttweaker:wroughtiron>],
	[<contenttweaker:wroughtiron>, <immersiveengineering:material>, <contenttweaker:wroughtiron>],
	[null, <immersiveengineering:material>, null]
]);	

#Mechanical core
recipes.remove(<embers:mech_core>);
recipes.addShaped(<embers:mech_core>, [
	[<betterwithmods:material:14>, <minecraft:hopper>, <betterwithmods:material:14>],
	[<embers:item_pipe>, <minecraft:chest>, <embers:item_pipe>],
	[<betterwithmods:material:14>, <embers:item_pipe>, <betterwithmods:material:14>]
]);

#Superheater
recipes.remove(<embers:superheater>);
recipes.addShaped(<embers:superheater>, [
	[null, <embers:ingot_dawnstone>, <embers:plate_dawnstone>],
	[<ore:ingotCopper>, <embers:ember_cluster>, <embers:ingot_dawnstone>],
	[<ore:ingotCopper>, <ore:ingotCopper>]
]);

# *======= Stamper =======*
#Redstone plate
mods.embers.Stamper.add(<techreborn:plates:4>, <liquid:alchemical_redstone>*144, <embers:stamp_plate>); 

#Soulsteel plating
mods.embers.Stamper.add(<betterwithmods:material:51>, <liquid:soul_steel>*144, <embers:stamp_plate>);

#Steel plates
mods.embers.Stamper.add(<thermalfoundation:material:352>, <liquid:steel>*144, <embers:stamp_plate>);

# *======= Removals =======*
val remove = [
	<embers:plate_dawnstone>,
	<embers:plate_gold>,
	<embers:plate_iron>,
	<embers:plate_copper>,
	<embers:plate_silver>,
	<embers:plate_lead>,
	<embers:plate_electrum>,
	<embers:plate_nickel>,
	<embers:plate_tin>,
	<embers:plate_aluminum>,
	<embers:plate_bronze>
	] as IItemStack[];

for item in remove {
	recipes.remove(item);
}

val removeHide = [
	<mysticalmechanics:gear_gold>,
	<mysticalmechanics:gear_iron>,
	<embers:sword_electrum>,
	<embers:sword_copper>,
	<embers:sword_tin>,
	<embers:sword_aluminum>,
	#<embers:sword_lead>,
	<embers:sword_silver>,
	<embers:sword_nickel>,
	<embers:pickaxe_electrum>,
	<embers:pickaxe_copper>,
	<embers:pickaxe_tin>,
	<embers:pickaxe_aluminum>,
	<embers:pickaxe_lead>,
	<embers:pickaxe_silver>,
	<embers:pickaxe_nickel>,
	<embers:axe_electrum>,
	<embers:axe_copper>,
	<embers:axe_tin>,
	<embers:axe_aluminum>,
	<embers:axe_lead>,
	<embers:axe_silver>,
	<embers:axe_nickel>,
	<embers:shovel_electrum>,
	<embers:shovel_copper>,
	<embers:shovel_tin>,
	<embers:shovel_aluminum>,
	<embers:shovel_lead>,
	<embers:shovel_silver>,
	<embers:shovel_nickel>,
	<embers:hoe_electrum>,
	<embers:hoe_copper>,
	<embers:hoe_tin>,
	<embers:hoe_aluminum>,
	<embers:hoe_lead>,
	<embers:hoe_silver>,
	<embers:hoe_nickel>
	] as IItemStack[];

for item in removeHide {
	rh(item);
}