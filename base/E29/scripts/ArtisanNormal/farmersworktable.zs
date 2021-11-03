#packmode artisannormal
import mods.artisanworktables.builder.RecipeBuilder;


//  Shapeless =================================================================================================
RecipeBuilder.get("farmer")
  .setShapeless([<minecraft:apple>, <ore:treeSapling>])
  .setFluid(<liquid:purified_water> * 1000)
  .addOutput(<harvestcraft:apple_sapling>)
  .addTool(<ore:artisansKnife>, 16)
  .create();

  RecipeBuilder.get("farmer")
  .setShapeless([<additionalcompression:meatbeef_compressed>])
    .addOutput(<rats:assorted_vegetables>)
      .addTool(<ore:artisansKnife>, 16)
      .create();
      
RecipeBuilder.get("farmer")
  .setShapeless([<additionalcompression:meatchicken_compressed>])
    .addOutput(<rats:assorted_vegetables>)
      .addTool(<ore:artisansKnife>, 16)
      .create();
      
RecipeBuilder.get("farmer")
  .setShapeless([<additionalcompression:leather_compressed>])
    .addOutput(<rats:assorted_vegetables>)
      .addTool(<ore:artisansKnife>, 16)
      .create();
      
RecipeBuilder.get("farmer")
  .setShapeless([<additionalcompression:meatfish_compressed>])
    .addOutput(<rats:assorted_vegetables>)
      .addTool(<ore:artisansKnife>, 16)
      .create();
      
RecipeBuilder.get("farmer")
  .setShapeless([<additionalcompression:pearlender_compressed>])
    .addOutput(<rats:assorted_vegetables>)
      .addTool(<ore:artisansKnife>, 16)
      .create();
      
RecipeBuilder.get("farmer")
  .setShapeless([<additionalcompression:spidereye_compressed>])
    .addOutput(<rats:assorted_vegetables>)
      .addTool(<ore:artisansKnife>, 16)
      .create();
      
RecipeBuilder.get("farmer")
  .setShapeless([<additionalcompression:meatrotten_compressed>])
    .addOutput(<rats:assorted_vegetables>)
      .addTool(<ore:artisansKnife>, 16)
      .create();

  RecipeBuilder.get("farmer")
  .setShapeless([  <redstone_lock:compressedleaves>,   <redstone_lock:compressedleaves>,   <redstone_lock:compressedleaves>])
  .setFluid(<liquid:water> * 250)
  .addOutput(<minecraft:paper>)
  .addTool(<ore:artisansKnife>, 8)
  .create();

  RecipeBuilder.get("farmer")
  .setShapeless([<rats:block_of_cheese>])
  .addOutput(<rats:cheese> * 4)
  .addTool(<ore:artisansKnife>, 16)
  .create();

    RecipeBuilder.get("farmer")
  .setShapeless([<minecraft:clay>])
  .addOutput(<minecraft:clay_ball> * 4)
  .addTool(<ore:artisansKnife>, 1)
  .create();


//  Shaped ==================================================================================
  RecipeBuilder.get("farmer")
  .setShaped([
	[<minecraft:leaves>, <minecraft:leaves>, null],
	[<minecraft:leaves>, <minecraft:leaves>, null], 
	[<minecraft:leaves>, <minecraft:leaves>, null]])
  .setFluid(<liquid:purified_water> * 100)
  .addOutput(<minecraft:vine> * 4)
  .addTool(<ore:artisansKnife>, 2)
  .create();

    RecipeBuilder.get("farmer")
  .setShaped([
  [<ore:ingotLead>, <extratan:tempered_glass_block>, <ore:ingotLead>], 
  [<extratan:tempered_glass_block>, <fluidfunnel:funnel>, <extratan:tempered_glass_block>], 
  [<ore:ingotLead>, <ore:gearStone>, <ore:ingotLead>]])
  .addOutput(<intimepresence:pump>)
  .create();

    RecipeBuilder.get("farmer")
  .setShaped([
[null, <redstone_lock:dookie>, null], 
  [<redstone_lock:dookie>, <ore:blockCheese>, <redstone_lock:dookie>], 
  [null, <redstone_lock:dookie>, null]])
  .addOutput(<redstone_lock:cheese>)
  .addTool(<ore:artisansKnife>, 24)
  .create();


  RecipeBuilder.get("farmer")
  .setShaped([
  [<ore:treeLeaves>, <ore:treeLeaves>, <ore:treeLeaves>], 
  [<ore:cropCarrot>, <ore:treeLeaves>, <ore:cropApple>], 
  [<ore:treeLeaves>, <ore:treeLeaves>, <ore:treeLeaves>]])
  .setFluid(<liquid:purified_water> * 100)
  .addOutput(<enderio:item_material:46>)
  .addTool(<ore:artisansKnife>, 2)
  .create();

            RecipeBuilder.get("farmer")
  .setShaped([
  [null, <ore:logWood>, null],
  [<ore:logWood>, <ore:logWood>, <ore:logWood>], 
  [<minecraft:cobblestone>, <minecraft:cobblestone>, <minecraft:cobblestone>]])
  .addOutput(<toughasnails:campfire>)
  .addTool(<ore:artisansKnife>, 8)
  .create();

            RecipeBuilder.get("farmer")
  .setShaped([
 [<ore:treeLeaves>, <ore:treeLeaves>, <ore:treeLeaves>], 
	[<ore:treeLeaves>, <ore:dirt>, <ore:treeLeaves>], 
	[<ore:treeLeaves>, <ore:treeLeaves>, <ore:treeLeaves>]])
	.setFluid(<liquid:purified_water> * 1000)
  .addOutput(<minecraft:grass>)
  .addTool(<ore:artisansKnife>, 8)
  .create();

            RecipeBuilder.get("farmer")
  .setShaped([
[<ore:string>, <ore:string>, null], 
	[<ore:string>, <ore:treeSapling>, null], 
	[null, null, null]])
	.setFluid(<liquid:purified_water> * 1000)
  .addOutput(<harvestcraft:spiderweb_sapling>)
  .addTool(<ore:artisansKnife>, 8)
  .create();

                 RecipeBuilder.get("farmer")
  .setShaped([
[<toughasnails:tan_icon>, <ore:plateAluminum>, <ore:plateAluminum>, <toughasnails:tan_icon>, null], 
	[<ore:plateAluminum>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:plateAluminum>, null], 
	[<ore:plateAluminum>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:plateAluminum>, null], 
	[<toughasnails:tan_icon>, <ore:plateAluminum>, <ore:plateAluminum>, <toughasnails:tan_icon>, null], 
	[null, null, null, null, null]])
  .addOutput(<cookingforblockheads:fridge>)
  .addTool(<ore:artisansKnife>, 18)
  .create();

                  RecipeBuilder.get("farmer")
  .setShaped([
[<ore:plateAluminum>, <ore:barsIron>, <ore:barsIron>, <ore:plateAluminum>, null], 
	[<ore:plateAluminum>, null, null, <ore:plateAluminum>, null], 
	[<ore:plateAluminum>, <minecraft:magma>, <minecraft:magma>, <ore:plateAluminum>, null], 
	[<toughasnails:tan_icon>, <ore:plateAluminum>, <ore:plateAluminum>, <toughasnails:tan_icon>, null], 
	[null, null, null, null, null]])
  .addOutput(<cookingforblockheads:oven>)
  .addTool(<ore:artisansKnife>, 18)
  .create();

                  RecipeBuilder.get("farmer")
  .setShaped([
[<toughasnails:tan_icon>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>, null], 
	[<ore:plankTreatedWood>, <minecraft:wooden_door>, null, <ore:plankTreatedWood>, null], 
	[<ore:plankTreatedWood>, null, <minecraft:wooden_door>, <ore:plankTreatedWood>, null], 
	[<toughasnails:tan_icon>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>, null], 
	[null, null, null, null, null]])
  .addOutput(<cookingforblockheads:cabinet>)
  .addTool(<ore:artisansKnife>, 18)
  .create();

                  RecipeBuilder.get("farmer")
  .setShaped([
[<ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>, null], 
	[<ore:plankTreatedWood>, null, null, <ore:plankTreatedWood>, null], 
	[<ore:plankTreatedWood>, null, null, <ore:plankTreatedWood>, null], 
	[<ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>, null], 
	[null, null, null, null, null]])
  .addOutput(<cookingforblockheads:corner>)
  .addTool(<ore:artisansKnife>, 18)
  .create();

                    RecipeBuilder.get("farmer")
  .setShaped([
[<toughasnails:tan_icon>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>, null], 
	[<ore:plankTreatedWood>, null, null, <ore:plankTreatedWood>, null], 
	[<ore:plankTreatedWood>, <openblocks:tank>, <openblocks:tank>, <ore:plankTreatedWood>, null], 
	[<toughasnails:tan_icon>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>, null], 
	[null, null, null, null, null]])
  .addOutput(<cookingforblockheads:sink>)
  .addTool(<ore:artisansKnife>, 18)
  .create();

                      RecipeBuilder.get("farmer")
  .setShaped([
[<ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>, null], 
	[<ore:plankTreatedWood>, null, null, <ore:plankTreatedWood>, null], 
	[<ore:plankTreatedWood>, <minecraft:chest>,<minecraft:chest>, <ore:plankTreatedWood>, null], 
	[<ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>, null], 
	[null, null, null, null, null]])
  .addOutput(<cookingforblockheads:cooking_table>)
  .addTool(<ore:artisansKnife>, 18)
  .create();

                        RecipeBuilder.get("farmer")
  .setShaped([
 [<glacidus:underground_planks>, <glacidus:underground_planks>, <glacidus:underground_planks>], 
	[<glacidus:underground_planks>, <ore:gearTin>, <glacidus:underground_planks>], 
	[<ore:barsIron>, <ore:barsIron>, <ore:barsIron>]])
  .addOutput(<agricraft:sprinkler>)
  .addTool(<ore:artisansKnife>, 18)
  .create();

	               RecipeBuilder.get("farmer")
  .setShaped([
	[<ore:listAllbeefraw>, <ore:listAllbeefraw>, <ore:listAllbeefraw>], 
	[<ore:listAllbeefraw>, <ore:listAllbeefraw>, <ore:listAllbeefraw>], 
	[<ore:listAllbeefraw>, <ore:listAllbeefraw>, <ore:listAllbeefraw>]])
	  .addOutput(<additionalcompression:meatbeef_compressed>)
  .addTool(<ore:artisansCuttingBoard>, 8)
  .create();


               RecipeBuilder.get("farmer")
  .setShaped([
	[<ore:blockMeatBeef>, <ore:blockMeatBeef>, <ore:blockMeatBeef>], 
	[<ore:blockMeatBeef>, <ore:blockMeatBeef>, <ore:blockMeatBeef>], 
	[<ore:blockMeatBeef>, <ore:blockMeatBeef>, <ore:blockMeatBeef>]])
	  .addOutput(<additionalcompression:meatbeef_compressed:1>)
  .addTool(<ore:artisansCuttingBoard>, 8)
  .create();

	               RecipeBuilder.get("farmer")
  .setShaped([
	[<ore:listAllporkraw>, <ore:listAllporkraw>, <ore:listAllporkraw>], 
	[<ore:listAllporkraw>, <ore:listAllporkraw>, <ore:listAllporkraw>], 
	[<ore:listAllporkraw>, <ore:listAllporkraw>, <ore:listAllporkraw>]])
	  .addOutput(<additionalcompression:meatporkchop_compressed>)
  .addTool(<ore:artisansCuttingBoard>, 8)
  .create();


               RecipeBuilder.get("farmer")
  .setShaped([
	[<ore:blockMeatPorkchop>, <ore:blockMeatPorkchop>, <ore:blockMeatPorkchop>], 
	[<ore:blockMeatPorkchop>, <ore:blockMeatPorkchop>, <ore:blockMeatPorkchop>], 
	[<ore:blockMeatPorkchop>, <ore:blockMeatPorkchop>, <ore:blockMeatPorkchop>]])
	  .addOutput(<additionalcompression:meatporkchop_compressed:1>)
  .addTool(<ore:artisansCuttingBoard>, 8)
  .create();

	               RecipeBuilder.get("farmer")
  .setShaped([
	[<ore:listAllchickenraw>, <ore:listAllchickenraw>, <ore:listAllchickenraw>], 
	[<ore:listAllchickenraw>, <ore:listAllchickenraw>, <ore:listAllchickenraw>], 
	[<ore:listAllchickenraw>, <ore:listAllchickenraw>, <ore:listAllchickenraw>]])
	  .addOutput(<additionalcompression:meatchicken_compressed>)
  .addTool(<ore:artisansCuttingBoard>, 8)
  .create();

               RecipeBuilder.get("farmer")
  .setShaped([
	[<ore:blockMeatChicken>, <ore:blockMeatChicken>, <ore:blockMeatChicken>], 
	[<ore:blockMeatChicken>, <ore:blockMeatChicken>, <ore:blockMeatChicken>], 
	[<ore:blockMeatChicken>, <ore:blockMeatChicken>, <ore:blockMeatChicken>]])
	  .addOutput(<additionalcompression:meatchicken_compressed:1>)
  .addTool(<ore:artisansCuttingBoard>, 8)
  .create();

               RecipeBuilder.get("farmer")
  .setShaped([
	[null, <ore:barsIron>, null], 
	[<ore:barsIron>, <morebuckets:aluminum_bucket>, <ore:barsIron>], 
	[null, <ore:barsIron>, null]])
	  .addOutput(<openblocks:sprinkler>)
  .addTool(<ore:artisansCuttingBoard>, 8)
  .create();

               RecipeBuilder.get("farmer")
  .setShaped([
	[<extratan:tempered_glass_block>, <extratan:tempered_glass_block>, null, null, null], 
	[<extratan:tempered_glass_block>, <extratan:tempered_glass_block>, null, null, null], 
	[null, null, <glacidus:underground_stick>, null, null], 
	[null, null, null, <glacidus:underground_stick>, null], 
	[null, null, null, null, <glacidus:underground_stick>]])
	  .addOutput(<agricraft:magnifying_glass>)
  .addTool(<ore:artisansKnife>, 8)
  .create();

               RecipeBuilder.get("farmer")
  .setShaped([
	[<ore:barsIron>, null, <ore:barsIron>], 
	[null, <morebuckets:aluminum_bucket>, null], 
	[<ore:barsIron>, null, <ore:barsIron>]])
	  .addOutput(<cyclicmagic:sprinkler>)
  .addTool(<ore:artisansKnife>, 8)
  .create();

               RecipeBuilder.get("farmer")
  .setShaped([
	[<ore:plankWood>, <simplyjetpacks:metaitem:4>, <ore:plankWood>], 
	[<simplyjetpacks:metaitem:4>, <ore:plankWood>, <simplyjetpacks:metaitem:4>], 
	[<ore:plankWood>, <simplyjetpacks:metaitem:4>, <ore:plankWood>]])
	  .addOutput(<tinymobfarm:lasso>)
  .addTool(<ore:artisansKnife>, 8)
  .create();

                 RecipeBuilder.get("farmer")
  .setShaped([
  [<ore:dirt>, <ore:glowshroom>, <ore:dirt>], 
  [<ore:glowshroom>, <ore:dirt>, <ore:glowshroom>], 
  [<ore:dirt>, <ore:glowshroom>, <ore:dirt>]])
    .setFluid(<liquid:purified_water> * 100)
    .addOutput(<minecraft:mycelium> * 5)
  .addTool(<ore:artisansKnife>, 8)
  .create();

                 RecipeBuilder.get("farmer")
  .setShaped([
  [<ore:stone>, <ore:stone>, <ore:stone>, <ore:stone>, <ore:stone>], 
  [<ore:plankTreatedWood>, null, null, null, <ore:plankTreatedWood>], 
  [<ore:plankTreatedWood>, null, null, null, <ore:plankTreatedWood>], 
  [<ore:plankTreatedWood>, null, null, null, <ore:plankTreatedWood>], 
  [<ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>]])
    .addOutput(<cookingforblockheads:counter>)
  .addTool(<ore:artisansKnife>, 8)
  .create();


                 RecipeBuilder.get("farmer")
  .setShaped([
  [<ore:blockNetherrack>, <ore:blockNetherrack>, <ore:blockNetherrack>, <ore:blockNetherrack>, <ore:blockNetherrack>], 
  [<ore:blockNetherrack>, null, <ore:glass>, null, <ore:blockNetherrack>], 
  [<ore:blockNetherrack>, <ore:glass>, <minecraft:furnace>, <ore:glass>, <ore:blockNetherrack>], 
  [<ore:blockNetherrack>, null, <ore:glass>, null, <ore:blockNetherrack>], 
  [<ore:blockNetherrack>, <ore:blockNetherrack>, <ore:blockNetherrack>, <ore:blockNetherrack>, <ore:blockNetherrack>]])
  .setFluid(<liquid:lava> * 4000)
    .addOutput(<natura:netherrack_furnace>)
  .addTool(<ore:artisansKnife>, 28)
  .create();


                 RecipeBuilder.get("farmer")
  .setShaped([
  [<glacidus:lumicia_dirt>, <redstone_lock:dookie>, <glacidus:lumicia_dirt>], 
  [<thermalfoundation:fertilizer:1>, <glacidus:lumicia_dirt>, <thermalfoundation:fertilizer:1>], 
  [<glacidus:lumicia_dirt>, <redstone_lock:dookie>, <glacidus:lumicia_dirt>]])
  .setFluid(<liquid:purified_water> * 500)
    .addOutput(<contenttweaker:poop_dirt> * 5)
  .addTool(<ore:artisansKnife>, 28)
  .create();

                   RecipeBuilder.get("farmer")
  .setShaped([
  [<ore:treeLeaves>, <ore:treeLeaves>, <ore:treeLeaves>], 
  [<ore:treeLeaves>, <ore:treeLeaves>, <ore:treeLeaves>], 
  [<ore:treeLeaves>, <ore:treeLeaves>, <ore:treeLeaves>]])
  .setFluid(<liquid:water> * 100)
    .addOutput(<redstone_lock:compressedleaves>)
  .addTool(<ore:artisansKnife>, 28)
  .create();

                     RecipeBuilder.get("farmer")
  .setShaped([
  [<redstone_lock:compressedleaves>, <redstone_lock:compressedleaves>, <redstone_lock:compressedleaves>], 
  [<redstone_lock:compressedleaves>, <redstone_lock:compressedleaves>, <redstone_lock:compressedleaves>], 
  [<redstone_lock:compressedleaves>, <redstone_lock:compressedleaves>, <redstone_lock:compressedleaves>]])
  .setFluid(<liquid:water> * 100)
    .addOutput(<redstone_lock:compressedleaves2>)
  .addTool(<ore:artisansKnife>, 28)
  .create();

                       RecipeBuilder.get("farmer")
  .setShaped([
  [<redstone_lock:compressedleaves2>, <ftrsquids:turbotube>, <redstone_lock:compressedleaves2>], 
  [<ftrsquids:turbotube>, <ore:itemEmptyBottle>, <ftrsquids:turbotube>], 
  [<redstone_lock:compressedleaves2>, <ftrsquids:turbotube>, <redstone_lock:compressedleaves2>]])
  .setFluid(<liquid:purified_water> * 1000)
    .addOutput(<minecraft:potion>.withTag({CustomPotionEffects: [{ShowParticles: 0 as byte, Duration: 6000, Id: 3, Amplifier: 1}, {ShowParticles: 0 as byte, Duration: 6000, Id: 13}, {ShowParticles: 0 as byte, Duration: 6000, Id: 16}], CustomPotionColor: 1937797, display: {Name: "Booly's Brew"}}))
  .addTool(<ore:artisansKnife>, 28)
  .create();

                          RecipeBuilder.get("farmer")
  .setShaped([
  [<ore:slabTreatedWood>, <ore:slabTreatedWood>, <ore:slabTreatedWood>], 
  [<ore:slabTreatedWood>, null, <ore:slabTreatedWood>], 
  [<ore:slabTreatedWood>, <ore:slabTreatedWood>, <ore:slabTreatedWood>]])
    .addOutput(<storagedrawers:trim>)
  .addTool(<ore:artisansKnife>, 8)
  .create();
