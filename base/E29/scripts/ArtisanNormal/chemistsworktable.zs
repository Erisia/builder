#packmode artisannormal
import mods.artisanworktables.builder.RecipeBuilder;

//  Shapeless ======================================================================================================================
RecipeBuilder.get("chemist")
  .setShapeless([<minecraft:slime_ball>, <minecraft:slime_ball>, <toughasnails:magma_shard>])
  .addOutput(<armorunder:heating_goo> * 2)
  .addTool(<ore:artisansBeaker>, 4)
  .addTool(<ore:artisansBurner>, 4)
  .create();

  RecipeBuilder.get("chemist")
  .setShapeless([<minecraft:gunpowder>, <ftrsquids:turbotube>])
  .addOutput(<cyclicmagic:ender_tnt_2>)
  .addTool(<ore:artisansBeaker>, 4)
  .addTool(<ore:artisansBurner>, 4)
  .create();

  RecipeBuilder.get("chemist")
  .setShapeless([<minecraft:dye:15>, <minecraft:coal:1>])
  .addOutput(<minecraft:gunpowder>)
  .addTool(<ore:artisansBeaker>, 4)
  .addTool(<ore:artisansBurner>, 4)
  .create();


  RecipeBuilder.get("chemist")
  .setShapeless([<minecraft:sand>, <ore:gemLapis>, <minecraft:clay_ball>])
  .addOutput(<buildinggadgets:constructionblockpowder>)
  .addTool(<ore:artisansBeaker>, 4)
  .addTool(<ore:artisansBurner>, 4)
  .create();

  RecipeBuilder.get("chemist")
  .setShapeless([<thermalfoundation:fertilizer:2>, <minecraft:dye:4>])
  .addOutput(<enderio:item_material:38>)
  .addTool(<ore:artisansBeaker>, 16)
  .addTool(<ore:artisansBurner>, 16)
  .create();

  RecipeBuilder.get("chemist")
  .setShapeless([<minecraft:clay>])
  .addOutput(<thermalfoundation:material:832> * 4)
   .setFluid(<liquid:sap> * 500)
  .addTool(<ore:artisansBeaker>, 4)
  .addTool(<ore:artisansBurner>, 4)
  .create();

  RecipeBuilder.get("chemist")
  .setShapeless([<ore:dustIron>, <ore:dustIron>, <enderio:item_material:20>])
  .addOutput(<contenttweaker:infinity_dust> * 2)
  .addTool(<ore:artisansBeaker>, 8)
  .addTool(<ore:artisansBurner>, 8)
  .create();

  RecipeBuilder.get("chemist")
  .setShapeless([<minecraft:sand>, <thermalfoundation:material:769>, <thermalfoundation:material:832>])
  .addOutput(<contenttweaker:sheet_rubber> * 2)
  .addTool(<ore:artisansBeaker>, 4)
  .addTool(<ore:artisansBurner>, 4)
  .create();

  RecipeBuilder.get("chemist")
  .setShapeless([<ore:dustLead>, <ore:dustLead>, <ore:dustTin>])
  .addOutput(<contenttweaker:dust_solder> * 2)
  .addTool(<ore:artisansBeaker>, 4)  
  .create();

  RecipeBuilder.get("chemist")
  .setShapeless([<ore:dustTin>, <ore:dustSilver>, <ore:dustGlowstone>])
  .addOutput(<thermalfoundation:material:102> * 2)
  .addTool(<ore:artisansBeaker>, 4)
  .create();

    RecipeBuilder.get("chemist")
  .setShapeless([<ore:dustSilver>, <ore:dustGold>])
  .addOutput(<thermalfoundation:material:97> * 2)
  .addTool(<ore:artisansBeaker>, 4)
  .create();

    RecipeBuilder.get("chemist")
  .setShapeless([<ore:dustIron>, <ore:dustIron>, <ore:dustNickel>])
  .addOutput(<thermalfoundation:material:98> * 2)
  .addTool(<ore:artisansBeaker>, 4)
  .create();

    RecipeBuilder.get("chemist")
  .setShapeless([<ore:dustCopper>, <ore:dustCopper>, <ore:dustTin>])
  .addOutput(<thermalfoundation:material:99> * 2)
  .addTool(<ore:artisansBeaker>, 4)
  .create();

    RecipeBuilder.get("chemist")
  .setShapeless([<ore:dustNickel>, <ore:dustNickel>, <ore:dustCopper>])
  .addOutput(<thermalfoundation:material:100> * 2)
  .addTool(<ore:artisansBeaker>, 4)
  .create();

    RecipeBuilder.get("chemist")
  .setShapeless([<ore:dustCopper>, <ore:dustSilver>, <ore:dustRedstone>])
  .addOutput(<thermalfoundation:material:101> * 2)
  .addTool(<ore:artisansBeaker>, 4)
  .create();

      RecipeBuilder.get("chemist")
  .setShapeless([<ore:dustLead>, <ore:dustPlatinum>, <minecraft:ender_pearl>])
  .addOutput(<thermalfoundation:material:103> * 2)
  .addTool(<ore:artisansBeaker>, 4)
  .create();

  RecipeBuilder.get("chemist")
  .setShapeless([<minecraft:prismarine>])
  .addOutput(<minecraft:prismarine_shard> * 2)
  .addTool(<ore:artisansBeaker>, 4)
  .create();

  RecipeBuilder.get("chemist")
  .setShapeless([<minecraft:prismarine_shard>, <minecraft:ice>])
  .addOutput(<minecraft:prismarine_crystals>)
  .setFluid(<liquid:purified_water> * 500)
  .addTool(<ore:artisansBeaker>, 4)
  .create();

  RecipeBuilder.get("chemist")
  .setShapeless([<minecraft:prismarine_crystals>, <jetorches:material:2>])
  .addOutput(<jetorches:torch:2> * 4)
  .addTool(<ore:artisansBeaker>, 4)
  .addTool(<ore:artisansBurner>, 4)
  .create();

RecipeBuilder.get("chemist")
  .setShapeless([<minecraft:slime_ball>, <minecraft:slime_ball>, <minecraft:packed_ice>])
  .addOutput(<armorunder:cooling_goo> * 2)
  .addTool(<ore:artisansBeaker>, 4)
  .addTool(<ore:artisansBurner>, 4)
  .create();

  RecipeBuilder.get("chemist")
  .setShapeless([<minecraft:clay_ball>, <ore:sand>])
  .setFluid(<liquid:purified_water> * 50)
  .addOutput(<embers:blend_caminite> * 2)
  .addTool(<ore:artisansBeaker>, 2)
  .addTool(<ore:artisansBurner>, 2)
  .create();

    RecipeBuilder.get("chemist")
  .setShapeless([<minecraft:dye:15>, <embers:blend_caminite>])
  .setFluid(<liquid:purified_water> * 50)
  .addOutput(<embers:adhesive> * 2)
  .addTool(<ore:artisansBeaker>, 2)
  .addTool(<ore:artisansBurner>, 2)
  .create();

      RecipeBuilder.get("chemist")
  .setShapeless([<minecraft:dye:15>, <rats:raw_plastic>])
  .setFluid(<liquid:purified_water> * 50)
  .addOutput(<embers:adhesive> * 2)
  .addTool(<ore:artisansBeaker>, 2)
  .addTool(<ore:artisansBurner>, 2)
  .create();

    RecipeBuilder.get("chemist")
  .setShapeless([<immersiveengineering:material:7>, <immersiveengineering:material:7>, <better_diving:fiber_mesh>])
  .setFluid(<liquid:purified_water> * 1000)
  .addOutput(<embers:adhesive>)
  .addTool(<ore:artisansBeaker>, 24)
  .addTool(<ore:artisansBurner>, 24)
  .create();


//  Shaped ==============================================================================================================================
  RecipeBuilder.get("chemist")
  .setShaped([
  [<coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>], 
  [<coralreef:reef:1>, <harvestcraft:wovencottonitem>, <coralreef:reef:1>, <harvestcraft:wovencottonitem>, <coralreef:reef:1>], 
  [<coralreef:reef:1>, <coralreef:reef:1>, <harvestcraft:wovencottonitem>, <coralreef:reef:1>, <coralreef:reef:1>], 
  [<coralreef:reef:1>, <harvestcraft:wovencottonitem>, <coralreef:reef:1>, <harvestcraft:wovencottonitem>, <coralreef:reef:1>], 
  [<coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>]])
  .addOutput(<simplesponge:sponge>)
  .addTool(<ore:artisansBurner>, 32)
  .addTool(<ore:artisansBeaker>, 16)
  .create();

    RecipeBuilder.get("chemist")
  .setShaped([
  [<coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>], 
  [<coralreef:reef:1>, <minecraft:string>, <coralreef:reef:1>, <minecraft:string>, <coralreef:reef:1>], 
  [<coralreef:reef:1>, <coralreef:reef:1>, <minecraft:string>, <coralreef:reef:1>, <coralreef:reef:1>], 
  [<coralreef:reef:1>, <minecraft:string>, <coralreef:reef:1>, <minecraft:string>, <coralreef:reef:1>], 
  [<coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>]])
  .addOutput(<minecraft:sponge>)
  .addTool(<ore:artisansBurner>, 16)
  .addTool(<ore:artisansBeaker>, 16)
  .create();

  RecipeBuilder.get("chemist")
  .setShaped([
  [null, null, null, <ore:blockSlime>, null], 
  [null, null, <ore:blockSlime>, <ore:sponge>, <ore:blockSlime>], 
  [null, <ore:stickTreatedWood>, <ore:plankTreatedWood>, <ore:blockSlime>, null], 
  [<ore:stickTreatedWood>, <ore:plankTreatedWood>, <ore:stickTreatedWood>, null, null], 
  [<ore:plankTreatedWood>, <ore:stickTreatedWood>, null, null, null]])
  .addOutput(<simplesponge:sponge_on_a_stick>)
  .addTool(<ore:artisansBurner>, 32)
  .addTool(<ore:artisansBeaker>, 16)
  .create();

  RecipeBuilder.get("chemist")
  .setShaped([
  [null, null, null, <ore:sponge>, null], 
  [null, null, <ore:sponge>, <cyclicmagic:battery>, <ore:sponge>], 
  [null, <ore:stickTreatedWood>, <ore:plankTreatedWood>, <ore:sponge>, null], 
  [<ore:stickTreatedWood>, <ore:plankTreatedWood>, <ore:stickTreatedWood>, null, null], 
  [<ore:plankTreatedWood>, <ore:stickTreatedWood>, null, null, null]])
  .addOutput(<simplesponge:energized_sponge_on_a_stick>)
  .addTool(<ore:artisansBurner>, 32)
  .addTool(<ore:artisansBeaker>, 16)
  .create();

    RecipeBuilder.get("chemist")
  .setShaped([
  [<minecraft:snowball>, <minecraft:snowball>, <minecraft:snowball>], 
  [<minecraft:snowball>, <minecraft:snowball>, <minecraft:snowball>], 
  [<minecraft:snowball>, <minecraft:snowball>, <minecraft:snowball>]])
  .setFluid(<liquid:purified_water> * 500)
  .addOutput(<minecraft:ice>)
  .addTool(<ore:artisansBeaker>, 12)
  .addTool(<ore:artisansBurner>, 16)
  .create();

    RecipeBuilder.get("chemist")
  .setShaped([
  [<minecraft:ice>, <minecraft:ice>, null], 
  [<minecraft:ice>, <minecraft:ice>, null], 
  [null, null, null]])
  .setFluid(<liquid:purified_water> * 500)
  .addOutput(<minecraft:packed_ice>)
  .addTool(<ore:artisansBeaker>, 16)
  .addTool(<ore:artisansBurner>, 16)
  .create();

      RecipeBuilder.get("chemist")
  .setShaped([
  [null, <minecraft:prismarine_shard>, null], 
  [null, <minecraft:prismarine_shard>, null], 
  [null, null, null]])
  .addOutput(<jetorches:material:2>)
  .addTool(<ore:artisansBurner>, 16)
  .addTool(<ore:artisansBurner>, 16)
  .create();


    RecipeBuilder.get("chemist")
  .setShaped([
 [<embers:shard_ember>, <embers:shard_ember>, <embers:shard_ember>], 
  [<embers:shard_ember>, <embers:shard_ember>, <embers:shard_ember>], 
  [<embers:shard_ember>, <embers:shard_ember>, <embers:shard_ember>]])
  .setFluid(<liquid:purified_water> * 100)
  .addOutput(<embers:crystal_ember>)
  .addTool(<ore:artisansBeaker>, 16)
  .addTool(<ore:artisansBurner>, 16)
  .create();

    RecipeBuilder.get("chemist")
  .setShaped([
 [<ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>], 
  [<ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>], 
  [<ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>], 
  [<ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>], 
  [<ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockGold>, <ore:blockPackedIce>, <ore:blockPackedIce>]])
  .setFluid(<liquid:purified_water> * 4000)
  .addOutput(<capsule:capsule:5>.withTag({color: 13421772, size: 5, isReward: 1 as byte, oneUse: 1 as byte, structureName: "config/capsule/rewards/glacidusportal", author: "BoolymanMC", display: {color: 8072841}, label: "Glacidusportal", canRotate: 1 as byte}))
  .addTool(<ore:artisansBeaker>, 48)
  .addTool(<ore:artisansBurner>, 48)
  .create();

    RecipeBuilder.get("chemist")
  .setShaped([
  [<minecraft:snowball>, <minecraft:snowball>, <minecraft:snowball>], 
  [<minecraft:snowball>, <minecraft:snowball>, <minecraft:snowball>], 
  [<minecraft:snowball>, <minecraft:snowball>, <minecraft:snowball>]])
  .setFluid(<liquid:purified_water> * 500)
  .addOutput(<minecraft:ice>)
  .addTool(<ore:artisansBeaker>, 12)
  .addTool(<ore:artisansBurner>, 16)
  .create();

    RecipeBuilder.get("chemist")
  .setShaped([
  [<contenttweaker:dust_ddg>, <ore:crystalSlag>, <contenttweaker:dust_ddg>], 
  [<ore:crystalSlag>, <contenttweaker:dust_ddg>, <ore:crystalSlag>], 
  [<contenttweaker:dust_ddg>, <ore:crystalSlag>, <contenttweaker:dust_ddg>]])
  .setFluid(<liquid:purified_water> * 200)
  .addOutput(<thermalfoundation:fertilizer>)
  .addTool(<ore:artisansBeaker>, 12)
  .addTool(<ore:artisansBurner>, 16)
  .create();

    RecipeBuilder.get("chemist")
  .setShaped([
  [<ore:bonemeal>, <ore:bonemeal>, <ore:bonemeal>], 
  [<thermalfoundation:fertilizer>, <redstone_lock:dookie>, <thermalfoundation:fertilizer>], 
  [<ore:bonemeal>, <ore:bonemeal>, <ore:bonemeal>]])
  .setFluid(<liquid:purified_water> * 200)
  .addOutput(<thermalfoundation:fertilizer:1> * 2)
  .addTool(<ore:artisansBeaker>, 12)
  .addTool(<ore:artisansBurner>, 16)
  .create();

    RecipeBuilder.get("chemist")
  .setShaped([
  [<minecraft:blaze_powder>, <minecraft:blaze_powder>, <minecraft:blaze_powder>], 
  [<minecraft:blaze_powder>, <thermalfoundation:fertilizer:1>, <minecraft:blaze_powder>], 
  [<minecraft:blaze_powder>, <minecraft:blaze_powder>, <minecraft:blaze_powder>]])
  .setFluid(<liquid:purified_water> * 500)
  .addOutput(<thermalfoundation:fertilizer:2> * 2)
  .addTool(<ore:artisansBeaker>, 24)
  .addTool(<ore:artisansBurner>, 16)
  .create();

    RecipeBuilder.get("chemist")
  .setShaped([
  [<ore:rodBlizz>, <ore:blockPackedIce>, null], 
  [<glacidus:crysium>, <ore:dustRedstone>, null], 
  [null, null, null]])
  .setFluid(<liquid:purified_water> * 100)
  .addOutput(<thermalfoundation:material:1025> * 2)
  .addTool(<ore:artisansBeaker>, 8)
  .addTool(<ore:artisansBurner>, 8)
  .create();

      RecipeBuilder.get("chemist")
  .setShaped([
  [<ore:blockClay>, <ore:endstone>, null], 
  [<ore:sand>, <ore:gravel>, null], 
  [null, null, null]])
  .setFluid(<liquid:purified_water> * 100)
  .addOutput(<enderio:item_material:22> * 2)
  .addTool(<ore:artisansBeaker>, 8)
  .addTool(<ore:artisansBurner>, 8)
  .create();

      RecipeBuilder.get("chemist")
  .setShaped([
  [<contenttweaker:omega_fragment>, <contenttweaker:omega_fragment>, <contenttweaker:omega_fragment>], 
  [<contenttweaker:omega_fragment>, <contenttweaker:omega_fragment>, <contenttweaker:omega_fragment>], 
  [<contenttweaker:omega_fragment>, <contenttweaker:omega_fragment>, <contenttweaker:omega_fragment>]])
  .setFluid(<liquid:pyrotheum> * 100)
  .addOutput(<contenttweaker:omega_shard>)
  .addTool(<ore:artisansBeaker>, 8)
  .addTool(<ore:artisansBurner>, 8)
  .create();

      RecipeBuilder.get("chemist")
  .setShaped([
  [<contenttweaker:omega_shard>, <contenttweaker:omega_shard>, null], 
  [<contenttweaker:omega_shard>, <contenttweaker:omega_shard>, null], 
  [null, null, null]])
  .setFluid(<liquid:pyrotheum> * 100)
  .addOutput(<contenttweaker:omega_gem>)
  .addTool(<ore:artisansBeaker>, 16)
  .addTool(<ore:artisansBurner>, 16)
  .create();

        RecipeBuilder.get("chemist")
  .setShaped([
  [<contenttweaker:omega_gem>, <contenttweaker:omega_gem>, <contenttweaker:omega_gem>], 
  [<contenttweaker:omega_gem>, <contenttweaker:omega_gem>, <contenttweaker:omega_gem>], 
  [<contenttweaker:omega_gem>, <contenttweaker:omega_gem>, <contenttweaker:omega_gem>]])
  .setFluid(<liquid:pyrotheum> * 100)
  .addOutput(<contenttweaker:omega_flare>)
  .addTool(<ore:artisansBeaker>, 24)
  .addTool(<ore:artisansBurner>, 24)
  .create();

        RecipeBuilder.get("chemist")
  .setShaped([
  [<contenttweaker:infinity_fragment>, <contenttweaker:infinity_fragment>, <contenttweaker:infinity_fragment>], 
  [<contenttweaker:infinity_fragment>, <contenttweaker:infinity_fragment>, <contenttweaker:infinity_fragment>], 
  [<contenttweaker:infinity_fragment>, <contenttweaker:infinity_fragment>, <contenttweaker:infinity_fragment>]])
  .setFluid(<liquid:cryotheum> * 100)
  .addOutput(<contenttweaker:infinity_shard>)
  .addTool(<ore:artisansBeaker>, 8)
  .addTool(<ore:artisansBurner>, 8)
  .create();

      RecipeBuilder.get("chemist")
  .setShaped([
  [<contenttweaker:infinity_shard>, <contenttweaker:infinity_shard>, null], 
  [<contenttweaker:infinity_shard>, <contenttweaker:infinity_shard>, null], 
  [null, null, null]])
  .setFluid(<liquid:cryotheum> * 100)
  .addOutput(<contenttweaker:infinity_gem>)
  .addTool(<ore:artisansBeaker>, 16)
  .addTool(<ore:artisansBurner>, 16)
  .create();

        RecipeBuilder.get("chemist")
  .setShaped([
  [<contenttweaker:infinity_gem>, <contenttweaker:infinity_gem>, <contenttweaker:infinity_gem>], 
  [<contenttweaker:infinity_gem>, <contenttweaker:infinity_gem>, <contenttweaker:infinity_gem>], 
  [<contenttweaker:infinity_gem>, <contenttweaker:infinity_gem>, <contenttweaker:infinity_gem>]])
  .setFluid(<liquid:cryotheum> * 100)
  .addOutput(<contenttweaker:infinity_flare>)
  .addTool(<ore:artisansBeaker>, 24)
  .addTool(<ore:artisansBurner>, 16)
  .create();


          RecipeBuilder.get("chemist")
  .setShaped([
  [<contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>], 
  [<contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>], 
  [<contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>]])
  .addOutput(<enderio:item_material:51>)
  .addTool(<ore:artisansBeaker>, 24)
  .addTool(<ore:artisansBurner>, 16)
  .create();

          RecipeBuilder.get("chemist")
  .setShaped([
  [<contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>], 
  [<contenttweaker:dust_ddg>, <thermalfoundation:material:1027>, <contenttweaker:dust_ddg>], 
  [<contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>]])
  .addOutput(<contenttweaker:blank_upgradebase>)
  .addTool(<ore:artisansBeaker>, 12)
  .addTool(<ore:artisansBurner>, 12)
  .create();

          RecipeBuilder.get("chemist")
  .setShaped([
  [<thermalfoundation:material:832>, <thermalfoundation:material:832>, null], 
  [<thermalfoundation:material:832>, <thermalfoundation:material:832>, null], 
  [null, null, null]])
  .addOutput(<contenttweaker:blank_upgradebase>)
  .addTool(<ore:artisansBeaker>, 12)
  .addTool(<ore:artisansBurner>, 12)
  .create();

          RecipeBuilder.get("chemist")
  .setShaped([
  [<contenttweaker:omega_shard>, <contenttweaker:infinity_shard>, <contenttweaker:omega_shard>], 
  [<contenttweaker:infinity_shard>, <ore:compressedEgg2x>, <contenttweaker:infinity_shard>], 
  [<contenttweaker:omega_shard>, <contenttweaker:infinity_shard>, <contenttweaker:omega_shard>]])
  .addOutput(<redstone_lock:fakeegg>)
  .addTool(<ore:artisansBeaker>, 12)
  .addTool(<ore:artisansBurner>, 12)
  .create();

RecipeBuilder.get("chemist")
  .setShapeless([<embers:adhesive>, <embers:adhesive>, <embers:adhesive>, <minecraft:bucket>])
  .setFluid(<liquid:sap> * 1000)
  .addOutput(<forge:bucketfilled>.withTag({FluidName: "glue", Amount: 1000}))
  .addTool(<ore:artisansBeaker>, 16)
  .addTool(<ore:artisansBurner>, 16)
  .create();