#packmode artisansimple
import mods.artisanworktables.builder.RecipeBuilder;


//  Shapeless =================================================================================================
RecipeBuilder.get("basic")
  .setShapeless([<minecraft:apple>, <ore:treeSapling>])
    .addOutput(<harvestcraft:apple_sapling>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<additionalcompression:meatbeef_compressed>])
    .addOutput(<rats:assorted_vegetables>)
            .create();
      
RecipeBuilder.get("basic")
  .setShapeless([<additionalcompression:meatchicken_compressed>])
    .addOutput(<rats:assorted_vegetables>)
            .create();
      
RecipeBuilder.get("basic")
  .setShapeless([<additionalcompression:leather_compressed>])
    .addOutput(<rats:assorted_vegetables>)
            .create();
      
RecipeBuilder.get("basic")
  .setShapeless([<additionalcompression:meatfish_compressed>])
    .addOutput(<rats:assorted_vegetables>)
            .create();
      
RecipeBuilder.get("basic")
  .setShapeless([<additionalcompression:pearlender_compressed>])
    .addOutput(<rats:assorted_vegetables>)
            .create();
      
RecipeBuilder.get("basic")
  .setShapeless([<additionalcompression:spidereye_compressed>])
    .addOutput(<rats:assorted_vegetables>)
            .create();
      
RecipeBuilder.get("basic")
  .setShapeless([<additionalcompression:meatrotten_compressed>])
    .addOutput(<rats:assorted_vegetables>)
            .create();

  RecipeBuilder.get("basic")
  .setShapeless([  <redstone_lock:compressedleaves>,   <redstone_lock:compressedleaves>,   <redstone_lock:compressedleaves>])
    .addOutput(<minecraft:paper>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<rats:block_of_cheese>])
  .addOutput(<rats:cheese> * 4)
    .create();

    RecipeBuilder.get("basic")
  .setShapeless([<minecraft:clay>])
  .addOutput(<minecraft:clay_ball> * 4)
    .create();


//  Shaped ==================================================================================
  RecipeBuilder.get("basic")
  .setShaped([
	[<minecraft:leaves>, <minecraft:leaves>, null],
	[<minecraft:leaves>, <minecraft:leaves>, null], 
	[<minecraft:leaves>, <minecraft:leaves>, null]])
    .addOutput(<minecraft:vine> * 4)
    .create();

    RecipeBuilder.get("basic")
  .setShaped([
  [<ore:ingotLead>, <extratan:tempered_glass_block>, <ore:ingotLead>], 
  [<extratan:tempered_glass_block>, <fluidfunnel:funnel>, <extratan:tempered_glass_block>], 
  [<ore:ingotLead>, <ore:gearStone>, <ore:ingotLead>]])
  .addOutput(<intimepresence:pump>)
  .create();

    RecipeBuilder.get("basic")
  .setShaped([
[null, <redstone_lock:dookie>, null], 
  [<redstone_lock:dookie>, <ore:blockCheese>, <redstone_lock:dookie>], 
  [null, <redstone_lock:dookie>, null]])
  .addOutput(<redstone_lock:cheese>)
    .create();


  RecipeBuilder.get("basic")
  .setShaped([
  [<ore:treeLeaves>, <ore:treeLeaves>, <ore:treeLeaves>], 
  [<ore:cropCarrot>, <ore:treeLeaves>, <ore:cropApple>], 
  [<ore:treeLeaves>, <ore:treeLeaves>, <ore:treeLeaves>]])
    .addOutput(<enderio:item_material:46>)
    .create();

            RecipeBuilder.get("basic")
  .setShaped([
  [null, <ore:logWood>, null],
  [<ore:logWood>, <ore:logWood>, <ore:logWood>], 
  [<minecraft:cobblestone>, <minecraft:cobblestone>, <minecraft:cobblestone>]])
  .addOutput(<toughasnails:campfire>)
    .create();

            RecipeBuilder.get("basic")
  .setShaped([
 [<ore:treeLeaves>, <ore:treeLeaves>, <ore:treeLeaves>], 
	[<ore:treeLeaves>, <ore:dirt>, <ore:treeLeaves>], 
	[<ore:treeLeaves>, <ore:treeLeaves>, <ore:treeLeaves>]])
	  .addOutput(<minecraft:grass>)
    .create();

            RecipeBuilder.get("basic")
  .setShaped([
[<ore:string>, <ore:string>, null], 
	[<ore:string>, <ore:treeSapling>, null], 
	[null, null, null]])
	  .addOutput(<harvestcraft:spiderweb_sapling>)
    .create();

 
                RecipeBuilder.get("basic")
  .setShaped([
[<toughasnails:tan_icon>, <ore:plateAluminum>, <ore:plateAluminum>, <toughasnails:tan_icon>, null], 
	[<ore:plateAluminum>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:plateAluminum>, null], 
	[<ore:plateAluminum>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:plateAluminum>, null], 
	[<toughasnails:tan_icon>, <ore:plateAluminum>, <ore:plateAluminum>, <toughasnails:tan_icon>, null], 
	[null, null, null, null, null]])
  .addOutput(<cookingforblockheads:fridge>)
    .create();

                  RecipeBuilder.get("basic")
  .setShaped([
[<ore:plateAluminum>, <ore:barsIron>, <ore:barsIron>, <ore:plateAluminum>, null], 
	[<ore:plateAluminum>, null, null, <ore:plateAluminum>, null], 
	[<ore:plateAluminum>, <minecraft:magma>, <minecraft:magma>, <ore:plateAluminum>, null], 
	[<toughasnails:tan_icon>, <ore:plateAluminum>, <ore:plateAluminum>, <toughasnails:tan_icon>, null], 
	[null, null, null, null, null]])
  .addOutput(<cookingforblockheads:oven>)
    .create();

                  RecipeBuilder.get("basic")
  .setShaped([
[<toughasnails:tan_icon>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>, null], 
	[<ore:plankTreatedWood>, <minecraft:wooden_door>, null, <ore:plankTreatedWood>, null], 
	[<ore:plankTreatedWood>, null, <minecraft:wooden_door>, <ore:plankTreatedWood>, null], 
	[<toughasnails:tan_icon>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>, null], 
	[null, null, null, null, null]])
  .addOutput(<cookingforblockheads:cabinet>)
    .create();

                  RecipeBuilder.get("basic")
  .setShaped([
[<ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>, null], 
	[<ore:plankTreatedWood>, null, null, <ore:plankTreatedWood>, null], 
	[<ore:plankTreatedWood>, null, null, <ore:plankTreatedWood>, null], 
	[<ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>, null], 
	[null, null, null, null, null]])
  .addOutput(<cookingforblockheads:corner>)
    .create();

                    RecipeBuilder.get("basic")
  .setShaped([
[<toughasnails:tan_icon>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>, null], 
	[<ore:plankTreatedWood>, null, null, <ore:plankTreatedWood>, null], 
	[<ore:plankTreatedWood>, <openblocks:tank>, <openblocks:tank>, <ore:plankTreatedWood>, null], 
	[<toughasnails:tan_icon>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>, null], 
	[null, null, null, null, null]])
  .addOutput(<cookingforblockheads:sink>)
    .create();

                      RecipeBuilder.get("basic")
  .setShaped([
[<ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>, null], 
	[<ore:plankTreatedWood>, null, null, <ore:plankTreatedWood>, null], 
	[<ore:plankTreatedWood>, <minecraft:chest>,<minecraft:chest>, <ore:plankTreatedWood>, null], 
	[<ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>, null], 
	[null, null, null, null, null]])
  .addOutput(<cookingforblockheads:cooking_table>)
    .create();

                        RecipeBuilder.get("basic")
  .setShaped([
 [<glacidus:underground_planks>, <glacidus:underground_planks>, <glacidus:underground_planks>], 
	[<glacidus:underground_planks>, <ore:gearTin>, <glacidus:underground_planks>], 
	[<ore:barsIron>, <ore:barsIron>, <ore:barsIron>]])
  .addOutput(<agricraft:sprinkler>)
    .create();

	               RecipeBuilder.get("basic")
  .setShaped([
	[<ore:listAllbeefraw>, <ore:listAllbeefraw>, <ore:listAllbeefraw>], 
	[<ore:listAllbeefraw>, <ore:listAllbeefraw>, <ore:listAllbeefraw>], 
	[<ore:listAllbeefraw>, <ore:listAllbeefraw>, <ore:listAllbeefraw>]])
	  .addOutput(<additionalcompression:meatbeef_compressed>)
    .create();


               RecipeBuilder.get("basic")
  .setShaped([
	[<ore:blockMeatBeef>, <ore:blockMeatBeef>, <ore:blockMeatBeef>], 
	[<ore:blockMeatBeef>, <ore:blockMeatBeef>, <ore:blockMeatBeef>], 
	[<ore:blockMeatBeef>, <ore:blockMeatBeef>, <ore:blockMeatBeef>]])
	  .addOutput(<additionalcompression:meatbeef_compressed:1>)
    .create();

	               RecipeBuilder.get("basic")
  .setShaped([
	[<ore:listAllporkraw>, <ore:listAllporkraw>, <ore:listAllporkraw>], 
	[<ore:listAllporkraw>, <ore:listAllporkraw>, <ore:listAllporkraw>], 
	[<ore:listAllporkraw>, <ore:listAllporkraw>, <ore:listAllporkraw>]])
	  .addOutput(<additionalcompression:meatporkchop_compressed>)
    .create();


               RecipeBuilder.get("basic")
  .setShaped([
	[<ore:blockMeatPorkchop>, <ore:blockMeatPorkchop>, <ore:blockMeatPorkchop>], 
	[<ore:blockMeatPorkchop>, <ore:blockMeatPorkchop>, <ore:blockMeatPorkchop>], 
	[<ore:blockMeatPorkchop>, <ore:blockMeatPorkchop>, <ore:blockMeatPorkchop>]])
	  .addOutput(<additionalcompression:meatporkchop_compressed:1>)
    .create();

	               RecipeBuilder.get("basic")
  .setShaped([
	[<ore:listAllchickenraw>, <ore:listAllchickenraw>, <ore:listAllchickenraw>], 
	[<ore:listAllchickenraw>, <ore:listAllchickenraw>, <ore:listAllchickenraw>], 
	[<ore:listAllchickenraw>, <ore:listAllchickenraw>, <ore:listAllchickenraw>]])
	  .addOutput(<additionalcompression:meatchicken_compressed>)
    .create();

               RecipeBuilder.get("basic")
  .setShaped([
	[<ore:blockMeatChicken>, <ore:blockMeatChicken>, <ore:blockMeatChicken>], 
	[<ore:blockMeatChicken>, <ore:blockMeatChicken>, <ore:blockMeatChicken>], 
	[<ore:blockMeatChicken>, <ore:blockMeatChicken>, <ore:blockMeatChicken>]])
	  .addOutput(<additionalcompression:meatchicken_compressed:1>)
    .create();

               RecipeBuilder.get("basic")
  .setShaped([
	[null, <ore:barsIron>, null], 
	[<ore:barsIron>, <morebuckets:aluminum_bucket>, <ore:barsIron>], 
	[null, <ore:barsIron>, null]])
	  .addOutput(<openblocks:sprinkler>)
    .create();

               RecipeBuilder.get("basic")
  .setShaped([
	[<extratan:tempered_glass_block>, <extratan:tempered_glass_block>, null, null, null], 
	[<extratan:tempered_glass_block>, <extratan:tempered_glass_block>, null, null, null], 
	[null, null, <glacidus:underground_stick>, null, null], 
	[null, null, null, <glacidus:underground_stick>, null], 
	[null, null, null, null, <glacidus:underground_stick>]])
	  .addOutput(<agricraft:magnifying_glass>)
    .create();

               RecipeBuilder.get("basic")
  .setShaped([
	[<ore:barsIron>, null, <ore:barsIron>], 
	[null, <morebuckets:aluminum_bucket>, null], 
	[<ore:barsIron>, null, <ore:barsIron>]])
	  .addOutput(<cyclicmagic:sprinkler>)
    .create();

               RecipeBuilder.get("basic")
  .setShaped([
	[<ore:plankWood>, <simplyjetpacks:metaitem:4>, <ore:plankWood>], 
	[<simplyjetpacks:metaitem:4>, <ore:plankWood>, <simplyjetpacks:metaitem:4>], 
	[<ore:plankWood>, <simplyjetpacks:metaitem:4>, <ore:plankWood>]])
	  .addOutput(<tinymobfarm:lasso>)
    .create();

                 RecipeBuilder.get("basic")
  .setShaped([
  [<ore:dirt>, <ore:glowshroom>, <ore:dirt>], 
  [<ore:glowshroom>, <ore:dirt>, <ore:glowshroom>], 
  [<ore:dirt>, <ore:glowshroom>, <ore:dirt>]])
        .addOutput(<minecraft:mycelium> * 5)
    .create();

                 RecipeBuilder.get("basic")
  .setShaped([
  [<ore:stone>, <ore:stone>, <ore:stone>, <ore:stone>, <ore:stone>], 
  [<ore:plankTreatedWood>, null, null, null, <ore:plankTreatedWood>], 
  [<ore:plankTreatedWood>, null, null, null, <ore:plankTreatedWood>], 
  [<ore:plankTreatedWood>, null, null, null, <ore:plankTreatedWood>], 
  [<ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>]])
    .addOutput(<cookingforblockheads:counter>)
    .create();


                 RecipeBuilder.get("basic")
  .setShaped([
  [<ore:blockNetherrack>, <ore:blockNetherrack>, <ore:blockNetherrack>, <ore:blockNetherrack>, <ore:blockNetherrack>], 
  [<ore:blockNetherrack>, null, <ore:glass>, null, <ore:blockNetherrack>], 
  [<ore:blockNetherrack>, <ore:glass>, <minecraft:furnace>, <ore:glass>, <ore:blockNetherrack>], 
  [<ore:blockNetherrack>, null, <ore:glass>, null, <ore:blockNetherrack>], 
  [<ore:blockNetherrack>, <ore:blockNetherrack>, <ore:blockNetherrack>, <ore:blockNetherrack>, <ore:blockNetherrack>]])
      .addOutput(<natura:netherrack_furnace>)
    .create();


                 RecipeBuilder.get("basic")
  .setShaped([
  [<glacidus:lumicia_dirt>, <redstone_lock:dookie>, <glacidus:lumicia_dirt>], 
  [<thermalfoundation:fertilizer:1>, <glacidus:lumicia_dirt>, <thermalfoundation:fertilizer:1>], 
  [<glacidus:lumicia_dirt>, <redstone_lock:dookie>, <glacidus:lumicia_dirt>]])
      .addOutput(<contenttweaker:poop_dirt> * 5)
    .create();

                   RecipeBuilder.get("basic")
  .setShaped([
  [<ore:treeLeaves>, <ore:treeLeaves>, <ore:treeLeaves>], 
  [<ore:treeLeaves>, <ore:treeLeaves>, <ore:treeLeaves>], 
  [<ore:treeLeaves>, <ore:treeLeaves>, <ore:treeLeaves>]])
      .addOutput(<redstone_lock:compressedleaves>)
    .create();

                     RecipeBuilder.get("basic")
  .setShaped([
  [<redstone_lock:compressedleaves>, <redstone_lock:compressedleaves>, <redstone_lock:compressedleaves>], 
  [<redstone_lock:compressedleaves>, <redstone_lock:compressedleaves>, <redstone_lock:compressedleaves>], 
  [<redstone_lock:compressedleaves>, <redstone_lock:compressedleaves>, <redstone_lock:compressedleaves>]])
      .addOutput(<redstone_lock:compressedleaves2>)
    .create();

                       RecipeBuilder.get("basic")
  .setShaped([
  [<redstone_lock:compressedleaves2>, <ftrsquids:turbotube>, <redstone_lock:compressedleaves2>], 
  [<ftrsquids:turbotube>, <ore:itemEmptyBottle>, <ftrsquids:turbotube>], 
  [<redstone_lock:compressedleaves2>, <ftrsquids:turbotube>, <redstone_lock:compressedleaves2>]])
      .addOutput(<minecraft:potion>.withTag({CustomPotionEffects: [{ShowParticles: 0 as byte, Duration: 6000, Id: 3, Amplifier: 1}, {ShowParticles: 0 as byte, Duration: 6000, Id: 13}, {ShowParticles: 0 as byte, Duration: 6000, Id: 16}], CustomPotionColor: 1937797, display: {Name: "Booly's Brew"}}))
    .create();

                         RecipeBuilder.get("basic")
  .setShaped([
  [<ore:slabTreatedWood>, <ore:slabTreatedWood>, <ore:slabTreatedWood>], 
  [<ore:slabTreatedWood>, null, <ore:slabTreatedWood>], 
  [<ore:slabTreatedWood>, <ore:slabTreatedWood>, <ore:slabTreatedWood>]])
    .addOutput(<storagedrawers:trim>)
    .create();
