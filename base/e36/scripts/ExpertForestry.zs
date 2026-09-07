import mods.forestry.Carpenter;
import mods.forestry.Squeezer;
import mods.forestry.Moistener;
import mods.forestry.ThermionicFabricator;
//REMOVE RECIPES
// Sturdy Casing
recipes.remove(<forestry:sturdy_machine>);
//ARBORETUM
recipes.remove(<forestry:arboretum>);
//CROPS FARM
recipes.remove(<forestry:farm_crops>);
//MUSHROOM FARM
recipes.remove(<forestry:farm_mushroom>);
//GOURD FARM
recipes.remove(<forestry:farm_gourd>);
//INFERNAL FARM
recipes.remove(<forestry:farm_nether>);
//ENDER FARM
recipes.remove(<forestry:farm_ender>);
//PEAT FARM
recipes.remove(<forestry:peat_bog>);
recipes.remove(<forestry:scoop>);

//ADD RECIPES
val water = <liquid:water> * 1000;
val dirt = <ore:dirt>;
val sand = <ore:sand>;

recipes.removeShaped(<forestry:bog_earth>,
 [[dirt,sand,dirt],
  [sand,<minecraft:water_bucket>,sand],
  [dirt,sand,dirt]]);

recipes.addShaped("CTBogEarth", <forestry:bog_earth> * 6,
 [[dirt,sand,dirt],
  [sand,water,sand],
  [dirt,sand,dirt]]);
// Sturdy Casing
recipes.addShaped(<forestry:sturdy_machine>,[[<ore:ingotBronze>,<ore:gearBronze>,<ore:ingotBronze>],
											[<actuallyadditions:item_crystal:5>,<immersiveengineering:metal_decoration0:5>,<actuallyadditions:item_crystal:5>],
											[<ore:ingotBronze>,<actuallyadditions:item_misc:8>,<ore:ingotBronze>]]);

//ARBORETUM
recipes.addShaped(<forestry:arboretum>,[[<minecraft:stained_glass:5>,<forestry:chipsets>.withTag({T: 0 as short}),<minecraft:stained_glass:5>],
										[<forestry:thermionic_tubes:4>,<forestry:flexible_casing>,<forestry:thermionic_tubes:4>],
										[<minecraft:stained_glass:5>,<actuallyadditions:block_farmer>,<minecraft:stained_glass:5>]]);

//CROPS FARM
recipes.addShaped(<forestry:farm_crops>,[[<minecraft:stained_glass:12>,<forestry:chipsets>.withTag({T: 0 as short}),<minecraft:stained_glass:12>],
										[<forestry:thermionic_tubes:2>,<forestry:flexible_casing>,<forestry:thermionic_tubes:2>],
										[<minecraft:stained_glass:12>,<actuallyadditions:block_farmer>,<minecraft:stained_glass:12>]]);
//MUSHROOM FARM
recipes.addShaped(<forestry:farm_mushroom>,[[<minecraft:stained_glass:3>,<forestry:chipsets>.withTag({T: 0 as short}),<minecraft:stained_glass:3>],
										[<forestry:thermionic_tubes:10>,<forestry:flexible_casing>,<forestry:thermionic_tubes:10>],
										[<minecraft:stained_glass:3>,<actuallyadditions:block_farmer>,<minecraft:stained_glass:3>]]);

//GOURD FARM
recipes.addShaped(<forestry:farm_gourd>,[[<minecraft:stained_glass:4>,<forestry:chipsets>.withTag({T: 0 as short}),<minecraft:stained_glass:4>],
										[<forestry:thermionic_tubes:11>,<forestry:flexible_casing>,<forestry:thermionic_tubes:11>],
										[<minecraft:stained_glass:4>,<actuallyadditions:block_farmer>,<minecraft:stained_glass:4>]]);

//INFERNAL FARM
recipes.addShaped(<forestry:farm_nether>,[[<minecraft:stained_glass:14>,<forestry:chipsets>.withTag({T: 0 as short}),<minecraft:stained_glass:14>],
										  [<forestry:thermionic_tubes:7>,<forestry:flexible_casing>,<forestry:thermionic_tubes:7>],
										  [<minecraft:stained_glass:14>,<actuallyadditions:block_farmer>,<minecraft:stained_glass:14>]]);

//ENDER FARM
recipes.addShaped(<forestry:farm_ender>,[[<minecraft:stained_glass:13>,<forestry:chipsets>.withTag({T: 0 as short}),<minecraft:stained_glass:13>],
										  [<forestry:thermionic_tubes:12>,<forestry:flexible_casing>,<forestry:thermionic_tubes:12>],
										  [<minecraft:stained_glass:13>,<actuallyadditions:block_farmer>,<minecraft:stained_glass:13>]]);
//PEAT FARM
recipes.addShaped(<forestry:peat_bog>,[[<minecraft:stained_glass:15>,<forestry:chipsets>.withTag({T: 0 as short}),<minecraft:stained_glass:15>],
										  [<forestry:thermionic_tubes:6>,<forestry:flexible_casing>,<forestry:thermionic_tubes:6>],
										  [<minecraft:stained_glass:15>,<actuallyadditions:block_farmer>,<minecraft:stained_glass:15>]]);
recipes.addShaped(<forestry:bog_earth>*4,[[<minecraft:dirt>,<minecraft:sand>,<minecraft:dirt>],
										  [<minecraft:sand>,<harvestcraft:freshwateritem>,<minecraft:sand>],
										  [<minecraft:dirt>,<minecraft:sand>,<minecraft:dirt>]]);
recipes.addShaped(<forestry:scoop>,[[<immersiveengineering:material>,<ore:wool>,<immersiveengineering:material>],
										  [<immersiveengineering:material>,<immersiveengineering:material>,<immersiveengineering:material>],
										  [null,<immersiveengineering:material>,null]]);
recipes.addShapeless(<forestry:farm_crops>,[<forestry:farm_crops:1>]);
recipes.addShapeless(<forestry:farm_mushroom>, [<forestry:farm_mushroom:1>]);
recipes.addShapeless(<forestry:farm_gourd>, [<forestry:farm_gourd:1>]);
recipes.addShapeless(<forestry:farm_nether>, [<forestry:farm_nether:1>]);
recipes.addShapeless(<forestry:farm_ender>, [<forestry:farm_ender:1>]);
recipes.addShapeless(<forestry:peat_bog>, [<forestry:peat_bog:1>]);
recipes.addShapeless(<forestry:arboretum>, [<forestry:arboretum:1>]);

//----------------------------------------------------------------------------------------------------------------------------
//CARPENTER
//----------------------------------------------------------------------------------------------------------------------------
//REMOVE RECIPES
//----------------------------------------------------------------------------------------------------------------------------
Carpenter.removeRecipe(<forestry:chipsets>.withTag({T: 0 as short}), <liquid:water>);
Carpenter.removeRecipe(<forestry:chipsets:1>, <liquid:water>);
Carpenter.removeRecipe(<forestry:chipsets:2>, <liquid:water>);
Carpenter.removeRecipe(<forestry:chipsets:3>, <liquid:water>);
//----------------------------------------------------------------------------------------------------------------------------
//ADD RECIPES
//----------------------------------------------------------------------------------------------------------------------------
Carpenter.addRecipe(<forestry:chipsets>,[[<actuallyadditions:item_crystal>,null,<actuallyadditions:item_crystal>],
										 [<actuallyadditions:item_crystal>,<actuallyadditions:item_misc:7>,<actuallyadditions:item_crystal>],
										 [<actuallyadditions:item_crystal>,null,<actuallyadditions:item_crystal>]],20,<liquid:water>*1000);

Carpenter.addRecipe(<forestry:chipsets:2>,[[<actuallyadditions:item_crystal>,<actuallyadditions:item_crystal:5>,<actuallyadditions:item_crystal>],
										 [<actuallyadditions:item_crystal>,<actuallyadditions:item_misc:7>,<actuallyadditions:item_crystal>],
										 [<actuallyadditions:item_crystal>,<actuallyadditions:item_crystal:5>,<actuallyadditions:item_crystal>]],20,<liquid:water>*1000);

Carpenter.addRecipe(<forestry:chipsets:1>,[[<actuallyadditions:item_crystal>,<contenttweaker:duskstone_ingot>,<actuallyadditions:item_crystal>],
										 [<actuallyadditions:item_crystal>,<actuallyadditions:item_misc:8>,<actuallyadditions:item_crystal>],
										 [<actuallyadditions:item_crystal>,<contenttweaker:duskstone_ingot>,<actuallyadditions:item_crystal>]],20,<liquid:water>*1000);

Carpenter.addRecipe(<forestry:chipsets:3>,[[<actuallyadditions:item_crystal>,<calculator:enrichedgoldingot>,<actuallyadditions:item_crystal>],
										 [<actuallyadditions:item_crystal>,<actuallyadditions:item_misc:8>,<actuallyadditions:item_crystal>],
										 [<actuallyadditions:item_crystal>,<calculator:enrichedgoldingot>,<actuallyadditions:item_crystal>]],20,<liquid:water>*1000);
Carpenter.addRecipe(<forestry:peat>*8,[[<forestry:bog_earth>,<forestry:bog_earth>,null],
										 [<forestry:bog_earth>,<forestry:bog_earth>,null],
										 [null,null,null]],20,<liquid:water>*1000);//PEAT
Carpenter.addRecipe(<contenttweaker:filled_rubber_electron_tube>,[[null,null,null],
										 [null,<forestry:thermionic_tubes:8>,null],
										 [null,null,null]],20,<liquid:ic2biomass>*250);//FILLED RUBBERIZED ELECTRON TUBE

//SQUEEZER
//REMOVE RECIPES
Squeezer.removeRecipe(<liquid:seed.oil>, [<actuallyadditions:item_canola_seed>]);
Squeezer.removeRecipe(<liquid:canolaoil>, [<actuallyadditions:item_misc:13>]);
//ADD RECIPES
Squeezer.addRecipe(<liquid:seed.oil>*3,[<actuallyadditions:item_canola_seed>],20,<actuallyadditions:item_misc:21> % 50);
Squeezer.addRecipe(<liquid:canolaoil>*80,[<actuallyadditions:item_misc:13>],20,<actuallyadditions:item_misc:21> % 50);


//MOISTENER
//REMOVE RECIPES

//ADD RECIPES
Moistener.addRecipe(<minecraft:grass>, <minecraft:dirt>, 5000);

//----------------------------------------------------------------------------------------------------------------------------
//THERMIONIC FABRICATOR
//----------------------------------------------------------------------------------------------------------------------------
//ADD SMELTING 
//----------------------------------------------------------------------------------------------------------------------------
ThermionicFabricator.addSmelting(<liquid: canolaoil>*50,<actuallyadditions:item_misc:13>,1500);

//----------------------------------------------------------------------------------------------------------------------------
//REMOVE RECIPES
//----------------------------------------------------------------------------------------------------------------------------
ThermionicFabricator.removeCast(<forestry:thermionic_tubes>); 		//COPPER ELETRON TUBES
ThermionicFabricator.removeCast(<forestry:thermionic_tubes:1>); 	//TIN ELETRON TUBE
ThermionicFabricator.removeCast(<forestry:thermionic_tubes:2>); 	//BRONZE ELETRON TUBE
ThermionicFabricator.removeCast(<forestry:thermionic_tubes:4>); 	//GOLD ELETRON TUBE
ThermionicFabricator.removeCast(<forestry:thermionic_tubes:5>); 	//DIAMOND ELETRON TUBE
ThermionicFabricator.removeCast(<forestry:thermionic_tubes:6>); 	//OBSIDIAN ELETRON TUBE
ThermionicFabricator.removeCast(<forestry:thermionic_tubes:7>);		//BLAZE ELETRON TUBE	
ThermionicFabricator.removeCast(<forestry:thermionic_tubes:9>);		//EMERALD ELETRON TUBE
ThermionicFabricator.removeCast(<forestry:thermionic_tubes:10>);	//APATINE ELETRON TUBE
ThermionicFabricator.removeCast(<forestry:thermionic_tubes:11>);	//LAPIS ELETRON TUBE
ThermionicFabricator.removeCast(<forestry:thermionic_tubes:12>);	//ENDER ELETRON TUBE


//----------------------------------------------------------------------------------------------------------------------------
//ADD RECIPES
//----------------------------------------------------------------------------------------------------------------------------
mods.forestry.ThermionicFabricator.addCast(<forestry:thermionic_tubes>*2 , [[null,<ore:ingotCopper>,null],
																			[<actuallyadditions:item_crystal>,<ore:ingotCopper>,<actuallyadditions:item_crystal>],
																			[<ore:ingotCopper>,<ore:ingotCopper>,<ore:ingotCopper>]], <liquid: canolaoil> * 500);

mods.forestry.ThermionicFabricator.addCast(<forestry:thermionic_tubes:1>*2 , [[null,<ore:ingotTin>,null],
																			[<actuallyadditions:item_crystal>,<ore:ingotTin>,<actuallyadditions:item_crystal>],
																			[<ore:ingotTin>,<ore:ingotTin>,<ore:ingotTin>]], <liquid: canolaoil> * 500);

mods.forestry.ThermionicFabricator.addCast(<forestry:thermionic_tubes:2>*2 , [[null,<ore:ingotBronze>,null],
																			[<actuallyadditions:item_crystal>,<ore:ingotBronze>,<actuallyadditions:item_crystal>],
																			[<ore:ingotBronze>,<ore:ingotBronze>,<ore:ingotBronze>]], <liquid: canolaoil> * 500);

mods.forestry.ThermionicFabricator.addCast(<forestry:thermionic_tubes:4>*2 , [[null,<ore:ingotGold>,null],
																			[<actuallyadditions:item_crystal>,<ore:ingotGold>,<actuallyadditions:item_crystal>],
																			[<ore:ingotGold>,<ore:ingotGold>,<ore:ingotGold>]], <liquid: canolaoil> * 500);

mods.forestry.ThermionicFabricator.addCast(<forestry:thermionic_tubes:5>*2 , [[null,<ore:gemDiamond>,null],
																			[<actuallyadditions:item_crystal>,<ore:gemDiamond>,<actuallyadditions:item_crystal>],
																			[<ore:gemDiamond>,<ore:gemDiamond>,<ore:gemDiamond>]], <liquid: canolaoil> * 500);

mods.forestry.ThermionicFabricator.addCast(<forestry:thermionic_tubes:6>*2 , [[null,<minecraft:obsidian>,null],
																			[<actuallyadditions:item_crystal>,<minecraft:obsidian>,<actuallyadditions:item_crystal>],
																			[<minecraft:obsidian>,<minecraft:obsidian>,<minecraft:obsidian>]], <liquid: canolaoil> * 500);

mods.forestry.ThermionicFabricator.addCast(<forestry:thermionic_tubes:7>*2 , [[null,<minecraft:blaze_powder>,null],
																			[<actuallyadditions:item_crystal>,<minecraft:blaze_powder>,<actuallyadditions:item_crystal>],
																			[<minecraft:blaze_powder>,<minecraft:blaze_powder>,<minecraft:blaze_powder>]], <liquid: canolaoil> * 500);

mods.forestry.ThermionicFabricator.addCast(<forestry:thermionic_tubes:9>*2 , [[null,<ore:gemEmerald>,null],
																			[<actuallyadditions:item_crystal>,<ore:gemEmerald>,<actuallyadditions:item_crystal>],
																			[<ore:gemEmerald>,<ore:gemEmerald>,<ore:gemEmerald>]], <liquid: canolaoil> * 500);

mods.forestry.ThermionicFabricator.addCast(<forestry:thermionic_tubes:10>*2 , [[null,<forestry:apatite>,null],
																			[<actuallyadditions:item_crystal>,<forestry:apatite>,<actuallyadditions:item_crystal>],
																			[<forestry:apatite>,<forestry:apatite>,<forestry:apatite>]], <liquid: canolaoil> * 500);

mods.forestry.ThermionicFabricator.addCast(<forestry:thermionic_tubes:11>*2 , [[null,<ore:gemLapis>,null],
																			[<actuallyadditions:item_crystal>,<ore:gemLapis>,<actuallyadditions:item_crystal>],
																			[<ore:gemLapis>,<ore:gemLapis>,<ore:gemLapis>]], <liquid: canolaoil> * 500);

mods.forestry.ThermionicFabricator.addCast(<forestry:thermionic_tubes:12>*2 , [[<minecraft:ender_eye>,<minecraft:end_stone>,<minecraft:ender_eye>],
																			[<actuallyadditions:item_crystal>,<minecraft:end_stone>,<actuallyadditions:item_crystal>],
																			[<minecraft:end_stone>,<minecraft:end_stone>,<minecraft:end_stone>]], <liquid: canolaoil> * 500);																																																																					