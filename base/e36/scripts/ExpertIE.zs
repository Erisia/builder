import mods.immersiveengineering.CokeOven;

//BLAST FURNACE
//REMOVE FUEL
mods.immersiveengineering.BlastFurnace.removeFuel(<minecraft:coal:1>);
mods.immersiveengineering.BlastFurnace.removeFuel(<actuallyadditions:block_misc:5>);
mods.immersiveengineering.BlastFurnace.removeFuel(<mekanism:basicblock:3>);
mods.immersiveengineering.BlastFurnace.removeFuel(<forestry:charcoal>);

//ADD RECIPE


//COKE OVEN
//ADD RECIPE
CokeOven.addRecipe(<contenttweaker:mixed_brick>*2, 0,<contenttweaker:mixed_blend> , 400);


//REMOVE RECIPES
//Coke Brick
recipes.remove(<immersiveengineering:stone_decoration>);
//BLAST BRICK
recipes.remove(<immersiveengineering:stone_decoration:1>);
recipes.remove(<immersiveengineering:metal_device1:13>);//GARDEN CLOCHE
//ALLOY KILN
recipes.remove(<immersiveengineering:stone_decoration:10>);//ALLOY KILN
recipes.remove(<immersiveengineering:metal:16>);//ELECTRUM
recipes.remove(<thermalfoundation:material:97>);//ELECTRUM
//ADD RECIPES
//Coke Brick

recipes.addShaped(<immersiveengineering:stone_decoration>,[[<contenttweaker:mixed_blend>,<minecraft:brick>,<contenttweaker:mixed_blend>],
														   [<minecraft:brick>,<actuallyadditions:block_testifi_bucks_white_wall>,<minecraft:brick>],
														   [<contenttweaker:mixed_blend>,<minecraft:brick>,<contenttweaker:mixed_blend>]]);
//BLAST BRICK
recipes.addShaped(<immersiveengineering:stone_decoration:1>,[[<minecraft:netherbrick>,<contenttweaker:mixed_brick>,<minecraft:netherbrick>],
														   [<contenttweaker:mixed_brick>,<contenttweaker:bedrock_shard>,<contenttweaker:mixed_brick>],
														   [<minecraft:netherbrick>,<contenttweaker:mixed_brick>,<minecraft:netherbrick>]]);

//recipes.addShaped(<immersiveengineering:metalDevice1:13>*4,[[null,<calculator:GasLanternOff>,null],
														  //[<enderio:blockFusedQuartz>,<calculator:FlawlessGreenhouse>,<enderio:blockFusedQuartz>],
														  //[<ore:plankTreatedWood>,<actuallyadditions:blockFarmer>,<ore:plankTreatedWood>]]);//GARDEN CLOCHE
recipes.remove(<immersiveengineering:mold:0>);// PLATE MOLD
recipes.remove(<immersiveengineering:sheetmetal_slab:8>);//STEEL SHEETMETAL SLAB
recipes.remove(<immersiveengineering:metal:30>);
recipes.remove(<immersiveengineering:metal:31>);
recipes.remove(<immersiveengineering:metal:32>);
recipes.remove(<immersiveengineering:metal:33>);
recipes.remove(<immersiveengineering:metal:34>);
recipes.remove(<immersiveengineering:metal:35>);
recipes.remove(<immersiveengineering:metal:36>);
recipes.remove(<immersiveengineering:metal:37>);
recipes.remove(<immersiveengineering:metal:38>);
recipes.remove(<immersiveengineering:metal:39>);
recipes.remove(<immersiveengineering:metal:40>);
recipes.remove(<immersiveengineering:metal:41>);
recipes.remove(<immersiveengineering:metal_device0:2>);//HV CAPACITOR
recipes.remove(<immersiveengineering:metal_decoration0:6>);//GENERATOR BLOCK
recipes.remove(<immersivetech:metal_device>);//
//------
//ADD RECIPES
//-------

recipes.addShaped(<immersiveengineering:metal_device0:2>,[[<contenttweaker:empowered_steel_ingot>,<contenttweaker:empowered_steel_ingot>,<contenttweaker:empowered_steel_ingot>],
						[<ore:plateAluminum>,<contenttweaker:blockcasing_steel>,<ore:plateAluminum>],
						[<ore:plankTreatedWood>,<actuallyadditions:block_crystal:0>,<ore:plankTreatedWood>]]);//HV CAPACITOR

recipes.addShaped(<immersiveengineering:metal_decoration0:6>*2,[[<extraplanets:tier5_items:5>,<ore:ingotSteel>,<extraplanets:tier5_items:5>],
														   [<ore:ingotElectrum>,<immersiveengineering:metal_device1:2>,<ore:ingotElectrum>],
														   [<extraplanets:tier5_items:5>,<ore:ingotSteel>,<extraplanets:tier5_items:5>]]);//GENERATOR BLOCK


//BOTTLING MACHINE
//ADD RECIPE
mods.immersiveengineering.BottlingMachine.addRecipe(<mekanism:biofuel>,<actuallyadditions:item_misc:21>, <liquid:biomass> * 100);

//CRUSHER
mods.immersiveengineering.Crusher.removeRecipe(<astralsorcery:itemcraftingcomponent:2>);

//ARC FURNACE
mods.immersiveengineering.ArcFurnace.removeRecipe(<astralsorcery:itemcraftingcomponent:1>);



