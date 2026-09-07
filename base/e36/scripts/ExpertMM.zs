//REMOVE RECIPES
recipes.remove(<modularmachinery:itemmodularium>);//MODULARIUM
//ADD RECIPES
recipes.addShaped(<modularmachinery:itemmodularium>*4,[[<minecraft:gold_ingot>,<ore:ingotCopper>,<minecraft:gold_ingot>],
																[<ore:ingotCopper>,<minecraft:redstone_block>,<ore:ingotCopper>],
																[<minecraft:redstone>,<minecraft:glowstone_dust>,<minecraft:redstone>]]);//MODULARIUM
recipes.addShaped(<modularmachinery:itemmodularium>*3,[[<ore:ingotSilver>,<ore:ingotCopper>,<ore:ingotSilver>],
																[<ore:ingotCopper>,<minecraft:redstone_block>,<ore:ingotCopper>],
																[<minecraft:redstone>,<minecraft:glowstone_dust>,<minecraft:redstone>]]);//MODULARIUM

recipes.addShaped(<modulardiversity:blockmanainputhatch>,[[<modularmachinery:itemmodularium>,<minecraft:glowstone_dust>,<modularmachinery:itemmodularium>],
																[<minecraft:redstone>,<botania:pool>,<minecraft:redstone>],
																[<modularmachinery:itemmodularium>,<minecraft:glowstone_dust>,<modularmachinery:itemmodularium>]]);//MANA INPUT HATCH
recipes.addShaped(<modularmachinery:blockinputbus:0>,[[<minecraft:hopper>],
																[<modularmachinery:blockcasing>],
																[<ore:chestWood>]]);//TINY ITEM INPUT
recipes.addShaped(<modularmachinery:blockoutputbus:0>,[[<ore:chestWood>],
																[<modularmachinery:blockcasing>],
																[<minecraft:hopper>]]);//TINY ITEM OUTPUT

recipes.addShaped(<modularmachinery:blockcontroller>,[[null,<minecraft:diamond>,null],
																[<minecraft:redstone_block>,<modularmachinery:blockcasing:0>,<minecraft:redstone_block>],
																[<ore:ingotSilver>,<minecraft:redstone_block>,<ore:ingotSilver>]]);//ALT MACHINE CONTROLLER
recipes.addShapeless(<modularmachinery:blockoutputbus:2>,[<modularmachinery:blockinputbus:2>]);//
recipes.addShapeless(<modularmachinery:blockfluidoutputhatch:2>,[<modularmachinery:blockfluidinputhatch:2>]);//
recipes.addShaped(<modulardiversity:blockbiomedetector>,[[<modularmachinery:itemmodularium>,<minecraft:stained_glass:5>,<modularmachinery:itemmodularium>],
																[<minecraft:stained_glass:5>,<calculator:calculatorassembly>,<minecraft:stained_glass:5>],
																[<modularmachinery:itemmodularium>,<minecraft:stained_glass:5>,<modularmachinery:itemmodularium>]]);//BIOME DETECTOR
recipes.addShapeless(<modularmachinery:blockfluidoutputhatch:6>,[<modularmachinery:blockfluidinputhatch:6>]);//
recipes.addShapeless(<modularmachinery:blockenergyoutputhatch:6>,[<modularmachinery:blockenergyinputhatch:6>]);//
recipes.addShapeless(<modularmachinery:blockoutputbus:6>,[<modularmachinery:blockinputbus:6>]);//
recipes.addShapeless(<modularmachinery:blockenergyoutputhatch:2>,[<modularmachinery:blockenergyinputhatch:2>]);//

recipes.addShapeless(<modularmachinery:blockinputbus:2>,[<modularmachinery:blockoutputbus:2>]);//
recipes.addShapeless(<modularmachinery:blockfluidinputhatch:2>,[<modularmachinery:blockfluidoutputhatch:2>]);//
recipes.addShapeless(<modularmachinery:blockfluidinputhatch:6>,[<modularmachinery:blockfluidoutputhatch:6>]);//
recipes.addShapeless(<modularmachinery:blockenergyinputhatch:6>,[<modularmachinery:blockenergyoutputhatch:6>]);//
recipes.addShapeless(<modularmachinery:blockinputbus:6>,[<modularmachinery:blockoutputbus:6>]);//
recipes.addShapeless(<modularmachinery:blockenergyinputhatch:2>,[<modularmachinery:blockenergyoutputhatch:2>]);//