# *======= Import =======*
import mods.thaumcraft.ArcaneWorkbench;
import mods.thaumcraft.Crucible;

# *======= Changes =======*
#Thaumium
mods.thaumcraft.Crucible.removeRecipe(<thaumcraft:ingot>);
mods.thaumcraft.Crucible.registerRecipe("Thaumium", "METALLURGY@2", <thaumcraft:ingot>, <contenttweaker:wroughtiron>, [<aspect:praecantatio>*5, <aspect:terra>*5]);

#Runic matrix
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumcraft:infusion_matrix>); 
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe("Runic Matrix", "INFUSION", 150, 
	[<aspect:aqua>, <aspect:ignis>, <aspect:terra>, <aspect:aer>, <aspect:ordo>, <aspect:perditio>] , <thaumcraft:infusion_matrix>, [
	[<thaumcraft:stone_arcane>, <betterwithmods:material:14>, <thaumcraft:stone_arcane>],
	[<betterwithmods:material:14>, <minecraft:ender_pearl>, <betterwithmods:material:14>],
	[<thaumcraft:stone_arcane>, <betterwithmods:material:14>, <thaumcraft:stone_arcane>]
]);