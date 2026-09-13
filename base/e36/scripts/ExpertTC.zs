import mods.tconstruct.Casting;
import mods.tconstruct.Alloy;
//SMELTERY RECIPES
//------------------------------------------------------------------------------------------------------------
//REMOVE RECIPES


//ADD RECIPES

//------------------------------------------------------------------------------------------------------------

//RECIPES
//------------------------------------------------------------------------------------------------------------
//REMOVE RECIPES
recipes.remove(<tconstruct:seared:3>);
recipes.remove(<tconstruct:seared_slab:3>);
recipes.remove(<tconstruct:materials:12>);
recipes.remove(<tconstruct:materials:13>);
recipes.remove(<tconstruct:materials:14>);
recipes.remove(<tconstruct:seared_glass>);
recipes.remove(<tconstruct:seared_tank:1>);
recipes.remove(<tconstruct:seared_tank:2>);
mods.tconstruct.Casting.removeTableRecipe(<tconstruct:cast_custom:3>);
//ADD RECIPES
recipes.addShaped(<tconstruct:seared:3>,[[<contenttweaker:mixed_brick>,<minecraft:netherbrick>],
										 [<minecraft:brick>,<tconstruct:materials>],
										 ]);
recipes.addShaped(<tconstruct:materials:14>,[[<minecraft:obsidian>,<tconstruct:metal:5>,<minecraft:obsidian>],
										 [<ore:blockElectrum>,<tconstruct:metal:5>,<ore:blockElectrum>],
										 [<minecraft:obsidian>,<tconstruct:metal:5>,<minecraft:obsidian>]]);//REINFORCEMENT
recipes.addShapeless(<tconstruct:seared_glass>, [<ore:blockSeared>, <ore:blockGlass>]);
//ALLOYS
//ADD RECIPES
mods.tconstruct.Alloy.addRecipe(<liquid:stone> * 72, [<liquid:lava> * 125, <liquid:clay> * 18, <liquid:water> * 125]);
mods.tconstruct.Alloy.addRecipe(<liquid:infinity_fluid> * 1000, [<liquid:ic2uu_matter> * 10, <liquid:pyrotheum> * 100, <liquid:petrotheum> * 100, <liquid:cryotheum> * 100, <liquid:aerotheum> * 100, <liquid:liquidfusionfuel> * 50, <liquid:astralsorcery.liquidstarlight> * 1000, <liquid:lifeessence> * 1000, <liquid:liquid_chocolate_fluid> * 200]);
//REMOVE RECIPES
mods.tconstruct.Alloy.removeRecipe(<liquid:electrum>);
mods.tconstruct.Alloy.removeRecipe(<liquid:signalum>);
mods.tconstruct.Alloy.removeRecipe(<liquid:enderium>);
mods.tconstruct.Alloy.removeRecipe(<liquid:lumium>);
mods.tconstruct.Alloy.removeRecipe(<liquid:invar>);
mods.tconstruct.Alloy.removeRecipe(<liquid:constantan>);
mods.tconstruct.Alloy.removeRecipe(<liquid:steel>);
mods.tconstruct.Alloy.removeRecipe(<liquid:obsidian>);
mods.tconstruct.Alloy.removeRecipe(<liquid:tough>);
mods.tconstruct.Alloy.removeRecipe(<liquid:ferroboron>);
mods.tconstruct.Alloy.removeRecipe(<liquid:clay>);
//SMELTING
mods.tconstruct.Melting.removeRecipe(<liquid:lithium>);
mods.tconstruct.Melting.removeRecipe(<liquid:stone>);
mods.tconstruct.Melting.removeRecipe(<liquid:signalum>);
mods.tconstruct.Melting.removeRecipe(<liquid:enderium>);
mods.tconstruct.Melting.removeRecipe(<liquid:lumium>);
mods.tconstruct.Melting.removeRecipe(<liquid:carbon>, <ic2:crafting:15>);
mods.tconstruct.Casting.addBasinRecipe(<contenttweaker:molten_gold_casing>, <tconstruct:clear_glass:0>, <liquid:gold>, 864, true, 100);
mods.tconstruct.Melting.addRecipe(<liquid:gold> * 864,<contenttweaker:molten_gold_casing>);
mods.tconstruct.Melting.addRecipe(<liquid:astral_starmetal> * 144,<astralsorcery:itemcraftingcomponent:2>);
mods.tconstruct.Melting.addRecipe(<liquid:duskstone> * 144,<contenttweaker:duskstone_ingot>);
mods.tconstruct.Melting.addRecipe(<liquid:bedrock> * 144,<contenttweaker:bedrock_crystal>);
mods.tconstruct.Casting.addTableRecipe(<astralsorcery:itemcraftingcomponent:1>, <tconstruct:cast_custom:0>, <liquid:astral_starmetal>, 144, false, 200);
mods.tconstruct.Melting.removeRecipe(<liquid:astral_starmetal>, <astralsorcery:blockcustomore:1>);
mods.tconstruct.Casting.removeTableRecipe(<avaritia:resource:7>);
mods.tconstruct.Casting.removeTableRecipe(<avaritia:matter_cluster>);
