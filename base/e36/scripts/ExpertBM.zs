import mods.bloodmagic.AlchemyArray;
import mods.bloodmagic.AlchemyTable;
import mods.bloodmagic.BloodAltar;
import mods.bloodmagic.TartaricForge;
import crafttweaker.item.IItemStack as IItemStack;
import crafttweaker.oredict.IOreDict as IOreDict;
import crafttweaker.oredict.IOreDictEntry as IOreDictEntry;

var weakOrb = <bloodmagic:blood_orb>.withTag({orb: "bloodmagic:weak"});
var apprenticeOrb = <bloodmagic:blood_orb>.withTag({orb: "bloodmagic:apprentice"});
var magicianOrb = <bloodmagic:blood_orb>.withTag({orb: "bloodmagic:magician"});
var masterOrb = <bloodmagic:blood_orb>.withTag({orb: "bloodmagic:master"});
var archmageOrb = <bloodmagic:blood_orb>.withTag({orb: "bloodmagic:archmage"});

var tier1MinOrb = weakOrb.or(apprenticeOrb).or(magicianOrb).or(masterOrb).or(archmageOrb);
var tier2MinOrb = apprenticeOrb.or(magicianOrb).or(masterOrb).or(archmageOrb);
var tier3MinOrb = magicianOrb.or(masterOrb).or(archmageOrb);
var tier4MinOrb = masterOrb.or(archmageOrb);
//REMOVE RECIPES
recipes.remove(<bloodmagic:altar>);//BLOOD ALTAR
recipes.remove(<bloodmagic:soul_snare:0>);//BLOOD ALTAR
recipes.remove(<bloodmagic:soul_forge:0>);//HELLFIRE FORGE
recipes.remove(<bloodmagic:sacrificial_dagger:0>);//SACRIFICIAL DAGGER
recipes.remove(<bloodmagic:blood_rune:0>);//BLOOD RUNE
recipes.remove(<bloodmagic:alchemy_table>);//ALCHEMY TABLE
//ADD RECIPES
recipes.addShaped(<bloodmagic:altar>,[[<botania:shimmerrock>,null,<botania:shimmerrock>],
																[<botania:shimmerrock>,<astralsorcery:blockwell>,<botania:shimmerrock>],
																[<botania:manaresource:7>,<bloodmagic:monster_soul>,<botania:manaresource:7>]]);//BLOOD ALTAR
recipes.addShaped(<bloodmagic:soul_snare:0>*8,[[<botania:manaresource:12>,<botania:manaresource:7>,<botania:manaresource:12>],
																[<botania:manaresource:7>,<astralsorcery:itemcraftingcomponent:2>,<botania:manaresource:7>],
																[<botania:manaresource:12>,<botania:manaresource:7>,<botania:manaresource:12>]]);//RUDIMENTARY SNARE
recipes.addShaped(<bloodmagic:soul_forge:0>,[[<botania:manaresource:7>,null,<botania:manaresource:7>],
																[<botania:shimmerrock>,<astralsorcery:itemcelestialcrystal>,<botania:shimmerrock>],
																[<botania:shimmerrock>,<botania:storage:2>,<botania:shimmerrock>]]);//HELLFIRE FORGE
recipes.addShaped(<bloodmagic:sacrificial_dagger:0>,[[null,<tconstruct:edible:3>,null],
																[<tconstruct:edible:3>,<botania:enderdagger>,<tconstruct:edible:3>],
																[null,<tconstruct:edible:3>,null]]);//SACRIFICIAL DAGGER
recipes.addShaped(<bloodmagic:blood_rune:0>,[[<quark:polished_netherrack:0>,<quark:polished_netherrack:0>,<quark:polished_netherrack:0>],
																[<bloodmagic:slate:0>,tier1MinOrb.reuse(),<bloodmagic:slate:0>],
																[<quark:polished_netherrack:0>,<quark:polished_netherrack:0>,<quark:polished_netherrack:0>]]);
																//BLOOD RUNE
recipes.addShaped(<bloodmagic:decorative_brick:3>,[[<actuallyadditions:block_crystal_empowered:0>,<bloodmagic:item_demon_crystal:3>,<actuallyadditions:block_crystal_empowered:1>],
																[<bloodmagic:item_demon_crystal:4>,<minecraft:end_crystal>,<bloodmagic:item_demon_crystal:4>],
																[<actuallyadditions:block_crystal_empowered:1>,<bloodmagic:item_demon_crystal:3>,<actuallyadditions:block_crystal_empowered:0>]]);//CRYSTAL CLUSTER
recipes.addShapeless(<bloodmagic:decorative_brick:3>,[<bloodmagic:decorative_brick:2>]);//CRYSTAL CLUSTER
recipes.addShapeless(<bloodmagic:decorative_brick:2>,[<bloodmagic:decorative_brick:3>]);//CRYSTAL CLUSTER
//BLOOD ALTAR RECIPES
// output, input, altar tier, mb life essence, blood consumed per tick, blood drained per tick
//Blank Slate
	mods.bloodmagic.BloodAltar.removeRecipe(<minecraft:stone>);
	mods.bloodmagic.BloodAltar.addRecipe(<bloodmagic:slate>, <sonarcore:stablestone_normal>, 0, 1000, 10, 10);
//Orb tier 1
	mods.bloodmagic.BloodAltar.removeRecipe(<minecraft:diamond>);
	mods.bloodmagic.BloodAltar.addRecipe(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:weak"}), 
	<botania:manaresource:9>, 0, 2000, 12, 12);

//Orb tier 2
	mods.bloodmagic.BloodAltar.removeRecipe(<minecraft:redstone_block>);
	mods.bloodmagic.BloodAltar.addRecipe(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:apprentice"}), 
	<astralsorcery:itemcelestialcrystal:0>, 1, 5000, 25, 25);

//Orb tier 3
	mods.bloodmagic.BloodAltar.removeRecipe(<minecraft:gold_block>);
	mods.bloodmagic.BloodAltar.addRecipe(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:magician"}), 
	<bloodmagic:item_demon_crystal:0>, 2, 25000, 50, 50);

//Orb tier 5
	mods.bloodmagic.BloodAltar.removeRecipe(<minecraft:nether_star>);
	mods.bloodmagic.BloodAltar.addRecipe(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:archmage"}), 
	<contenttweaker:bloodshine_ingot>, 4, 80000, 200, 200);
//WATER INSCRIPTION TOOL
	mods.bloodmagic.BloodAltar.removeRecipe(<minecraft:lapis_block>);
	mods.bloodmagic.BloodAltar.addRecipe(<bloodmagic:inscription_tool:1>, 
	<botania:rune:0>, 3, 2000, 200, 200);
//FIRE INSCRIPTION TOOL
	mods.bloodmagic.BloodAltar.removeRecipe(<minecraft:magma_cream>);
	mods.bloodmagic.BloodAltar.addRecipe(<bloodmagic:inscription_tool:2>, 
	<botania:rune:1>, 3, 2000, 200, 200);
//EARTH INSCRIPTION TOOL
	mods.bloodmagic.BloodAltar.removeRecipe(<minecraft:obsidian>);
	mods.bloodmagic.BloodAltar.addRecipe(<bloodmagic:inscription_tool:3>, 
	<botania:rune:2>, 3, 2000, 200, 200);
//AIR INSCRIPTION TOOL
	mods.bloodmagic.BloodAltar.removeRecipe(<minecraft:ghast_tear>);
	mods.bloodmagic.BloodAltar.addRecipe(<bloodmagic:inscription_tool:4>, 
	<botania:rune:3>, 3, 2000, 200, 200);
//HELLFIRE FORGE RECIPES
TartaricForge.removeRecipe([<minecraft:redstone>, <minecraft:gold_ingot>, <minecraft:glass>, <minecraft:dye:4>]);
TartaricForge.addRecipe(
	<bloodmagic:soul_gem:0>,
	[<botania:manaresource:7>, <astralsorcery:itemcraftingcomponent:2>, <botania:elfglass>, <astralsorcery:itemusabledust:1>],
	0, 0);
TartaricForge.removeRecipe([<bloodmagic:soul_gem>, <minecraft:iron_sword>]);
TartaricForge.addRecipe(
	<bloodmagic:sentient_sword>,
	[<bloodmagic:soul_gem>, <astralsorcery:itemchargedcrystalsword>],
	0, 0
);
TartaricForge.removeRecipe([<bloodmagic:soul_gem:0>, <minecraft:diamond>, <minecraft:redstone_block>, <minecraft:lapis_block>]);
TartaricForge.addRecipe(
	<bloodmagic:soul_gem:1>,
	[<bloodmagic:soul_gem:0>, <contenttweaker:star_diamond>, <astralsorcery:itemcraftingcomponent:4>, <botania:manaresource:8>],
	60, 20
);
TartaricForge.removeRecipe([<bloodmagic:soul_gem:1>, <minecraft:diamond>, <minecraft:gold_block>, <bloodmagic:slate:2>]);
TartaricForge.addRecipe(
	<bloodmagic:soul_gem:2>,
	[<bloodmagic:soul_gem:1>, <botania:manaresource:9>, <astralsorcery:itemcraftingcomponent:4>, <bloodmagic:slate:2>],
	240, 50
);
TartaricForge.removeRecipe([<minecraft:redstone>, <minecraft:dye:15>, <minecraft:gunpowder>, <minecraft:coal>]);
TartaricForge.addRecipe(
	<bloodmagic:arcane_ashes>,
	[<astralsorcery:itemcraftingcomponent:2>, <botania:manaresource:23>, <immersiveengineering:material:6>, <botania:rune:8>],
	0, 0
);
TartaricForge.removeRecipe([<minecraft:redstone>, <minecraft:glowstone_dust>, <minecraft:gunpowder>, <minecraft:gold_nugget>]);
TartaricForge.addRecipe(
	<bloodmagic:component:8>,
	[<astralsorcery:itemusabledust:0>, <botania:spellcloth>, <botania:rune:9>],
	512, 128
);

mods.bloodmagic.TartaricForge.removeRecipe([<minecraft:cauldron>,<minecraft:stone>, <minecraft:dye:4>, <minecraft:diamond>]);
TartaricForge.addRecipe(
	<bloodmagic:demon_crucible>,
	[<botania:shimmerrock>, <xreliquary:mob_ingredient:13>, <minecraft:cauldron>],
	512, 128
);

mods.bloodmagic.TartaricForge.removeRecipe([<bloodmagic:soul_forge>,<minecraft:stone>, <minecraft:dye:4>, <minecraft:glass>]);
TartaricForge.addRecipe(
	<bloodmagic:demon_crystallizer>,
	[<botania:shimmerrock>, <xreliquary:mob_ingredient:7>, <actuallyadditions:item_misc:23>, <bloodmagic:slate:2>],
	512, 128
);
