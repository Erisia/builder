#packmode artisannormal
import mods.artisanworktables.builder.RecipeBuilder;

//  Shapeless ======================================================================================================================
RecipeBuilder.get("tailor")
  .setShapeless([<minecraft:string>, <minecraft:string>, <minecraft:string>, <minecraft:string>])
  .addOutput(<harvestcraft:wovencottonitem>)
  .addTool(<ore:artisansNeedle>, 6)
  .create();

RecipeBuilder.get("tailor")
  .setShapeless([<thermalexpansion:satchel>, <thermalfoundation:upgrade>])
  .addOutput(<thermalexpansion:satchel:1>)
  .addTool(<ore:artisansNeedle>, 24)
  .create();

RecipeBuilder.get("tailor")
  .setShapeless([<thermalexpansion:satchel>, <thermalfoundation:upgrade:33>])
  .addOutput(<thermalexpansion:satchel:2>)
  .addTool(<ore:artisansNeedle>, 24)
  .create();

  RecipeBuilder.get("tailor")
  .setShapeless([<thermalexpansion:satchel>, <thermalfoundation:upgrade:34>])
  .addOutput(<thermalexpansion:satchel:3>)
  .addTool(<ore:artisansNeedle>, 24)
  .create();

  RecipeBuilder.get("tailor")
  .setShapeless([<thermalexpansion:satchel>, <thermalfoundation:upgrade:35>])
  .addOutput(<thermalexpansion:satchel:4>)
  .addTool(<ore:artisansNeedle>, 24)
  .create();

    RecipeBuilder.get("tailor")
  .setShapeless([<thermalexpansion:satchel>, <cyclicmagic:trash>])
  .addOutput(<thermalexpansion:satchel:100>)
  .addTool(<ore:artisansNeedle>, 24)
  .create();

  RecipeBuilder.get("tailor")
  .setShapeless([<ore:blockWool>, <ore:blockWool>])
  .addOutput(<minecraft:string> * 6)
  .addTool(<ore:artisansRazor>, 4)
  .create();

    RecipeBuilder.get("tailor")
  .setShapeless([<better_diving:fiber_mesh>, <contenttweaker:sheet_rubber>, <ore:crystalSlag>])
  .addOutput(<embers:ashen_cloth> * 2)
  .addTool(<ore:artisansRazor>, 5)
  .create();

  RecipeBuilder.get("tailor")
  .setShapeless([<minecraft:wool>, <magneticraft:crafting:6>])
  .addOutput(<better_diving:fiber_mesh> * 2)
  .addTool(<ore:artisansNeedle>, 6)
  .addTool(<ore:artisansRazor>, 6)
  .create();

RecipeBuilder.get("tailor")
  .setShapeless([<harvestcraft:wovencottonitem>, <harvestcraft:wovencottonitem>])
  .addOutput(<minecraft:wool>)
  .addTool(<ore:artisansNeedle>, 8)
  .create();

  RecipeBuilder.get("tailor")
  .setShapeless([<minecraft:wool>])
  .addOutput(<harvestcraft:wovencottonitem> * 2)
  .addTool(<ore:artisansNeedle>, 12)
  .create();

  RecipeBuilder.get("tailor")
  .setShapeless([<better_diving:creepvine_seed_cluster>, <magneticraft:crafting>])
  .addOutput(<better_diving:fiber_mesh>)
  .addTool(<ore:artisansNeedle>, 8)
  .addTool(<ore:artisansRazor>, 8)
  .create();

    RecipeBuilder.get("tailor")
  .setShapeless([<ore:blockWool>, <armorunder:heating_goo>])
  .addOutput(<armorunder:warm_liner_material> * 2)
  .addTool(<ore:artisansNeedle>, 12)
  .addTool(<ore:artisansRazor>, 8)
  .create();

      RecipeBuilder.get("tailor")
  .setShapeless([<ore:blockWool>, <armorunder:cooling_goo>])
  .addOutput(<armorunder:cool_liner_material> * 2)
  .addTool(<ore:artisansNeedle>, 12)
  .addTool(<ore:artisansRazor>, 8)
  .create();

//  Shaped ==============================================================================================================================
  RecipeBuilder.get("tailor")
  .setShaped([
	[null, null, <minecraft:vine>],
	[null, <minecraft:vine>, null], 
	[<minecraft:vine>, null, null]])
  .addOutput(<minecraft:string> * 3)
  .addTool(<ore:artisansNeedle>, 4)
  .create();

  RecipeBuilder.get("tailor")
  .setShaped([
  [<harvestcraft:wovencottonitem>, <minecraft:string>, <harvestcraft:wovencottonitem>],
  [<minecraft:string>, <minecraft:string>, <minecraft:string>], 
  [<harvestcraft:wovencottonitem>, <minecraft:string>, <harvestcraft:wovencottonitem>]])
  .addOutput(<magneticraft:crafting:6>)
  .addTool(<ore:artisansNeedle>, 8)
  .create();

    RecipeBuilder.get("tailor")
  .setShaped([
  [<minecraft:stick>, <minecraft:string>, <minecraft:stick>],
  [<minecraft:string>, <magneticraft:crafting:6>, <minecraft:string>], 
  [<minecraft:stick>, <minecraft:string>, <minecraft:stick>]])
  .addOutput(<waterstrainer:strainer_survivalist>)
  .addTool(<ore:artisansNeedle>, 12)
  .create();

    RecipeBuilder.get("tailor")
  .setShaped([
  [<minecraft:stick>, <minecraft:string>, <minecraft:stick>],
  [<magneticraft:crafting:6>, <minecraft:string>, <magneticraft:crafting:6>], 
  [<minecraft:stick>, <minecraft:string>, <minecraft:stick>]])
  .addOutput(<waterstrainer:strainer_survivalist_dense>)
  .addTool(<ore:artisansNeedle>, 24)
  .create();

    RecipeBuilder.get("tailor")
  .setShaped([
  [<contenttweaker:sheet_rubber>, <contenttweaker:sheet_rubber>, <contenttweaker:sheet_rubber>], 
  [<contenttweaker:sheet_rubber>, <ore:dyeBlack>, <contenttweaker:sheet_rubber>], 
  [<contenttweaker:sheet_rubber>, null, <contenttweaker:sheet_rubber>]])
  .addOutput(<better_diving:wetsuit_leggings>)
  .addTool(<ore:artisansNeedle>, 12)
  .addTool(<ore:artisansRazor>, 12)
  .create();

      RecipeBuilder.get("tailor")
  .setShaped([
  [null, null, null], 
  [<contenttweaker:sheet_rubber>, <ore:dyeBlack>, <contenttweaker:sheet_rubber>], 
  [<contenttweaker:sheet_rubber>, <ore:dyeOrange>, <contenttweaker:sheet_rubber>]])
  .addOutput(<better_diving:fins>)
  .addTool(<ore:artisansNeedle>, 12)
  .addTool(<ore:artisansRazor>, 12)
  .create();

      RecipeBuilder.get("tailor")
  .setShaped([
  [<contenttweaker:sheet_rubber>, <contenttweaker:sheet_rubber>, <contenttweaker:sheet_rubber>], 
  [<contenttweaker:sheet_rubber>, <extratan:tempered_glass_block>, <contenttweaker:sheet_rubber>], 
  [<ore:dyeBlack>, <extratan:tempered_glass_block>, <ore:dyeBlack>]])
  .addOutput(<better_diving:diving_mask>)
  .addTool(<ore:artisansNeedle>, 12)
  .addTool(<ore:artisansRazor>, 12)
  .create();

    RecipeBuilder.get("tailor")
  .setShaped([
  [<embers:ashen_cloth>, <embers:ashen_cloth>, <embers:ashen_cloth>], 
  [<embers:ashen_cloth>, <better_diving:wetsuit_leggings>.anyDamage(), <embers:ashen_cloth>], 
  [<embers:ashen_cloth>, null, <embers:ashen_cloth>]])
  .addOutput(<better_diving:reinforced_wetsuit_leggings>)
  .addTool(<ore:artisansNeedle>, 12)
  .addTool(<ore:artisansRazor>, 12)
  .create();

      RecipeBuilder.get("tailor")
  .setShaped([
  [null, null, null], 
  [<embers:ashen_cloth>, <better_diving:fins>.anyDamage(), <embers:ashen_cloth>], 
  [<embers:ashen_cloth>, null, <embers:ashen_cloth>]])
  .addOutput(<better_diving:reinforced_fins>)
  .addTool(<ore:artisansNeedle>, 12)
  .addTool(<ore:artisansRazor>, 12)
  .create();

      RecipeBuilder.get("tailor")
  .setShaped([
 	[<embers:ashen_cloth>, <embers:ashen_cloth>, <embers:ashen_cloth>], 
	[<embers:ashen_cloth>, <extratan:tempered_glass_block>, <embers:ashen_cloth>], 
	[<ore:dyeBlack>, <better_diving:diving_mask>.anyDamage(), <ore:dyeBlack>]])
  .addOutput(<better_diving:reinforced_diving_mask>)
  .addTool(<ore:artisansNeedle>, 12)
  .addTool(<ore:artisansRazor>, 12)
  .create();

  
    RecipeBuilder.get("tailor")
  .setShaped([
  [<embers:shifting_scales>, <embers:shifting_scales>, <embers:shifting_scales>], 
  [<embers:shifting_scales>, <better_diving:reinforced_wetsuit_leggings>.anyDamage(), <embers:shifting_scales>], 
  [<embers:shifting_scales>, null, <embers:shifting_scales>]])
  .addOutput(<better_diving:improved_wetsuit_leggings>)
  .addTool(<ore:artisansNeedle>, 48)
  .addTool(<ore:artisansRazor>, 48)
  .create();

      RecipeBuilder.get("tailor")
  .setShaped([
  [null, null, null], 
  [<embers:shifting_scales>, <better_diving:reinforced_fins>.anyDamage(), <embers:shifting_scales>], 
  [<embers:shifting_scales>, null, <embers:shifting_scales>]])
  .addOutput(<better_diving:ultra_glide_fins>)
  .addTool(<ore:artisansNeedle>, 48)
  .addTool(<ore:artisansRazor>, 48)
  .create();

      RecipeBuilder.get("tailor")
  .setShaped([
  [<embers:shifting_scales>, <embers:shifting_scales>, <embers:shifting_scales>], 
  [<embers:shifting_scales>, <extratan:tempered_glass_block>, <embers:shifting_scales>], 
  [<ore:dyeBlack>, <better_diving:reinforced_diving_mask>.anyDamage(), <ore:dyeBlack>]])
  .addOutput(<better_diving:rebreather>)
  .addTool(<ore:artisansNeedle>, 48)
  .addTool(<ore:artisansRazor>, 48)
  .create();

        RecipeBuilder.get("tailor")
  .setShaped([
  [<armorunder:warm_liner_material>, null, <armorunder:warm_liner_material>], 
  [<armorunder:warm_liner_material>, <armorunder:warm_liner_material>, <armorunder:warm_liner_material>], 
  [<armorunder:warm_liner_material>, <armorunder:warm_liner_material>, <armorunder:warm_liner_material>]])
  .addOutput(<armorunder:warm_chestplate_liner>)
  .addTool(<ore:artisansNeedle>, 48)
  .addTool(<ore:artisansRazor>, 48)
  .create();

        RecipeBuilder.get("tailor")
  .setShaped([
  [<armorunder:warm_liner_material>, <armorunder:warm_liner_material>, <armorunder:warm_liner_material>], 
  [<armorunder:warm_liner_material>, null, <armorunder:warm_liner_material>], 
  [<armorunder:warm_liner_material>, null, <armorunder:warm_liner_material>]])
  .addOutput(<armorunder:warm_leggings_liner>)
  .addTool(<ore:artisansNeedle>, 48)
  .addTool(<ore:artisansRazor>, 48)
  .create();

        RecipeBuilder.get("tailor")
  .setShaped([
   [null, null, null], 
  [<armorunder:warm_liner_material>, null, <armorunder:warm_liner_material>], 
  [<armorunder:warm_liner_material>, null, <armorunder:warm_liner_material>]])
  .addOutput(<armorunder:warm_boots_liner>)
  .addTool(<ore:artisansNeedle>, 48)
  .addTool(<ore:artisansRazor>, 48)
  .create();

        RecipeBuilder.get("tailor")
  .setShaped([
  [<armorunder:warm_liner_material>, <armorunder:warm_liner_material>, <armorunder:warm_liner_material>], 
  [<armorunder:warm_liner_material>, null, <armorunder:warm_liner_material>], 
  [null, null, null]])
  .addOutput(<armorunder:warm_helmet_liner>)
  .addTool(<ore:artisansNeedle>, 48)
  .addTool(<ore:artisansRazor>, 48)
  .create();

        RecipeBuilder.get("tailor")
  .setShaped([
  [<armorunder:cool_liner_material>, null, <armorunder:cool_liner_material>], 
  [<armorunder:cool_liner_material>, <armorunder:cool_liner_material>, <armorunder:cool_liner_material>], 
  [<armorunder:cool_liner_material>, <armorunder:cool_liner_material>, <armorunder:cool_liner_material>]])
  .addOutput(<armorunder:cool_chestplate_liner>)
  .addTool(<ore:artisansNeedle>, 48)
  .addTool(<ore:artisansRazor>, 48)
  .create();

        RecipeBuilder.get("tailor")
  .setShaped([
  [<armorunder:cool_liner_material>, <armorunder:cool_liner_material>, <armorunder:cool_liner_material>], 
  [<armorunder:cool_liner_material>, null, <armorunder:cool_liner_material>], 
  [<armorunder:cool_liner_material>, null, <armorunder:cool_liner_material>]])
  .addOutput(<armorunder:cool_leggings_liner>)
  .addTool(<ore:artisansNeedle>, 48)
  .addTool(<ore:artisansRazor>, 48)
  .create();

        RecipeBuilder.get("tailor")
  .setShaped([
   [null, null, null], 
  [<armorunder:cool_liner_material>, null, <armorunder:cool_liner_material>], 
  [<armorunder:cool_liner_material>, null, <armorunder:cool_liner_material>]])
  .addOutput(<armorunder:cool_boots_liner>)
  .addTool(<ore:artisansNeedle>, 48)
  .addTool(<ore:artisansRazor>, 48)
  .create();

        RecipeBuilder.get("tailor")
  .setShaped([
  [<armorunder:cool_liner_material>, <armorunder:cool_liner_material>, <armorunder:cool_liner_material>], 
  [<armorunder:cool_liner_material>, null, <armorunder:cool_liner_material>], 
  [null, null, null]])
  .addOutput(<armorunder:cool_helmet_liner>)
  .addTool(<ore:artisansNeedle>, 48)
  .addTool(<ore:artisansRazor>, 48)
  .create();

        RecipeBuilder.get("tailor")
  .setShaped([
  [<natura:materials:7>, <ore:leather>, <natura:materials:7>, <ore:leather>, <natura:materials:7>], 
  [<ore:leather>, null, null, null, <ore:leather>], 
  [<natura:materials:7>, null, <ore:chest>, null, <natura:materials:7>], 
  [<ore:leather>, null, null, null, <ore:leather>], 
  [<natura:materials:7>, <ore:leather>, <natura:materials:7>, <ore:leather>, <natura:materials:7>]])
  .addOutput(<thermalexpansion:satchel>.withTag({Accessible: 1 as byte}))
  .addTool(<ore:artisansNeedle>, 48)
  .addTool(<ore:artisansRazor>, 48)
  .create();
