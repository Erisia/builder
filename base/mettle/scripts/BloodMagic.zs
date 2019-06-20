# *======= Changes =======*
#Blood altar(Must be shaped?)
recipes.removeShaped(<bloodmagic:altar>, [
	[<minecraft:stone>, null, <minecraft:stone>],
	[<minecraft:stone>, <minecraft:furnace>, <minecraft:stone>], 
	[<minecraft:gold_ingot>, <bloodmagic:monster_soul>, <minecraft:gold_ingot>]
]); 
	
recipes.addShaped(<bloodmagic:altar>.withTag({}), [
	[<betterwithmods:material:51>, null, <betterwithmods:material:51>],
	[<betterwithmods:material:51>, <minecraft:cauldron>, <betterwithmods:material:51>],
	[<betterwithmods:material:14>, <bloodmagic:monster_soul>, <betterwithmods:material:14>]
]);
	
#Primal mana 
val starlight = <forge:bucketfilled>.withTag({FluidName: "astralsorcery.liquidstarlight", Amount: 1000});
val mana = <forge:bucketfilled>.withTag({FluidName: "mana", Amount: 1000});
mods.bloodmagic.BloodAltar.addRecipe(mana, starlight, 4, 100000, 500, 5000);

# *======= Removals =======*
#Tungsten dust
mods.bloodmagic.AlchemyTable.removeRecipe([<techreborn:ore:8>, <bloodmagic:cutting_fluid>.withTag({})]);