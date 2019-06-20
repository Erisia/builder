# *======= Import =======*
import mods.jei.JEI.removeAndHide as rh;
import crafttweaker.item.IItemStack;

# *======= Changes =======*
#Stone sickle
recipes.remove(<thermalfoundation:tool.sickle_stone>);
recipes.addShaped(<thermalfoundation:tool.sickle_stone>, [
	[null, <pyrotech:rock>],
	[null, <pyrotech:material:12>, <pyrotech:rock>],
	[<ore:stickWood>, <pyrotech:rock>]
]);
<thermalfoundation:tool.sickle_stone:51>.displayName = "Crude Sickle";

#Tank
val basicTank = <thermalexpansion:tank>.withTag({RSControl: 0 as byte, Level: 0 as byte});
recipes.remove(basicTank);
recipes.addShaped(basicTank, [
	[<thermalfoundation:material:163>, <ore:blockGlassHardened>, <thermalfoundation:material:163>],
	[<ore:blockGlassHardened>, null, <ore:blockGlassHardened>],
	[<thermalfoundation:material:163>, <ore:blockGlassHardened>, <thermalfoundation:material:163>]
]);

#Resevoir
recipes.remove(<thermalexpansion:reservoir>.withTag({}));
recipes.addShaped(<thermalexpansion:reservoir>.withTag({}), [
	[null, <thermalfoundation:material:160>],
	[<thermalfoundation:material:128>, <ore:blockGlassHardened>, <thermalfoundation:material:128>],
	[null, <thermalfoundation:material:160>]
]);
	
#Servo
recipes.remove(<thermalfoundation:material:512>);
recipes.addShaped(<thermalfoundation:material:512>, [
	[<techreborn:plates:4>, <thermalfoundation:material:160>, <techreborn:plates:4>],
	[null, <techreborn:part:30>],
	[<techreborn:plates:4>, <thermalfoundation:material:160>, <techreborn:plates:4>]
]);

#Device frames
recipes.remove(<thermalexpansion:frame:64>);
recipes.addShaped(<thermalexpansion:frame:64>, [
	[<techreborn:plates:30>, <thermalfoundation:material:160>, <techreborn:plates:30>],
	[<thermalfoundation:material:160>, <ore:blockGlassHardened>, <thermalfoundation:material:160>],
	[<techreborn:plates:30>, <thermalfoundation:material:160>, <techreborn:plates:30>]
]);

#Machine frames
recipes.remove(<thermalexpansion:frame:0>);
recipes.addShaped(<thermalexpansion:frame:0>, [
	[<techreborn:plates:30>, <thermalfoundation:material:132>, <techreborn:plates:30>],
	[<thermalfoundation:material:132>, <ore:blockGlassHardened>, <thermalfoundation:material:132>],
	[<techreborn:plates:30>, <thermalfoundation:material:132>, <techreborn:plates:30>]
]);

#Leadstone fluxduct
recipes.remove(<thermaldynamics:duct_0>);
recipes.addShaped(<thermaldynamics:duct_0>*6, [
	[<techreborn:plates:4>, <techreborn:plates:4>, <techreborn:plates:4>],
	[<thermalfoundation:material:131>, <ore:blockGlassHardened>, <thermalfoundation:material:131>],
	[<techreborn:plates:4>, <techreborn:plates:4>, <techreborn:plates:4>]
]);
	
#Energy cell frame
recipes.remove(<thermalexpansion:frame:128>);
recipes.addShaped(<thermalexpansion:frame:128>, [
	[<thermalfoundation:material:131>, <thermalfoundation:material:161>, <thermalfoundation:material:131>],
	[<thermalfoundation:material:161>, <ore:blockGlassHardened>, <thermalfoundation:material:161>],
	[<thermalfoundation:material:131>, <thermalfoundation:material:161>, <thermalfoundation:material:131>]
]);

# *----- Opqaque ducts -----*
#Fluidduct
recipes.remove(<thermaldynamics:duct_16:1>);
recipes.addShaped(<thermaldynamics:duct_16:1>, [
	[<thermalfoundation:material:128>, <thermalfoundation:material:160>, <thermalfoundation:material:128>]
]);

#Hardened fluidduct
recipes.remove(<thermaldynamics:duct_16:3>);
recipes.addShaped(<thermaldynamics:duct_16:3>, [
	[<thermalfoundation:material:162>, <thermalfoundation:material:160>, <thermalfoundation:material:162>]
]);

#Itemduct
recipes.removeShaped(<thermaldynamics:duct_32:1>, [
[<thermalfoundation:material:129>, <thermalfoundation:material:131>, <thermalfoundation:material:129>]
]);
recipes.addShaped(<thermaldynamics:duct_32:1>, [
	[<thermalfoundation:material:129>, <thermalfoundation:material:160>, <thermalfoundation:material:129>]
]);

# *----- Upgrades -----*
#Hardened
recipes.remove(<thermalfoundation:upgrade>);
recipes.addShaped(<thermalfoundation:upgrade>, [
	[<thermalfoundation:material:162>, <thermalfoundation:material:162>, <thermalfoundation:material:162>],
	[<thermalfoundation:material:162>, <techreborn:part:1>, <thermalfoundation:material:162>],
	[<thermalfoundation:material:162>, <thermalfoundation:material:162>, <thermalfoundation:material:162>]
]);

#Reinforced
recipes.remove(<thermalfoundation:upgrade:1>);
recipes.addShaped(<thermalfoundation:upgrade:1>, [
	[<thermalfoundation:material:161>, <thermalfoundation:material:161>, <thermalfoundation:material:161>],
	[<thermalfoundation:material:161>, <techreborn:part:1>, <thermalfoundation:material:161>],
	[<thermalfoundation:material:161>, <thermalfoundation:material:161>, <thermalfoundation:material:161>]
]);
	
#Signalum
recipes.remove(<thermalfoundation:upgrade:2>);
recipes.addShaped(<thermalfoundation:upgrade:2>, [
	[<thermalfoundation:material:165>, <thermalfoundation:material:165>, <thermalfoundation:material:165>],
	[<thermalfoundation:material:165>, <powersuits:powerarmorcomponent:15>, <thermalfoundation:material:165>],
	[<thermalfoundation:material:165>, <thermalfoundation:material:165>, <thermalfoundation:material:165>]
]);
	
#Enderium
recipes.remove(<thermalfoundation:upgrade:3>);
recipes.addShaped(<thermalfoundation:upgrade:3>, [
	[<thermalfoundation:material:167>, <thermalfoundation:material:167>, <thermalfoundation:material:167>],
	[<thermalfoundation:material:167>, <powersuits:powerarmorcomponent:15>, <thermalfoundation:material:167>],
	[<thermalfoundation:material:167>, <thermalfoundation:material:167>, <thermalfoundation:material:167>]
]);

#Pyroconcentrator
recipes.remove(<thermalexpansion:augment:304>);
recipes.addShaped(<thermalexpansion:augment:304>, [
	[<techreborn:ingot:17>, <thermalfoundation:material:132>, <techreborn:ingot:17>],
	[<thermalfoundation:material:132>, <thermalfoundation:material:1024>, <thermalfoundation:material:132>],
	[<techreborn:ingot:17>, <thermalfoundation:material:132>, <techreborn:ingot:17>]
]);

#Tectonic Initiator
recipes.remove(<thermalexpansion:augment:273>);
recipes.addShaped(<thermalexpansion:augment:273>, [
	[<techreborn:ingot:17>, <thermalfoundation:material:132>, <techreborn:ingot:17>],
	[<thermalfoundation:material:132>, <thermalfoundation:material:1027>, <thermalfoundation:material:132>],
	[<techreborn:ingot:17>, <thermalfoundation:material:132>, <techreborn:ingot:17>]
]);

#Flux reconstructor
recipes.remove(<thermalexpansion:augment:401>);
recipes.addShaped(<thermalexpansion:augment:401>, [
	[<techreborn:ingot:17>, <thermalfoundation:material:132>, <techreborn:ingot:17>],
	[<thermalfoundation:material:132>, <redstonearsenal:material>, <thermalfoundation:material:132>],
	[<techreborn:ingot:17>, <thermalfoundation:material:132>, <techreborn:ingot:17>]
]);
	
# *----- Fluid Transposer -----*
#Skystone creation
mods.thermalexpansion.Transposer.addFillRecipe(<appliedenergistics2:sky_stone_block>, <minecraft:stone>, <liquid:aerotheum> * 250, 400);

#Geode  
mods.thermalexpansion.Transposer.addFillRecipe(<thermalfoundation:geode>, <appliedenergistics2:sky_stone_block>, <liquid:petrotheum> * 250, 400);

#Basic circuit 
mods.thermalexpansion.Transposer.addFillRecipe(<techreborn:part:29>, <forestry:chipsets:2>.withTag({T: 2 as short}), <liquid:redstone> * 250, 400);

#Basic circuit 
mods.thermalexpansion.Transposer.addFillRecipe(<techreborn:part:30>, <forestry:chipsets:3>.withTag({T: 3 as short}), <liquid:glowstone> * 250, 400);

#Powercell
recipes.remove(<rftools:powercell>);
mods.thermalexpansion.Transposer.addFillRecipe(<rftools:powercell>, <rftools:powercell_simple>, <liquid:redstone> * 1000, 40000);

# *----- Pulverizer -----*
mods.thermalexpansion.Pulverizer.removeRecipe(<techreborn:ore:8>);

# *----- Compactor -----*
mods.thermalexpansion.Compactor.removeStorageRecipe(<techreborn:ingot:22>);

# *======= Removals =======*
#Compressed sawdust
furnace.remove(<minecraft:coal:1>, <thermalfoundation:material:801>);	

#Gears and plates
val removeHide = [
	<thermalfoundation:material:27>,
	<thermalfoundation:material:260>,
	<thermalfoundation:material:262>,
	<thermalfoundation:material:263>,
	<thermalfoundation:material:264>,
	<thermalfoundation:material:288>,
	<thermalfoundation:material:295>,
	<thermalfoundation:material:328>,
	<thermalfoundation:material:357>,
	<thermalfoundation:material:359>
	] as IItemStack[];

for item in removeHide {
	rh(item);
}

#Gears
val remove = [
	<thermalfoundation:material:24>,
	<thermalfoundation:material:25>,
	<thermalfoundation:material:26>,
	<thermalfoundation:material:256>,
	<thermalfoundation:material:257>,
	<thermalfoundation:material:258>,
	<thermalfoundation:material:259>,
	<thermalfoundation:material:260>,
	<thermalfoundation:material:261>,
	<thermalfoundation:material:262>,
	<thermalfoundation:material:263>,
	<thermalfoundation:material:264>,
	<thermalfoundation:material:288>,
	<thermalfoundation:material:289>,
	<thermalfoundation:material:290>,
	<thermalfoundation:material:291>,
	<thermalfoundation:material:292>,
	<thermalfoundation:material:293>,
	<thermalfoundation:material:294>,
	<thermalfoundation:material:295>
	] as IItemStack[];

for item in remove {
	recipes.remove(item);
}