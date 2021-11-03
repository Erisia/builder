#packmode artisansimple
import mods.artisanworktables.builder.RecipeBuilder;


/*
  .setShaped([
    [null, null, null, null, null],
    [null, null, null, null, null],
	[null, null, null, null, null],
	[null, null, null, null, null],
    [null, null, null, null, null]])
	
	<liquid:purified_water>
	<liquid:creosote>
	
*/


//  Shapeless ======================================================================================================================
RecipeBuilder.get("basic")
  .setShapeless([<embers:blend_caminite>, <embers:blend_caminite>])
  .addOutput(<embers:plate_caminite_raw> * 2)
    .create();

//  Shaped ==============================================================================================================================
  RecipeBuilder.get("basic")
  .setShaped([
[<embers:block_caminite_brick>, <embers:adhesive>, <embers:block_caminite_brick>, <embers:adhesive>, <embers:block_caminite_brick>], 
  [<embers:adhesive>, null, <embers:block_caminite_brick_slab>, null, <embers:adhesive>], 
  [<embers:block_caminite_brick>, <embers:block_caminite_brick_slab>, <embers:block_tank>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick>], 
  [<embers:adhesive>, null, <embers:block_caminite_brick_slab>, null, <embers:adhesive>], 
  [<embers:block_caminite_brick>, <embers:adhesive>, <embers:block_caminite_brick>, <embers:adhesive>, <embers:block_caminite_brick>]])
    .addOutput(<embers:large_tank>)
    .create();

  RecipeBuilder.get("basic")
  .setShaped([
 [<embers:block_caminite_brick>, <embers:adhesive>, <embers:pump>, <embers:adhesive>, <embers:block_caminite_brick>], 
  [<embers:adhesive>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick_slab>, <embers:adhesive>], 
  [<embers:pump>, <embers:block_caminite_brick_slab>, null, <embers:block_caminite_brick_slab>, <embers:pump>], 
  [<embers:adhesive>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick_slab>, <embers:adhesive>], 
  [<embers:block_caminite_brick>, <embers:adhesive>, <embers:pump>, <embers:adhesive>, <embers:block_caminite_brick>]])
    .addOutput(<embers:stone_valve>)
    .create();

    RecipeBuilder.get("basic")
  .setShaped([
  [<embers:block_caminite_brick>, <embers:adhesive>, <embers:block_caminite_brick>, <embers:adhesive>, <embers:block_caminite_brick>], 
  [<embers:adhesive>, null, null, null, <embers:adhesive>], 
  [<embers:block_caminite_brick>, null, null, null, <embers:block_caminite_brick>], 
  [<embers:adhesive>, null, null, null, <embers:adhesive>], 
  [<embers:block_caminite_brick>, <embers:adhesive>, <embers:block_caminite_brick>, <embers:adhesive>, <embers:block_caminite_brick>]])
    .addOutput(<embers:stone_edge>)
    .create();

    RecipeBuilder.get("basic")
  .setShaped([
 	[<embers:block_caminite_brick>, <embers:adhesive>, <embers:block_caminite_brick>, <embers:adhesive>, <embers:block_caminite_brick>], 
	[<embers:adhesive>, <immersiveengineering:metal_decoration0>, <embers:block_caminite_brick_slab>, <immersiveengineering:metal_decoration0>, <embers:adhesive>], 
	[<embers:block_caminite_brick>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick>], 
	[<embers:adhesive>, <immersiveengineering:metal_decoration0>, <embers:block_caminite_brick_slab>, <immersiveengineering:metal_decoration0>, <embers:adhesive>], 
	[<embers:block_caminite_brick>, <embers:adhesive>, <embers:block_caminite_brick>, <embers:adhesive>, <embers:block_caminite_brick>]])
    .addOutput(<embers:heat_coil>)
    .create();

      RecipeBuilder.get("basic")
  .setShaped([
  [<embers:plate_caminite>, <ore:blockGlassColorless>, <ore:blockGlassColorless>, <ore:blockGlassColorless>, <embers:plate_caminite>], 
  [<embers:adhesive>, <ore:plateLead>, <ore:blockGlassColorless>, <ore:plateLead>, <embers:adhesive>], 
  [<immersiveengineering:material:8>, <ore:blockGlassColorless>, <ore:blockGlassColorless>, <ore:blockGlassColorless>, <immersiveengineering:material:8>], 
  [<embers:adhesive>, <ore:plateLead>, <ore:blockGlassColorless>, <ore:plateLead>, <embers:adhesive>], 
  [<embers:plate_caminite>, <embers:adhesive>, <embers:plate_caminite>, <embers:adhesive>, <embers:plate_caminite>]])
    .addOutput(<embers:heat_coil>)
    .create();

      RecipeBuilder.get("basic")
  .setShaped([
	[<embers:block_caminite_brick>, <ore:plateIron>, <ore:plateIron>, <embers:block_caminite_brick>, null], 
	[<embers:block_caminite_brick_slab>, <ore:blockGlassColorless>, <ore:blockGlassColorless>, <embers:block_caminite_brick_slab>, null], 
	[<embers:adhesive>, <ore:plateIron>, <ore:plateIron>, <embers:adhesive>, null], 
	[<embers:block_caminite_brick>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick>, null], 
	[null, null, null, null, null]])
    .addOutput(<embers:block_tank>)
    .create();

            RecipeBuilder.get("basic")
  .setShaped([
  [<toughasnails:magma_shard>, <embers:plate_caminite>, <toughasnails:magma_shard>], 
  [<embers:plate_caminite>, <embers:plate_caminite>, <embers:plate_caminite>], 
  [<toughasnails:magma_shard>, <embers:plate_caminite>, <toughasnails:magma_shard>]])
  .addOutput(<embers:archaic_light>)
    .create();

            RecipeBuilder.get("basic")
  .setShaped([
  [<embers:brick_caminite>, <embers:brick_caminite>, null], 
  [<embers:brick_caminite>, <embers:brick_caminite>, null], 
  [null, null, null]])
  .addOutput(<embers:block_caminite_brick> * 2)
    .create();

            RecipeBuilder.get("basic")
  .setShaped([
  [<embers:block_caminite_brick>, null, null], 
  [<embers:block_caminite_brick>, <embers:block_caminite_brick>, null], 
  [<embers:block_caminite_brick>, <embers:block_caminite_brick>, <embers:block_caminite_brick>]])
  .addOutput(<embers:stairs_caminite_brick> * 4)
    .create();
            
            RecipeBuilder.get("basic")
    .setShaped([
  [null, null, null], 
  [null, null, null], 
  [<embers:block_caminite_brick>, <embers:block_caminite_brick>, <embers:block_caminite_brick>]])
  .addOutput(<embers:block_caminite_brick_slab> * 6)
    .create();

              RecipeBuilder.get("basic")
    .setShaped([
  [<minecraft:brick_block>, <minecraft:brick_block>, <ore:blockHopper>, <minecraft:brick_block>, <minecraft:brick_block>], 
	[<minecraft:brick_block>, <ore:plateSteel>, <ore:plateSteel>, <ore:plateSteel>, <minecraft:brick_block>], 
	[<minecraft:brick_block>, <ore:plateSteel>, <minecraft:furnace>, <ore:plateSteel>, <minecraft:brick_block>], 
	[<minecraft:brick_block>, <ore:plateSteel>, <ore:plateSteel>, <ore:plateSteel>, <minecraft:brick_block>], 
	[<minecraft:brick_block>, <minecraft:brick_block>, <minecraft:brick_block>, <minecraft:brick_block>, <minecraft:brick_block>]])
  .addOutput(<magneticraft:combustion_chamber>)
    .create();

              RecipeBuilder.get("basic")
    .setShaped([
  [<embers:brick_caminite>, <ore:ingotBrick>, <embers:brick_caminite>], 
	[<ore:ingotBrick>, <toughasnails:magma_shard>, <ore:ingotBrick>], 
	[<embers:brick_caminite>, <ore:ingotBrick>, <embers:brick_caminite>]])
	  .addOutput(<immersiveengineering:stone_decoration:1> * 2)
    .create();

              RecipeBuilder.get("basic")
    .setShaped([
  [<embers:brick_caminite>, <coralreef:reef:1>, <embers:brick_caminite>], 
	[<coralreef:reef:1>, <minecraft:brick_block>, <coralreef:reef:1>], 
	[<embers:brick_caminite>, <coralreef:reef:1>, <embers:brick_caminite>]])
	  .addOutput(<immersiveengineering:stone_decoration:0> * 2)
    .create();

              RecipeBuilder.get("basic")
    .setShaped([
  [<ore:dustObsidian>, <ore:crystalSlag>, <ore:dustObsidian>, null, null], 
  [<ore:crystalSlag>, <ore:dustObsidian>, <ore:crystalSlag>, null, null], 
  [<ore:dustObsidian>, <ore:crystalSlag>, <ore:dustObsidian>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
    .addOutput(<enderio:block_reinforced_obsidian>)
    .create();

                RecipeBuilder.get("basic")
    .setShaped([
  [<coralreef:reef:1>, <ore:ingotBrick>, <coralreef:reef:1>], 
  [<ore:ingotBrick>, <coralreef:reef:1>, <ore:ingotBrick>], 
  [<coralreef:reef:1>, <ore:ingotBrick>, <coralreef:reef:1>]])
    .addOutput(<immersiveengineering:stone_decoration:10> * 2)
    .create();
