# *======= Import =======*
import crafttweaker.item.IItemStack;
import mods.jei.JEI.removeAndHide as rh;

# *======= Changes =======*
#Iron furnace
recipes.remove(<techreborn:iron_furnace>);
recipes.addShaped(<techreborn:iron_furnace>, [
	[<techreborn:plates:34>, <techreborn:plates:34>, <techreborn:plates:34>],
	[<techreborn:plates:34>, <minecraft:furnace>, <techreborn:plates:34>],
	[<techreborn:plates:34>, <techreborn:plates:34>, <techreborn:plates:34>]
]);

#Generator
recipes.remove(<techreborn:solid_fuel_generator>);
recipes.addShaped(<techreborn:solid_fuel_generator>, [
	[<techreborn:plates:34>, <minecraft:iron_bars>, <techreborn:plates:34>],
	[<techreborn:plates:34>, <techreborn:rebattery>.withTag({energy: 0}), <techreborn:plates:34>],
	[<techreborn:plates:34>, <minecraft:furnace>, <techreborn:plates:34>]
]);

#Machine frame
recipes.remove(<techreborn:machine_frame>);
recipes.addShaped(<techreborn:machine_frame>, [
	[<ore:ingotAluminum>, <ore:plastic>, <ore:ingotAluminum>],
	[<ore:plastic>, null, <ore:plastic>],
	[<ore:ingotAluminum>, <ore:plastic>, <ore:ingotAluminum>]
]);

#Glass fiber cable
recipes.addShaped(<techreborn:cable:4>*6, [
	[<ore:blockGlassHardened>, <ore:blockGlassHardened>, <ore:blockGlassHardened>],
	[<techreborn:plates:11>, <thermalfoundation:material:167>, <techreborn:plates:11>],
	[<ore:blockGlassHardened>, <ore:blockGlassHardened>, <ore:blockGlassHardened>]
]);
	
#Implosion compressor
recipes.remove(<techreborn:implosion_compressor>);
recipes.addShaped(<techreborn:implosion_compressor>, [
	[<techreborn:plates:34>, <techreborn:plates:35>, <techreborn:plates:34>],
	[<techreborn:part:30>, <techreborn:machine_frame:1>, <techreborn:part:30>],
	[<techreborn:plates:34>, <techreborn:plates:35>, <techreborn:plates:34>]
]);
	
#Industrial blast furnace 
recipes.remove(<techreborn:industrial_blast_furnace>);
recipes.addShaped(<techreborn:industrial_blast_furnace>, [
	[<techreborn:plates:34>, <techreborn:part:13>, <techreborn:plates:34>],
	[<techreborn:part:30>, <techreborn:machine_frame:1>, <techreborn:part:30>],
	[<techreborn:plates:34>, <techreborn:part:13>, <techreborn:plates:34>]
]);

#Industrial grinder
recipes.remove(<techreborn:industrial_grinder>);
recipes.addShaped(<techreborn:industrial_grinder>, [
	[<techreborn:plates:34>, <techreborn:part:4>, <techreborn:plates:34>],
	[<techreborn:part:30>, <techreborn:machine_frame:1>, <techreborn:part:30>],
	[<techreborn:plates:34>, <techreborn:part:4>, <techreborn:plates:34>]
]);

#Industrial electrolyzer 
recipes.remove(<techreborn:industrial_electrolyzer>);
recipes.addShaped(<techreborn:industrial_electrolyzer>, [
	[<techreborn:plates:34>, <thermalfoundation:storage:2>, <techreborn:plates:34>],
	[<techreborn:part:30>, <techreborn:machine_frame:1>, <techreborn:part:30>],
	[<techreborn:plates:34>, <techreborn:cable:3>, <techreborn:plates:34>]
]);
	
#Mixed metal ingot
recipes.remove(<techreborn:ingot:21>);
recipes.addShaped(<techreborn:ingot:21>*4, [
	[<ore:ingotSteel>, <ore:ingotSteel>, <ore:ingotSteel>],
	[<ore:ingotBrass>, <ore:ingotBrass>, <ore:ingotBrass>],
	[<techreborn:ingot:19>, <techreborn:ingot:19>, <techreborn:ingot:19>]
]);

# *------- Blast furnace -------*
#Energy crystal
recipes.remove(<techreborn:energycrystal>.withTag({energy: 0}));
mods.techreborn.blastFurnace.addRecipe(<techreborn:energycrystal>.withTag({energy: 0}), null, <redstonearsenal:material:160>, <techreborn:dust:16>, 100, 2500, 1500);

#Laptron crystal
recipes.remove(<techreborn:lapotroncrystal>.withTag({energy: 0}));
mods.techreborn.blastFurnace.addRecipe(<techreborn:lapotroncrystal>.withTag({energy: 0}), null,<techreborn:energycrystal>.withTag({energy: 0}), <techreborn:gem:1>, 1000, 5000, 3000);

#Laptron orb
recipes.remove(<techreborn:lapotronicorb>.withTag({energy: 0}));
recipes.addShaped(<techreborn:lapotronicorb>.withTag({energy: 0}), [
	[<techreborn:part>, <techreborn:plates:12>, <techreborn:part>],
	[<techreborn:plates:12>, <techreborn:plates:37>, <techreborn:plates:12>],
	[<techreborn:part>, <techreborn:plates:12>, <techreborn:part>]
	]);

# *------- Cables -------*
#Gold 2 electrum
<techreborn:cable:2>.displayName = "Electrum Cable";
<techreborn:cable:6>.displayName = "Insulated Electrum Cable";

val wire = <techreborn:cable>.definition;
for i in 0 to 8 {
	recipes.remove(wire.makeStack(i));
}

val metals = [
	<thermalfoundation:material:128>,
	<thermalfoundation:material:129>,
	<thermalfoundation:material:161>,
	<thermalfoundation:material:132>
	] as IItemStack[];

var meta = 0;
for item in metals {
	mods.techreborn.rollingMachine.addShaped(wire.makeStack(meta)*6, [[item, item, item]]);
	meta += 1;
}

#Wires
val cables = [
	<techreborn:cable>,
	<techreborn:cable:2>,
	<techreborn:cable:3>
	] as IItemStack[];

meta = 5;
for item in cables {
	recipes.addShapeless(wire.makeStack(meta), [<techreborn:part:32>, item]);
	meta += 1;
} 

val plates = [
	<thermalfoundation:material:320>,
	<thermalfoundation:material:321>,
	<thermalfoundation:material:353>,
	<thermalfoundation:material:324>
	] as IItemStack[];

meta = 0;
for item in plates {
	recipes.addShapeless(wire.makeStack(meta), [<minecraft:shears>, item]);
	meta += 1;
}


# *======= Removals =======*
val remove = [
	<techreborn:plates:3>,
	<techreborn:plates:8>,
	<techreborn:plates:9>,
	<techreborn:plates:10>,
	<techreborn:plates:14>,
	<techreborn:plates:15>,
	<techreborn:plates:33>
	] as IItemStack[];
	
for item in remove {
	rh(item);
}
