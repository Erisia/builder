# *======= Changes =======*
val mana = <forge:bucketfilled>.withTag({FluidName: "mana", Amount: 1000});

#Grindstone
mods.astralsorcery.Altar.removeAltarRecipe("astralsorcery:shaped/internal/altar/grindstone");
mods.astralsorcery.Altar.addDiscoveryAltarRecipe("astralsorcery:shaped/internal/altar/grindstone", <astralsorcery:blockmachine:1>, 200, 20, [
	null, null, null, 
	<astralsorcery:blockinfusedwood:1>, <betterwithmods:material:14>, <ore:stoneMarble>, 
	<immersiveengineering:material>, <immersiveengineering:material>, <astralsorcery:blockinfusedwood:1>
]);

#Lightwell
mods.astralsorcery.Altar.removeAltarRecipe("astralsorcery:shaped/internal/altar/lightwell");
mods.astralsorcery.Altar.addDiscoveryAltarRecipe("astralsorcery:shaped/internal/altar/lightwell", <astralsorcery:blockwell>, 200, 20, [
	<astralsorcery:blockmarble>, null, <astralsorcery:blockmarble>, 
	<astralsorcery:blockmarble:4>, <betterwithmods:cooking_pot>, <astralsorcery:blockmarble:4>,
	<astralsorcery:itemcraftingcomponent>, <astralsorcery:blockmarble>, <astralsorcery:itemcraftingcomponent>
]); 

#Ritual pedestal
mods.astralsorcery.Altar.removeAltarRecipe("astralsorcery:shaped/internal/altar/ritualpedestal");
mods.astralsorcery.Altar.addConstellationAltarRecipe("astralsorcery/internal/altar/ritualpedestal", <astralsorcery:blockritualpedestal>, 2000, 10, [
    <astralsorcery:blockmarble:4>, <astralsorcery:itemrockcrystalsimple>, <astralsorcery:blockmarble:4>,
    <astralsorcery:blockmarble:2>, <bloodmagic:blood_shard:1>, <astralsorcery:blockmarble:2>,
    <astralsorcery:blockmarbleslab>, <minecraft:nether_star>, <astralsorcery:blockmarbleslab>,
    null, null, null, 
	null, <minecraft:gold_ingot>, <minecraft:gold_ingot>, 
	<minecraft:gold_ingot>, <minecraft:gold_ingot>, <minecraft:gold_ingot>, 
	<minecraft:gold_ingot>, <minecraft:gold_ingot>, <minecraft:gold_ingot>
]);

#Refraction table
mods.astralsorcery.Altar.removeAltarRecipe("astralsorcery:shaped/internal/altar/drawingtable");
mods.astralsorcery.Altar.addTraitAltarRecipe("astralsorcery/internal/altar/drawingtable", <astralsorcery:blockmapdrawingtable>, 3000, 15, [
    <astralsorcery:blockblackmarble>, <astralsorcery:blockblackmarble>, <astralsorcery:blockblackmarble>,
    <astralsorcery:blockinfusedwood:2>, mana, <astralsorcery:blockinfusedwood:2>,
	<astralsorcery:blockmarble:4>, <minecraft:gold_ingot>, <astralsorcery:blockmarble:4>,	
	<botania:manaresource:5>, <botania:manaresource:5>, <astralsorcery:blockmarble:4>, 
	<astralsorcery:blockmarble:4>, <botania:manaresource:5>, <botania:manaresource:5>, 
	<botania:manaresource:5>, <botania:manaresource:5>, <astralsorcery:itemcraftingcomponent:1>,
	<astralsorcery:itemcraftingcomponent:1>, <astralsorcery:blockmarble:4>, <astralsorcery:blockmarble:4>,
	<botania:manaresource:5>, <astralsorcery:blockinfusedwood>, <astralsorcery:blockinfusedwood>,
	null,
	<astralsorcery:itemcraftingcomponent:2>, <astralsorcery:itemusabledust:1>, <astralsorcery:itemcraftingcomponent:2>, <astralsorcery:itemusabledust:1>
], "astralsorcery.constellation.mineralis");

#Celestial Gateway
mods.astralsorcery.Altar.removeAltarRecipe("astralsorcery:shaped/internal/altar/gateway");
mods.astralsorcery.Altar.addTraitAltarRecipe("astralsorcery/internal/altar/gateway", <astralsorcery:blockcelestialgateway>, 4000, 20, [
    <astralsorcery:iteminfusedglass>.withTag({astralsorcery: {}}), <astralsorcery:iteminfusedglass>.withTag({astralsorcery: {}}), <astralsorcery:iteminfusedglass>.withTag({astralsorcery: {}}),
    <botania:manaresource:14>, <astralsorcery:itemcelestialcrystal>, <botania:manaresource:14>,
    <astralsorcery:blockmarbleslab>, mana, <astralsorcery:blockmarbleslab>, 
	<astralsorcery:itemcraftingcomponent:2>, <astralsorcery:itemcraftingcomponent:2>, <minecraft:gold_ingot>, 
	<minecraft:gold_ingot>, <astralsorcery:itemusabledust:1>, <astralsorcery:itemusabledust:1>, 
	<astralsorcery:itemcraftingcomponent:2>, <astralsorcery:itemcraftingcomponent:2>, <astralsorcery:blockmarbleslab>,
	<astralsorcery:blockmarbleslab>, <astralsorcery:blockmarble:6>, <astralsorcery:blockmarble:6>,
	<astralsorcery:itemusabledust:1>, <astralsorcery:itemcraftingcomponent:2>, <astralsorcery:itemcraftingcomponent:2>,
	<astralsorcery:blockmarble:6>,
	<astralsorcery:itemusabledust>, <astralsorcery:itemusabledust:1>, <bloodmagic:component:17>, <minecraft:nether_star>
], "astralsorcery.constellation.lucerna");

#Dimensional Shard
mods.astralsorcery.StarlightInfusion.addInfusion(<thermalfoundation:geode>, <rftools:dimensional_shard>, false, 0.5, 100);

# *======= Removals =======*
#TR tungsten
mods.astralsorcery.Grindstone.removeRecipe(<techreborn:dust:55>);