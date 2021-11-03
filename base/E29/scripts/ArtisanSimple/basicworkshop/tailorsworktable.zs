#packmode artisansimple
import mods.artisanworktables.builder.RecipeBuilder;

//  Shapeless ======================================================================================================================
RecipeBuilder.get("basic")
  .setShapeless([<minecraft:string>, <minecraft:string>, <minecraft:string>, <minecraft:string>])
  .addOutput(<harvestcraft:wovencottonitem>)
    .create();

RecipeBuilder.get("basic")
  .setShapeless([<thermalexpansion:satchel>, <thermalfoundation:upgrade>])
  .addOutput(<thermalexpansion:satchel:1>)
    .create();

RecipeBuilder.get("basic")
  .setShapeless([<thermalexpansion:satchel>, <thermalfoundation:upgrade:33>])
  .addOutput(<thermalexpansion:satchel:2>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<thermalexpansion:satchel>, <thermalfoundation:upgrade:34>])
  .addOutput(<thermalexpansion:satchel:3>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<thermalexpansion:satchel>, <thermalfoundation:upgrade:35>])
  .addOutput(<thermalexpansion:satchel:4>)
    .create();

    RecipeBuilder.get("basic")
  .setShapeless([<thermalexpansion:satchel>, <cyclicmagic:trash>])
  .addOutput(<thermalexpansion:satchel:100>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<ore:blockWool>, <ore:blockWool>])
  .addOutput(<minecraft:string> * 6)
    .create();

    RecipeBuilder.get("basic")
  .setShapeless([<better_diving:fiber_mesh>, <contenttweaker:sheet_rubber>, <ore:crystalSlag>])
  .addOutput(<embers:ashen_cloth> * 2)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<minecraft:wool>, <magneticraft:crafting:6>])
  .addOutput(<better_diving:fiber_mesh> * 2)
      .create();

RecipeBuilder.get("basic")
  .setShapeless([<harvestcraft:wovencottonitem>, <harvestcraft:wovencottonitem>])
  .addOutput(<minecraft:wool>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<better_diving:creepvine_seed_cluster>, <magneticraft:crafting>])
  .addOutput(<better_diving:fiber_mesh>)
      .create();

    RecipeBuilder.get("basic")
  .setShapeless([<ore:blockWool>, <armorunder:heating_goo>])
  .addOutput(<armorunder:warm_liner_material> * 2)
      .create();

      RecipeBuilder.get("basic")
  .setShapeless([<ore:blockWool>, <armorunder:cooling_goo>])
  .addOutput(<armorunder:cool_liner_material> * 2)
      .create();

//  Shaped ==============================================================================================================================
  RecipeBuilder.get("basic")
  .setShaped([
	[null, null, <minecraft:vine>],
	[null, <minecraft:vine>, null], 
	[<minecraft:vine>, null, null]])
  .addOutput(<minecraft:string> * 3)
    .create();

  RecipeBuilder.get("basic")
  .setShaped([
  [<harvestcraft:wovencottonitem>, <minecraft:string>, <harvestcraft:wovencottonitem>],
  [<minecraft:string>, <minecraft:string>, <minecraft:string>], 
  [<harvestcraft:wovencottonitem>, <minecraft:string>, <harvestcraft:wovencottonitem>]])
  .addOutput(<magneticraft:crafting:6>)
    .create();

    RecipeBuilder.get("basic")
  .setShaped([
  [<minecraft:stick>, <minecraft:string>, <minecraft:stick>],
  [<minecraft:string>, <magneticraft:crafting:6>, <minecraft:string>], 
  [<minecraft:stick>, <minecraft:string>, <minecraft:stick>]])
  .addOutput(<waterstrainer:strainer_survivalist>)
    .create();

    RecipeBuilder.get("basic")
  .setShaped([
  [<minecraft:stick>, <minecraft:string>, <minecraft:stick>],
  [<magneticraft:crafting:6>, <minecraft:string>, <magneticraft:crafting:6>], 
  [<minecraft:stick>, <minecraft:string>, <minecraft:stick>]])
  .addOutput(<waterstrainer:strainer_survivalist_dense>)
    .create();

    RecipeBuilder.get("basic")
  .setShaped([
  [<contenttweaker:sheet_rubber>, <contenttweaker:sheet_rubber>, <contenttweaker:sheet_rubber>], 
  [<contenttweaker:sheet_rubber>, <ore:dyeBlack>, <contenttweaker:sheet_rubber>], 
  [<contenttweaker:sheet_rubber>, null, <contenttweaker:sheet_rubber>]])
  .addOutput(<better_diving:wetsuit_leggings>)
      .create();

      RecipeBuilder.get("basic")
  .setShaped([
  [null, null, null], 
  [<contenttweaker:sheet_rubber>, <ore:dyeBlack>, <contenttweaker:sheet_rubber>], 
  [<contenttweaker:sheet_rubber>, <ore:dyeOrange>, <contenttweaker:sheet_rubber>]])
  .addOutput(<better_diving:fins>)
      .create();

      RecipeBuilder.get("basic")
  .setShaped([
  [<contenttweaker:sheet_rubber>, <contenttweaker:sheet_rubber>, <contenttweaker:sheet_rubber>], 
  [<contenttweaker:sheet_rubber>, <extratan:tempered_glass_block>, <contenttweaker:sheet_rubber>], 
  [<ore:dyeBlack>, <extratan:tempered_glass_block>, <ore:dyeBlack>]])
  .addOutput(<better_diving:diving_mask>)
      .create();

    RecipeBuilder.get("basic")
  .setShaped([
  [<embers:ashen_cloth>, <embers:ashen_cloth>, <embers:ashen_cloth>], 
  [<embers:ashen_cloth>, <better_diving:wetsuit_leggings>.anyDamage(), <embers:ashen_cloth>], 
  [<embers:ashen_cloth>, null, <embers:ashen_cloth>]])
  .addOutput(<better_diving:reinforced_wetsuit_leggings>)
      .create();

      RecipeBuilder.get("basic")
  .setShaped([
  [null, null, null], 
  [<embers:ashen_cloth>, <better_diving:fins>.anyDamage(), <embers:ashen_cloth>], 
  [<embers:ashen_cloth>, null, <embers:ashen_cloth>]])
  .addOutput(<better_diving:reinforced_fins>)
      .create();

      RecipeBuilder.get("basic")
  .setShaped([
 	[<embers:ashen_cloth>, <embers:ashen_cloth>, <embers:ashen_cloth>], 
	[<embers:ashen_cloth>, <extratan:tempered_glass_block>, <embers:ashen_cloth>], 
	[<ore:dyeBlack>, <better_diving:diving_mask>.anyDamage(), <ore:dyeBlack>]])
  .addOutput(<better_diving:reinforced_diving_mask>)
      .create();

  
    RecipeBuilder.get("basic")
  .setShaped([
  [<embers:shifting_scales>, <embers:shifting_scales>, <embers:shifting_scales>], 
  [<embers:shifting_scales>, <better_diving:reinforced_wetsuit_leggings>.anyDamage(), <embers:shifting_scales>], 
  [<embers:shifting_scales>, null, <embers:shifting_scales>]])
  .addOutput(<better_diving:improved_wetsuit_leggings>)
      .create();

      RecipeBuilder.get("basic")
  .setShaped([
  [null, null, null], 
  [<embers:shifting_scales>, <better_diving:reinforced_fins>.anyDamage(), <embers:shifting_scales>], 
  [<embers:shifting_scales>, null, <embers:shifting_scales>]])
  .addOutput(<better_diving:ultra_glide_fins>)
      .create();

      RecipeBuilder.get("basic")
  .setShaped([
  [<embers:shifting_scales>, <embers:shifting_scales>, <embers:shifting_scales>], 
  [<embers:shifting_scales>, <extratan:tempered_glass_block>, <embers:shifting_scales>], 
  [<ore:dyeBlack>, <better_diving:reinforced_diving_mask>.anyDamage(), <ore:dyeBlack>]])
  .addOutput(<better_diving:rebreather>)
      .create();

        RecipeBuilder.get("basic")
  .setShaped([
  [<armorunder:warm_liner_material>, null, <armorunder:warm_liner_material>], 
  [<armorunder:warm_liner_material>, <armorunder:warm_liner_material>, <armorunder:warm_liner_material>], 
  [<armorunder:warm_liner_material>, <armorunder:warm_liner_material>, <armorunder:warm_liner_material>]])
  .addOutput(<armorunder:warm_chestplate_liner>)
      .create();

        RecipeBuilder.get("basic")
  .setShaped([
  [<armorunder:warm_liner_material>, <armorunder:warm_liner_material>, <armorunder:warm_liner_material>], 
  [<armorunder:warm_liner_material>, null, <armorunder:warm_liner_material>], 
  [<armorunder:warm_liner_material>, null, <armorunder:warm_liner_material>]])
  .addOutput(<armorunder:warm_leggings_liner>)
      .create();

        RecipeBuilder.get("basic")
  .setShaped([
   [null, null, null], 
  [<armorunder:warm_liner_material>, null, <armorunder:warm_liner_material>], 
  [<armorunder:warm_liner_material>, null, <armorunder:warm_liner_material>]])
  .addOutput(<armorunder:warm_boots_liner>)
      .create();

        RecipeBuilder.get("basic")
  .setShaped([
  [<armorunder:warm_liner_material>, <armorunder:warm_liner_material>, <armorunder:warm_liner_material>], 
  [<armorunder:warm_liner_material>, null, <armorunder:warm_liner_material>], 
  [null, null, null]])
  .addOutput(<armorunder:warm_helmet_liner>)
      .create();

        RecipeBuilder.get("basic")
  .setShaped([
  [<armorunder:cool_liner_material>, null, <armorunder:cool_liner_material>], 
  [<armorunder:cool_liner_material>, <armorunder:cool_liner_material>, <armorunder:cool_liner_material>], 
  [<armorunder:cool_liner_material>, <armorunder:cool_liner_material>, <armorunder:cool_liner_material>]])
  .addOutput(<armorunder:cool_chestplate_liner>)
      .create();

        RecipeBuilder.get("basic")
  .setShaped([
  [<armorunder:cool_liner_material>, <armorunder:cool_liner_material>, <armorunder:cool_liner_material>], 
  [<armorunder:cool_liner_material>, null, <armorunder:cool_liner_material>], 
  [<armorunder:cool_liner_material>, null, <armorunder:cool_liner_material>]])
  .addOutput(<armorunder:cool_leggings_liner>)
      .create();

        RecipeBuilder.get("basic")
  .setShaped([
   [null, null, null], 
  [<armorunder:cool_liner_material>, null, <armorunder:cool_liner_material>], 
  [<armorunder:cool_liner_material>, null, <armorunder:cool_liner_material>]])
  .addOutput(<armorunder:cool_boots_liner>)
      .create();

        RecipeBuilder.get("basic")
  .setShaped([
  [<armorunder:cool_liner_material>, <armorunder:cool_liner_material>, <armorunder:cool_liner_material>], 
  [<armorunder:cool_liner_material>, null, <armorunder:cool_liner_material>], 
  [null, null, null]])
  .addOutput(<armorunder:cool_helmet_liner>)
      .create();

        RecipeBuilder.get("basic")
  .setShaped([
  [<natura:materials:7>, <ore:leather>, <natura:materials:7>, <ore:leather>, <natura:materials:7>], 
  [<ore:leather>, null, null, null, <ore:leather>], 
  [<natura:materials:7>, null, <ore:chest>, null, <natura:materials:7>], 
  [<ore:leather>, null, null, null, <ore:leather>], 
  [<natura:materials:7>, <ore:leather>, <natura:materials:7>, <ore:leather>, <natura:materials:7>]])
  .addOutput(<thermalexpansion:satchel>.withTag({Accessible: 1 as byte}))
      .create();
