#packmode artisansimple
import mods.artisanworktables.builder.RecipeBuilder;

//  Shapeless ======================================================================================================================
RecipeBuilder.get("basic")
  .setShapeless([<minecraft:slime_ball>, <minecraft:slime_ball>, <toughasnails:magma_shard>])
  .addOutput(<armorunder:heating_goo> * 2)
      .create();

  RecipeBuilder.get("basic")
  .setShapeless([<minecraft:gunpowder>, <ftrsquids:turbotube>])
  .addOutput(<cyclicmagic:ender_tnt_2>)
      .create();

  RecipeBuilder.get("basic")
  .setShapeless([<minecraft:dye:15>, <minecraft:coal:1>])
  .addOutput(<minecraft:gunpowder>)
      .create();


  RecipeBuilder.get("basic")
  .setShapeless([<minecraft:sand>, <ore:gemLapis>, <minecraft:clay_ball>])
  .addOutput(<buildinggadgets:constructionblockpowder>)
      .create();

  RecipeBuilder.get("basic")
  .setShapeless([<thermalfoundation:fertilizer:2>, <minecraft:dye:4>])
  .addOutput(<enderio:item_material:38>)
      .create();

  RecipeBuilder.get("basic")
  .setShapeless([<minecraft:clay>, <minecraft:slime_ball>])
  .addOutput(<thermalfoundation:material:832> * 4)
         .create();

  RecipeBuilder.get("basic")
  .setShapeless([<ore:dustIron>, <ore:dustIron>, <enderio:item_material:20>])
  .addOutput(<contenttweaker:infinity_dust> * 2)
      .create();

  RecipeBuilder.get("basic")
  .setShapeless([<minecraft:sand>, <thermalfoundation:material:769>, <thermalfoundation:material:832>])
  .addOutput(<contenttweaker:sheet_rubber> * 2)
      .create();

  RecipeBuilder.get("basic")
  .setShapeless([<ore:dustLead>, <ore:dustLead>, <ore:dustTin>])
  .addOutput(<contenttweaker:dust_solder> * 2)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<ore:dustTin>, <ore:dustSilver>, <ore:dustGlowstone>])
  .addOutput(<thermalfoundation:material:102> * 2)
    .create();

    RecipeBuilder.get("basic")
  .setShapeless([<ore:dustSilver>, <ore:dustGold>])
  .addOutput(<thermalfoundation:material:97> * 2)
    .create();

    RecipeBuilder.get("basic")
  .setShapeless([<ore:dustIron>, <ore:dustIron>, <ore:dustNickel>])
  .addOutput(<thermalfoundation:material:98> * 2)
    .create();

    RecipeBuilder.get("basic")
  .setShapeless([<ore:dustCopper>, <ore:dustCopper>, <ore:dustTin>])
  .addOutput(<thermalfoundation:material:99> * 2)
    .create();

    RecipeBuilder.get("basic")
  .setShapeless([<ore:dustNickel>, <ore:dustNickel>, <ore:dustCopper>])
  .addOutput(<thermalfoundation:material:100> * 2)
    .create();

    RecipeBuilder.get("basic")
  .setShapeless([<ore:dustCopper>, <ore:dustSilver>, <ore:dustRedstone>])
  .addOutput(<thermalfoundation:material:101> * 2)
    .create();

      RecipeBuilder.get("basic")
  .setShapeless([<ore:dustLead>, <ore:dustPlatinum>, <minecraft:ender_pearl>])
  .addOutput(<thermalfoundation:material:103> * 2)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<minecraft:prismarine>])
  .addOutput(<minecraft:prismarine_shard> * 2)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<minecraft:prismarine_shard>, <minecraft:ice>])
  .addOutput(<minecraft:prismarine_crystals>)
      .create();

  RecipeBuilder.get("basic")
  .setShapeless([<minecraft:prismarine_crystals>, <jetorches:material:2>])
  .addOutput(<jetorches:torch:2> * 4)
      .create();

RecipeBuilder.get("basic")
  .setShapeless([<minecraft:slime_ball>, <minecraft:slime_ball>, <minecraft:packed_ice>])
  .addOutput(<armorunder:cooling_goo> * 2)
      .create();

  RecipeBuilder.get("basic")
  .setShapeless([<minecraft:clay_ball>, <ore:sand>])
    .addOutput(<embers:blend_caminite> * 2)
      .create();

    RecipeBuilder.get("basic")
  .setShapeless([<minecraft:dye:15>, <embers:blend_caminite>])
    .addOutput(<embers:adhesive> * 2)
      .create();

      RecipeBuilder.get("basic")
  .setShapeless([<minecraft:dye:15>, <rats:raw_plastic>])
    .addOutput(<embers:adhesive> * 2)
      .create();

    RecipeBuilder.get("basic")
  .setShapeless([<immersiveengineering:material:7>, <immersiveengineering:material:7>, <better_diving:fiber_mesh>])
    .addOutput(<embers:adhesive>)
      .create();


//  Shaped ==============================================================================================================================
  RecipeBuilder.get("basic")
  .setShaped([
  [<coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>], 
  [<coralreef:reef:1>, <harvestcraft:wovencottonitem>, <coralreef:reef:1>, <harvestcraft:wovencottonitem>, <coralreef:reef:1>], 
  [<coralreef:reef:1>, <coralreef:reef:1>, <harvestcraft:wovencottonitem>, <coralreef:reef:1>, <coralreef:reef:1>], 
  [<coralreef:reef:1>, <harvestcraft:wovencottonitem>, <coralreef:reef:1>, <harvestcraft:wovencottonitem>, <coralreef:reef:1>], 
  [<coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>]])
  .addOutput(<simplesponge:sponge>)
      .create();

    RecipeBuilder.get("basic")
  .setShaped([
  [<coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>], 
  [<coralreef:reef:1>, <minecraft:string>, <coralreef:reef:1>, <minecraft:string>, <coralreef:reef:1>], 
  [<coralreef:reef:1>, <coralreef:reef:1>, <minecraft:string>, <coralreef:reef:1>, <coralreef:reef:1>], 
  [<coralreef:reef:1>, <minecraft:string>, <coralreef:reef:1>, <minecraft:string>, <coralreef:reef:1>], 
  [<coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>, <coralreef:reef:1>]])
  .addOutput(<minecraft:sponge>)
      .create();

  RecipeBuilder.get("basic")
  .setShaped([
  [null, null, null, <ore:blockSlime>, null], 
  [null, null, <ore:blockSlime>, <ore:sponge>, <ore:blockSlime>], 
  [null, <ore:stickTreatedWood>, <ore:plankTreatedWood>, <ore:blockSlime>, null], 
  [<ore:stickTreatedWood>, <ore:plankTreatedWood>, <ore:stickTreatedWood>, null, null], 
  [<ore:plankTreatedWood>, <ore:stickTreatedWood>, null, null, null]])
  .addOutput(<simplesponge:sponge_on_a_stick>)
      .create();

  RecipeBuilder.get("basic")
  .setShaped([
  [null, null, null, <ore:sponge>, null], 
  [null, null, <ore:sponge>, <cyclicmagic:battery>, <ore:sponge>], 
  [null, <ore:stickTreatedWood>, <ore:plankTreatedWood>, <ore:sponge>, null], 
  [<ore:stickTreatedWood>, <ore:plankTreatedWood>, <ore:stickTreatedWood>, null, null], 
  [<ore:plankTreatedWood>, <ore:stickTreatedWood>, null, null, null]])
  .addOutput(<simplesponge:energized_sponge_on_a_stick>)
      .create();

    RecipeBuilder.get("basic")
  .setShaped([
  [<minecraft:snowball>, <minecraft:snowball>, <minecraft:snowball>], 
  [<minecraft:snowball>, <minecraft:snowball>, <minecraft:snowball>], 
  [<minecraft:snowball>, <minecraft:snowball>, <minecraft:snowball>]])
    .addOutput(<minecraft:ice>)
      .create();

    RecipeBuilder.get("basic")
  .setShaped([
  [<minecraft:ice>, <minecraft:ice>, null], 
  [<minecraft:ice>, <minecraft:ice>, null], 
  [null, null, null]])
    .addOutput(<minecraft:packed_ice>)
      .create();

      RecipeBuilder.get("basic")
  .setShaped([
  [null, <minecraft:prismarine_shard>, null], 
  [null, <minecraft:prismarine_shard>, null], 
  [null, null, null]])
  .addOutput(<jetorches:material:2>)
      .create();


    RecipeBuilder.get("basic")
  .setShaped([
 [<embers:shard_ember>, <embers:shard_ember>, <embers:shard_ember>], 
  [<embers:shard_ember>, <embers:shard_ember>, <embers:shard_ember>], 
  [<embers:shard_ember>, <embers:shard_ember>, <embers:shard_ember>]])
    .addOutput(<embers:crystal_ember>)
      .create();

    RecipeBuilder.get("basic")
  .setShaped([
 [<ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>], 
  [<ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>], 
  [<ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>], 
  [<ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockPackedIce>], 
  [<ore:blockPackedIce>, <ore:blockPackedIce>, <ore:blockGold>, <ore:blockPackedIce>, <ore:blockPackedIce>]])
    .addOutput(<capsule:capsule:5>.withTag({color: 13421772, size: 5, isReward: 1 as byte, oneUse: 1 as byte, structureName: "config/capsule/rewards/glacidusportal", author: "BoolymanMC", display: {color: 8072841}, label: "Glacidusportal", canRotate: 1 as byte}))
      .create();

    RecipeBuilder.get("basic")
  .setShaped([
  [<minecraft:snowball>, <minecraft:snowball>, <minecraft:snowball>], 
  [<minecraft:snowball>, <minecraft:snowball>, <minecraft:snowball>], 
  [<minecraft:snowball>, <minecraft:snowball>, <minecraft:snowball>]])
    .addOutput(<minecraft:ice>)
      .create();

    RecipeBuilder.get("basic")
  .setShaped([
  [<contenttweaker:dust_ddg>, <ore:crystalSlag>, <contenttweaker:dust_ddg>], 
  [<ore:crystalSlag>, <contenttweaker:dust_ddg>, <ore:crystalSlag>], 
  [<contenttweaker:dust_ddg>, <ore:crystalSlag>, <contenttweaker:dust_ddg>]])
    .addOutput(<thermalfoundation:fertilizer>)
      .create();

    RecipeBuilder.get("basic")
  .setShaped([
  [<ore:bonemeal>, <ore:bonemeal>, <ore:bonemeal>], 
  [<thermalfoundation:fertilizer>, <redstone_lock:dookie>, <thermalfoundation:fertilizer>], 
  [<ore:bonemeal>, <ore:bonemeal>, <ore:bonemeal>]])
    .addOutput(<thermalfoundation:fertilizer:1> * 2)
      .create();

    RecipeBuilder.get("basic")
  .setShaped([
  [<minecraft:blaze_powder>, <minecraft:blaze_powder>, <minecraft:blaze_powder>], 
  [<minecraft:blaze_powder>, <thermalfoundation:fertilizer:1>, <minecraft:blaze_powder>], 
  [<minecraft:blaze_powder>, <minecraft:blaze_powder>, <minecraft:blaze_powder>]])
    .addOutput(<thermalfoundation:fertilizer:2> * 2)
      .create();

    RecipeBuilder.get("basic")
  .setShaped([
  [<ore:rodBlizz>, <ore:blockPackedIce>, null], 
  [<glacidus:crysium>, <ore:dustRedstone>, null], 
  [null, null, null]])
    .addOutput(<thermalfoundation:material:1025> * 2)
      .create();

      RecipeBuilder.get("basic")
  .setShaped([
  [<ore:blockClay>, <ore:endstone>, null], 
  [<ore:sand>, <ore:gravel>, null], 
  [null, null, null]])
    .addOutput(<enderio:item_material:22> * 2)
      .create();

      RecipeBuilder.get("basic")
  .setShaped([
  [<contenttweaker:omega_fragment>, <contenttweaker:omega_fragment>, <contenttweaker:omega_fragment>], 
  [<contenttweaker:omega_fragment>, <contenttweaker:omega_fragment>, <contenttweaker:omega_fragment>], 
  [<contenttweaker:omega_fragment>, <contenttweaker:omega_fragment>, <contenttweaker:omega_fragment>]])
    .addOutput(<contenttweaker:omega_shard>)
      .create();

      RecipeBuilder.get("basic")
  .setShaped([
  [<contenttweaker:omega_shard>, <contenttweaker:omega_shard>, null], 
  [<contenttweaker:omega_shard>, <contenttweaker:omega_shard>, null], 
  [null, null, null]])
    .addOutput(<contenttweaker:omega_gem>)
      .create();

        RecipeBuilder.get("basic")
  .setShaped([
  [<contenttweaker:omega_gem>, <contenttweaker:omega_gem>, <contenttweaker:omega_gem>], 
  [<contenttweaker:omega_gem>, <contenttweaker:omega_gem>, <contenttweaker:omega_gem>], 
  [<contenttweaker:omega_gem>, <contenttweaker:omega_gem>, <contenttweaker:omega_gem>]])
    .addOutput(<contenttweaker:omega_flare>)
      .create();

        RecipeBuilder.get("basic")
  .setShaped([
  [<contenttweaker:infinity_fragment>, <contenttweaker:infinity_fragment>, <contenttweaker:infinity_fragment>], 
  [<contenttweaker:infinity_fragment>, <contenttweaker:infinity_fragment>, <contenttweaker:infinity_fragment>], 
  [<contenttweaker:infinity_fragment>, <contenttweaker:infinity_fragment>, <contenttweaker:infinity_fragment>]])
    .addOutput(<contenttweaker:infinity_shard>)
      .create();

      RecipeBuilder.get("basic")
  .setShaped([
  [<contenttweaker:infinity_shard>, <contenttweaker:infinity_shard>, null], 
  [<contenttweaker:infinity_shard>, <contenttweaker:infinity_shard>, null], 
  [null, null, null]])
    .addOutput(<contenttweaker:infinity_gem>)
      .create();

        RecipeBuilder.get("basic")
  .setShaped([
  [<contenttweaker:infinity_gem>, <contenttweaker:infinity_gem>, <contenttweaker:infinity_gem>], 
  [<contenttweaker:infinity_gem>, <contenttweaker:infinity_gem>, <contenttweaker:infinity_gem>], 
  [<contenttweaker:infinity_gem>, <contenttweaker:infinity_gem>, <contenttweaker:infinity_gem>]])
    .addOutput(<contenttweaker:infinity_flare>)
      .create();


          RecipeBuilder.get("basic")
  .setShaped([
  [<contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>], 
  [<contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>], 
  [<contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>]])
  .addOutput(<enderio:item_material:51>)
      .create();

          RecipeBuilder.get("basic")
  .setShaped([
  [<contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>], 
  [<contenttweaker:dust_ddg>, <thermalfoundation:material:1027>, <contenttweaker:dust_ddg>], 
  [<contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>, <contenttweaker:dust_ddg>]])
  .addOutput(<contenttweaker:blank_upgradebase>)
      .create();

          RecipeBuilder.get("basic")
  .setShaped([
  [<thermalfoundation:material:832>, <thermalfoundation:material:832>, null], 
  [<thermalfoundation:material:832>, <thermalfoundation:material:832>, null], 
  [null, null, null]])
  .addOutput(<contenttweaker:blank_upgradebase>)
      .create();

          RecipeBuilder.get("basic")
  .setShaped([
  [<contenttweaker:omega_shard>, <contenttweaker:infinity_shard>, <contenttweaker:omega_shard>], 
  [<contenttweaker:infinity_shard>, <ore:compressedEgg2x>, <contenttweaker:infinity_shard>], 
  [<contenttweaker:omega_shard>, <contenttweaker:infinity_shard>, <contenttweaker:omega_shard>]])
  .addOutput(<redstone_lock:fakeegg>)
      .create();

RecipeBuilder.get("basic")
  .setShapeless([<embers:adhesive>, <embers:adhesive>, <embers:adhesive>, <minecraft:bucket>])
    .addOutput(<forge:bucketfilled>.withTag({FluidName: "glue", Amount: 1000}))
      .create();