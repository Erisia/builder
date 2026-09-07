import mods.extrautils2.Resonator;

//RESONATOR RECIPES
//------------------------------------------------------------------------------------------------------------
//ADD RECIPES
Resonator.add(<actuallyadditions:item_misc:5>,<minecraft:quartz>,1500,true);

//------------------------------------------------------------------------------------------------------------

//RECIPES
//------------------------------------------------------------------------------------------------------------
//REMOVE RECIPES
recipes.remove(<extrautils2:resonator>);
recipes.remove(<extrautils2:machine>.withTag({Type: "extrautils2:crusher"}));
recipes.remove(<extrautils2:angelring>);//ANGEL RING
recipes.remove(<extrautils2:angelring:1>);//ANGEL RING
recipes.remove(<extrautils2:angelring:2>);//ANGEL RING
recipes.remove(<extrautils2:angelring:3>);//ANGEL RING
recipes.remove(<extrautils2:angelring:4>);//ANGEL RING
recipes.remove(<extrautils2:angelring:5>);//ANGEL RING
recipes.remove(<extrautils2:machine>.withTag({Type: "extrautils2:generator"}));//FURNACE GENERATOR
recipes.remove(<extendedcrafting:handheld_table>);//HANDHELD CRAFTING TABLE
recipes.remove(<extrautils2:rainbowgenerator>);
recipes.remove(<extrautils2:rainbowgenerator:1>);
recipes.remove(<extrautils2:rainbowgenerator:2>);
recipes.remove(<extrautils2:user>);
recipes.remove(<extrautils2:chickenring>);
recipes.remove(<extrautils2:drum:1>);
recipes.remove(<extrautils2:chickenring:1>);
mods.jei.JEI.hideCategory("xu2_machine_extrautils2:crusher");
mods.jei.JEI.hideCategory("xu2_machine_extrautils2:furnace");
mods.jei.JEI.hideCategory("ORE_WASHER");
mods.jei.JEI.hideCategory("ie.alloysmelter");
mods.jei.JEI.hideCategory("ie.arcFurnace");
mods.jei.JEI.hideCategory("ie.arcFurnace.recycling");
mods.jei.JEI.hideCategory("appliedenergistics2.inscriber");
//ADD RECIPES
recipes.addShaped(<extrautils2:resonator>,[[<minecraft:redstone>,<minecraft:coal_block>,<minecraft:redstone>],
										  [<botania:manaresource>,<extrautils2:ingredients>,<botania:manaresource>],
										  [<botania:manaresource>,<botania:manaresource>,<botania:manaresource>]]);

recipes.addShaped(<extrautils2:chickenring>,[[<minecraft:feather>,<ic2:crafting:3>,<minecraft:feather>],
										[<ic2:crafting:3>,<extrautils2:goldenlasso>,<ic2:crafting:3>],
										[<extrautils2:ingredients:0>,<ic2:crafting:3>,<extrautils2:ingredients:0>]]);

recipes.addShaped(<extrautils2:chickenring:1>,[[<minecraft:ender_pearl>,<ore:dyeBlack>,<minecraft:ender_pearl>],
										[<ore:dyeBlack>,<extrautils2:chickenring>,<ore:dyeBlack>],
										[<minecraft:diamond>,<ic2:jetpack_electric:26>,<minecraft:diamond>]]);

recipes.addShaped(<extrautils2:drum:1>,[[<ore:ingotSteel>,<ore:plateSteel>,<ore:ingotSteel>],
										[<ore:ingotSteel>,<minecraft:cauldron>,<ore:ingotSteel>],
										[<ore:ingotSteel>,<ore:plateSteel>,<ore:ingotSteel>]]);
recipes.addShaped(<extrautils2:machine>.withTag({Type: "extrautils2:generator"}),[[<actuallyadditions:item_crystal:5>,<actuallyadditions:item_crystal:5>,<actuallyadditions:item_crystal:5>],
																				  [<actuallyadditions:item_crystal:5>,<immersiveengineering:metal_decoration0:5>,<actuallyadditions:item_crystal:5>],
																				  [<actuallyadditions:item_crystal>,<extrautils2:machine>.withTag({Type: "extrautils2:furnace"}),<actuallyadditions:item_crystal>]]);
																				 //FURNACE GENERATOR
recipes.addShaped(<extrautils2:decorativesolid:8>,[[null,<ore:dyeBlack>,null],
										[<ore:dyeBlue>,<extrautils2:decorativesolid:3>,<ore:dyeRed>],
										[null,<ore:dyeGreen>,null]]);
recipes.addShapeless(<extrautils2:user>,[<immersiveengineering:metal_decoration0:5>,<botania:cosmetic:32>,<ore:gearBronze>,<extrautils2:ingredients:1>]);//MECHANICAL USER

//------------------------------------------------------------------------------------------------------------