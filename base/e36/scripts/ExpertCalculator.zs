//RECIPES
//------------------------------------------------------------------------------------------------------------
//REMOVE RECIPES
recipes.remove(<calculator:calculatorassembly>); // REMOVE CALCULATOR ASSEMBLY
recipes.remove(<calculator:calculator>); //REMOVE CALCULATOR
recipes.remove(<calculator:powercube>);//REMOVE POWER CUBE
recipes.remove(<calculator:scientificcalculator>);//REMOVE SCIENTIFIC CALCULATOR
recipes.remove(<calculator:atomiccalculator>);//ATOMIC CALCULATOR
recipes.remove(<calculator:flawlesscalculator>);//FLAWLESS CALCULATOR
recipes.remove(<calculator:analysingchamber>);//ANALYSING CHAMBER
recipes.remove(<calculator:atomicmultiplier>);//ATOMIC MULTIPLIER
recipes.remove(<appliedenergistics2:grindstone>);//QUARTZ GRINDSTONE
recipes.remove(<calculator:basicgreenhouse>);//BASIC GREENHOUSE
recipes.remove(<calculator:hungerprocessor>);//HUNGER PROCESSOR
recipes.remove(<calculator:stoneassimilator>);//STONE ASSIMILATOR
//ADD RECIPES

recipes.addShaped(<calculator:calculatorassembly>*2,[[<ore:cobblestone>,<contenttweaker:duskstone_plate>,<ore:cobblestone>],
													   [<contenttweaker:duskstone_plate>,<ore:cobblestone>,<contenttweaker:duskstone_plate>],
													   [<ore:cobblestone>,<contenttweaker:duskstone_plate>,<ore:cobblestone>]]); //ADD CALCULATOR ASSEMBLY

recipes.addShaped(<calculator:calculator>.withTag({Energy: 1000 as long}),[[<ore:cobblestone>,<calculator:calculatorscreen>,<ore:cobblestone>],
										   [<minecraft:stone_button>,<calculator:calculatorassembly>,<minecraft:stone_button>],
										   [<ore:cobblestone>,<ore:cobblestone>,<ore:cobblestone>]]); //ADD CALCULATOR

recipes.addShaped(<calculator:powercube>,[[<contenttweaker:mixed_brick_block>,<ore:cobblestone>,<contenttweaker:mixed_brick_block>],
										  [<ore:cobblestone>,<minecraft:furnace>,<ore:cobblestone>],
										  [<contenttweaker:mixed_brick_block>,<ore:cobblestone>,<contenttweaker:mixed_brick_block>]]); //ADD POWER CUBE

recipes.addShaped(<calculator:scientificcalculator>,[[<calculator:enrichedgoldingot>,<calculator:calculatorscreen>,<ore:ingotSteel>],
													 [<sonarcore:reinforcedstoneblock>,<forestry:chipsets:1>,<sonarcore:reinforcedstoneblock>],
													 [<ore:ingotSteel>,<calculator:calculatorassembly>,<calculator:enrichedgoldingot>]]);

recipes.addShaped(<calculator:atomiccalculator>,[[<ore:ingotPalladium>,<calculator:calculatorscreen>,<ore:ingotPalladium>],
												 [<minecraft:diamond>,<calculator:atomicassembly>,<minecraft:diamond>],
												 [<ore:ingotPalladium>,<minecraft:diamond>,<ore:ingotPalladium>]]);//ATOMIC CALCULATOR

recipes.addShaped(<calculator:hungerprocessor>,[[<calculator:largeamethyst>,<ore:ingotMeteoricIron>,<calculator:largeamethyst>],
												 [<ore:ingotMeteoricIron>,<calculator:advancedassembly>,<ore:ingotMeteoricIron>],
												 [<calculator:largeamethyst>,<ore:ingotMeteoricIron>,<calculator:largeamethyst>]]);//HUNGER PROCESSOR

recipes.addShaped(<calculator:flawlesscalculator>,[[<calculator:flawlessdiamond>,<calculator:calculatorscreen>,<calculator:flawlessdiamond>],
												[<draconicevolution:draconium_ingot>,<calculator:flawlessassembly>,<draconicevolution:draconium_ingot>],
												[<calculator:flawlessdiamond>,<calculator:enddiamond>,<calculator:flawlessdiamond>]]);//FLAWLESS CALCULATOR

recipes.addShaped(<calculator:conductormast>,[[null,null,null],
												[<thermalexpansion:capacitor:2>,<calculator:atomiccalculator>,<thermalexpansion:capacitor:2>],
												[null,null,null]]);//CONDUCTOR MAST
recipes.addShaped(<calculator:basicgreenhouse>,[[<actuallyadditions:block_greenhouse_glass>,<calculator:enrichedgoldingot>,<actuallyadditions:block_greenhouse_glass>],
												[<calculator:enrichedgoldingot>,<calculator:material:3>,<calculator:enrichedgoldingot>],
												[<actuallyadditions:block_greenhouse_glass>,<calculator:enrichedgoldingot>,<actuallyadditions:block_greenhouse_glass>]]);//BASIC GREENHOUSE
//------------------------------------------------------------------------------------------------------------
//SCIENTIFIC CALCULATOR
//------------------------------------------------------------------------------------------------------------
//REMOVE RECIPES
mods.calculator.basic.removeRecipe(<calculator:enrichedgold>*4);

//ADD RECIPES
mods.calculator.basic.addRecipe(<minecraft:gold_ingot>,<minecraft:redstone>,<calculator:enrichedgold>*2);
mods.calculator.scientific.addRecipe(<contenttweaker:insulated_dense_copper_cable>,<forestry:chipsets:2>,<ic2:crafting:1>);//ELECTRONIC CIRCUIT

//------------------------------------------------------------------------------------------------------------
//ATOMIC CALCULATOR
//------------------------------------------------------------------------------------------------------------
//REMOVE RECIPES
mods.calculator.atomic.removeRecipe(<calculator:weatherstation>*4);

//ADD RECIPES
mods.calculator.atomic.addRecipe(<thermalfoundation:material:167>,<contenttweaker:blockcasing_steel>,<ic2:misc_resource:1>,<mekanism:basicblock:8>);

mods.calculator.atomic.addRecipe(<galacticraftcore:basic_item:9>,<galacticraftcore:basic_item:8>,<galacticraftcore:basic_item:10>,<galacticraftcore:heavy_plating>);

mods.calculator.atomic.addRecipe(<galacticraftcore:heavy_plating>,<galacticraftcore:item_basic_moon:1>,<contenttweaker:mixed_blend>,<galacticraftplanets:item_basic_mars:3>);

mods.calculator.atomic.addRecipe(<galacticraftplanets:item_basic_mars:3>,<galacticraftplanets:item_basic_mars:5>,<contenttweaker:mixed_blend>,<galacticraftplanets:item_basic_asteroids:5>);

mods.calculator.atomic.addRecipe(<galacticraftplanets:item_basic_asteroids:5>,<galacticraftplanets:item_basic_asteroids:0>,<extraplanets:tier4_items:4>,<extraplanets:tier4_items:3>);

mods.calculator.atomic.addRecipe(<extraplanets:tier4_items:3>,<extraplanets:tier5_items:4>,<contenttweaker:mixed_blend>,<extraplanets:tier5_items:3>);

mods.calculator.atomic.addRecipe(<extraplanets:tier5_items:3>,<extraplanets:tier6_items:4>,<contenttweaker:mixed_blend>,<extraplanets:tier6_items:3>);

mods.calculator.atomic.addRecipe(<extraplanets:tier6_items:3>,<extraplanets:tier7_items:4>,<contenttweaker:mixed_blend>,<extraplanets:tier7_items:3>);

mods.calculator.atomic.addRecipe(<extraplanets:tier7_items:3>,<extraplanets:tier8_items:4>,<contenttweaker:mixed_blend>,<extraplanets:tier8_items:3>);

mods.calculator.atomic.addRecipe(<extraplanets:tier8_items:3>,<extraplanets:tier9_items:4>,<contenttweaker:mixed_blend>,<extraplanets:tier9_items:3>);

mods.calculator.atomic.addRecipe(<extraplanets:tier9_items:3>,<extraplanets:tier10_items:4>,<contenttweaker:mixed_blend>,<extraplanets:tier10_items:3>);

mods.calculator.atomic.addRecipe(<actuallyadditions:item_crystal_empowered:0>,<thermalfoundation:fertilizer:2>,<thermalfoundation:material:97>,<redstonearsenal:material:0>);

mods.calculator.atomic.addRecipe(<contenttweaker:empowered_steel_ingot>,<contenttweaker:mixed_blend>,<contenttweaker:empowered_steel_ingot>,<calculator:weatherstation>*2);//WEATHER STATION

mods.calculator.atomic.addRecipe(<contenttweaker:empowered_steel_ingot>,<ic2:upgrade>,<calculator:electricdiamond>,<calculator:transmitter>);//TRANSMITTER

//-------------------------------------------------------
//FLAWLESS CALCULATOR
//-------------------------------------------------------
//REMOVE RECIPES
//ADD RECIPES
mods.calculator.flawless.addRecipe(<contenttweaker:star_diamond>,<contenttweaker:draconium_gear>,<ore:gearGold>,<calculator:atomicbinder>,<draconicevolution:draconic_core>);