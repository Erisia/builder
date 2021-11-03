import mods.artisanworktables.builder.RecipeBuilder;

//  Shapeless ======================================================================================================================

  RecipeBuilder.get("mage")
  .setShapeless([<contenttweaker:sheet_rubber>, <enderio:item_soul_vial>])
    .setFluid(<liquid:xpjuice> * 250)
  .addOutput(<modularforcefieldsystem:module_containment>)
  .addTool(<ore:artisansLens>, 12)
  .create();

    RecipeBuilder.get("mage")
  .setShapeless([<enderio:item_alloy_ingot>, <enderio:item_alloy_ingot>, <better_diving:wiring_kit>])
    .setFluid(<liquid:xpjuice> * 250)
  .addOutput(<contenttweaker:emptycap>)
  .addTool(<ore:artisansLens>, 12)
  .create();

    RecipeBuilder.get("mage")
  .setShapeless([<enderio:item_material:4>, <appliedenergistics2:part:16>])
    .setFluid(<liquid:xpjuice> * 100)
  .addOutput(<enderio:item_me_conduit>)
  .addTool(<ore:artisansLens>, 12)
  .create();

      RecipeBuilder.get("mage")
  .setShapeless([<enderio:item_material:4>, <appliedenergistics2:part:516>])
    .setFluid(<liquid:xpjuice> * 100)
  .addOutput(<enderio:item_me_conduit:1>)
  .addTool(<ore:artisansLens>, 12)
  .create();

    RecipeBuilder.get("mage")
  .setShapeless([<enderio:block_transceiver>, <enderio:item_material:14>])
    .setFluid(<liquid:xpjuice> * 1000)
  .addOutput(<enderio:block_travel_anchor>)
  .addTool(<ore:artisansLens>, 32)
  .create();

  RecipeBuilder.get("mage")
  .setShapeless([<contenttweaker:sheet_rubber>, <minecraft:iron_sword>])
    .setFluid(<liquid:xpjuice> * 500)
  .addOutput(<modularforcefieldsystem:option_mob_defense>)
  .addTool(<ore:artisansLens>, 12)
  .create();

  RecipeBuilder.get("mage")
  .setShapeless([<contenttweaker:sheet_rubber>, <minecraft:redstone_block>])
    .setFluid(<liquid:xpjuice> * 500)
  .addOutput(<modularforcefieldsystem:projector_focus_matrix> * 8)
  .addTool(<ore:artisansLens>, 12)
  .create();

  RecipeBuilder.get("mage")
  .setShapeless([<contenttweaker:sheet_rubber>, <yoyos:iron_yoyo>])
    .setFluid(<liquid:xpjuice> * 500)
  .addOutput(<modularforcefieldsystem:projector_distance> * 8)
  .addTool(<ore:artisansLens>, 12)
  .create();

    RecipeBuilder.get("mage")
  .setShapeless([<contenttweaker:sheet_rubber>, <ore:plateIron>])
    .setFluid(<liquid:xpjuice> * 500)
  .addOutput(<modularforcefieldsystem:projector_strength> * 8)
  .addTool(<ore:artisansLens>, 12)
  .create();

    RecipeBuilder.get("mage")
  .setShapeless([<contenttweaker:sheet_rubber>, <minecraft:dye>])
    .setFluid(<liquid:xpjuice> * 250)
  .addOutput(<modularforcefieldsystem:empty_card>)
  .addTool(<ore:artisansLens>, 12)
  .create();

      RecipeBuilder.get("mage")
  .setShapeless([<enderio:item_yeta_wrench>, <thermalfoundation:material:514>, <better_diving:wiring_kit>])
    .setFluid(<liquid:xpjuice> * 500)
  .addOutput(<modularforcefieldsystem:multitool_wrench:101>)
  .addTool(<ore:artisansLens>, 12)
  .create();


//  Shaped ==============================================================================================================================

  RecipeBuilder.get("mage")
  .setShaped([
  [<minecraft:end_rod>, null, null, null, <minecraft:end_rod>], 
  [<minecraft:end_rod>, <ore:blockGlassHardened>, null, <ore:blockGlassHardened>, <minecraft:end_rod>], 
  [<ore:blockGlassHardened>, <contenttweaker:infinity_gem>, <ore:blockGlassHardened>, <contenttweaker:omega_gem>, <ore:blockGlassHardened>], 
  [null, <ore:blockGlassHardened>, null, <ore:blockGlassHardened>, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:xpjuice> * 2000)
  .addOutput(<openblocks:serious_glasses>)
  .create();

  RecipeBuilder.get("mage")
  .setShaped([
  [<ore:itemSimpleChassiParts>, <ore:plateEnderium>, <ore:itemSimpleChassiParts>, null, null], 
  [<ore:plateEnderium>, null, <ore:plateEnderium>, null, null], 
  [<ore:itemSimpleChassiParts>, <ore:plateEnderium>, <ore:itemSimpleChassiParts>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:xpjuice> * 250)
  .addOutput(<enderio:item_material>)
    .addTool(<ore:artisansLens>, 24)
  .create();

  RecipeBuilder.get("mage")
  .setShaped([
  [<ore:ingotConstructionAlloy>, <ore:gearEnderium>, <ore:ingotConstructionAlloy>, null, null], 
  [<artisanworktables:artisans_cutters_gold>, <ore:itemSimpleMachineChassi>, <artisanworktables:artisans_cutters_gold>, null, null], 
  [<ore:ingotConstructionAlloy>, <ore:gearEnderium>, <ore:ingotConstructionAlloy>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:xpjuice> * 1000)
  .addOutput(<enderio:block_slice_and_splice>)
    .addTool(<ore:artisansLens>, 12)
  .create();

  RecipeBuilder.get("mage")
  .setShaped([
 [<toughasnails:tan_icon>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <toughasnails:tan_icon>], 
	[<contenttweaker:infinity_plate>, <minecraft:furnace>, <minecraft:furnace>, <minecraft:furnace>, <contenttweaker:infinity_plate>], 
	[<ore:gearEnergized>, <better_diving:wiring_kit>, <ore:itemMachineChassi>, <better_diving:wiring_kit>, <ore:gearEnergized>], 
	[<contenttweaker:infinity_plate>, <immersiveengineering:wooden_device0>, <immersiveengineering:wooden_device0>, <immersiveengineering:wooden_device0>, <contenttweaker:infinity_plate>], 
	[<toughasnails:tan_icon>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:xpjuice> * 1000)
  .addOutput(<enderio:block_enhanced_alloy_smelter>)
    .addTool(<ore:artisansLens>, 36)
  .create();

  RecipeBuilder.get("mage")
  .setShaped([
[<toughasnails:tan_icon>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <toughasnails:tan_icon>], 
	[<contenttweaker:infinity_plate>, <embers:winding_gears>, <embers:winding_gears>, <embers:winding_gears>, <contenttweaker:infinity_plate>], 
	[<ore:gearVibrant>, <better_diving:wiring_kit>, <ore:itemMachineChassi>, <better_diving:wiring_kit>, <ore:gearVibrant>], 
	[<contenttweaker:infinity_plate>, <immersiveengineering:wooden_device0>, <immersiveengineering:wooden_device0>, <immersiveengineering:wooden_device0>, <contenttweaker:infinity_plate>], 
	[<toughasnails:tan_icon>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:xpjuice> * 1000)
  .addOutput(<enderio:block_enhanced_sag_mill>)
    .addTool(<ore:artisansLens>, 36)
  .create();

  RecipeBuilder.get("mage")
  .setShaped([
[<toughasnails:tan_icon>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <toughasnails:tan_icon>], 
	[<contenttweaker:infinity_plate>, <assistedprogression:item_pipette>, <better_diving:wiring_kit>, <assistedprogression:item_pipette>, <contenttweaker:infinity_plate>], 
	[<contenttweaker:infinity_plate>, <thermalexpansion:tank>, <ore:itemMachineChassi>, <thermalexpansion:tank>, <contenttweaker:infinity_plate>], 
	[<contenttweaker:infinity_plate>, <fluidfunnel:funnel>, <enderio:item_basic_capacitor:1>, <fluidfunnel:funnel>, <contenttweaker:infinity_plate>], 
	[<toughasnails:tan_icon>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:xpjuice> * 1000)
  .addOutput(<enderio:block_vat>)
    .addTool(<ore:artisansLens>, 36)
  .create();

RecipeBuilder.get("mage")
  .setShaped([
  [<ore:ingotConstructionAlloy>, <ore:gearEnderium>, <ore:ingotConstructionAlloy>, null, null], 
  [<ore:itemSkull>, <ore:itemSimpleMachineChassi>, <ore:itemSkull>, null, null], 
  [<ore:ingotConstructionAlloy>, <ore:gearEnderium>, <ore:ingotConstructionAlloy>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:xpjuice> * 1000)
  .addOutput(<enderio:block_soul_binder>)
    .addTool(<ore:artisansLens>, 24)
  .create();

RecipeBuilder.get("mage")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:ingotConstructionAlloy>, <ore:ingotConstructionAlloy>, <ore:ingotConstructionAlloy>, <toughasnails:tan_icon>], 
  [<ore:ingotConstructionAlloy>, null, <minecraft:dispenser>, null, <ore:ingotConstructionAlloy>], 
  [<ore:ingotConstructionAlloy>, <ore:gearIronInfinity>, <ore:itemMachineChassi>, <ore:gearIronInfinity>, <ore:ingotConstructionAlloy>], 
  [<ore:ingotConstructionAlloy>, null, <minecraft:dispenser>, null, <ore:ingotConstructionAlloy>], 
  [<toughasnails:tan_icon>, <ore:ingotConstructionAlloy>, <ore:ingotConstructionAlloy>, <ore:ingotConstructionAlloy>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:xpjuice> * 1000)
  .addOutput(<modularforcefieldsystem:projector>)
    .addTool(<ore:artisansLens>, 32)
  .create();

  RecipeBuilder.get("mage")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:ingotConstructionAlloy>, <ore:ingotConstructionAlloy>, <ore:ingotConstructionAlloy>, <toughasnails:tan_icon>], 
  [<ore:ingotConstructionAlloy>, null, <thermalfoundation:material:515>, null, <ore:ingotConstructionAlloy>], 
  [<ore:ingotConstructionAlloy>, <ore:gearEnergized>, <ore:itemMachineChassi>, <ore:gearEnergized>, <ore:ingotConstructionAlloy>], 
  [<ore:ingotConstructionAlloy>, null, <thermalfoundation:material:515>, null, <ore:ingotConstructionAlloy>], 
  [<toughasnails:tan_icon>, <ore:ingotConstructionAlloy>, <ore:ingotConstructionAlloy>, <ore:ingotConstructionAlloy>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:xpjuice> * 1000)
  .addOutput(<modularforcefieldsystem:capacitor>)
    .addTool(<ore:artisansLens>, 32)
  .create();

  RecipeBuilder.get("mage")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:ingotConstructionAlloy>, <ore:ingotConstructionAlloy>, <ore:ingotConstructionAlloy>, <toughasnails:tan_icon>], 
  [<ore:ingotConstructionAlloy>, null, <ore:chest>, null, <ore:ingotConstructionAlloy>], 
  [<ore:ingotConstructionAlloy>, <ore:gearVibrant>, <ore:itemMachineChassi>, <ore:gearVibrant>, <ore:ingotConstructionAlloy>], 
  [<ore:ingotConstructionAlloy>, null, <minecraft:furnace>, null, <ore:ingotConstructionAlloy>], 
  [<toughasnails:tan_icon>, <ore:ingotConstructionAlloy>, <ore:ingotConstructionAlloy>, <ore:ingotConstructionAlloy>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:xpjuice> * 1000)
  .addOutput(<modularforcefieldsystem:extractor>)
    .addTool(<ore:artisansLens>, 32)
  .create();

  RecipeBuilder.get("mage")
  .setShaped([
    [null, <minecraft:enchanting_table>, null, null, null], 
  [null, <contenttweaker:infinity_plate>, null, null, null], 
  [<contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:xpjuice> * 1500)
  .addOutput(<enderio:block_enchanter>)
    .addTool(<ore:artisansLens>, 32)
  .create();

    RecipeBuilder.get("mage")
  .setShaped([
    [<ore:ingotConstructionAlloy>, <ore:itemEnderCrystal>, <ore:ingotConstructionAlloy>, null, null], 
  [<minecraft:chest>, <better_diving:wiring_kit>, <minecraft:chest>, null, null], 
  [<ore:ingotConstructionAlloy>, <ore:itemEnderCrystal>, <ore:ingotConstructionAlloy>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:xpjuice> * 1500)
  .addOutput(<enderio:block_transceiver>)
    .addTool(<ore:artisansLens>, 32)
  .create();

    RecipeBuilder.get("mage")
  .setShaped([
    [<ore:ingotSoularium>, <ore:skullEnderResonator>, <ore:ingotSoularium>, null, null], 
  [<ore:ingotSoularium>, <ore:chest>, <ore:ingotSoularium>, null, null], 
  [<ore:ingotSoularium>, <ore:ingotSoularium>, <ore:ingotSoularium>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:xpjuice> * 1500)
  .addOutput(<enderio:block_vacuum_chest>)
    .addTool(<ore:artisansLens>, 32)
  .create();


    RecipeBuilder.get("mage")
  .setShaped([
    [<ore:ingotSoularium>, <ore:skullEnderResonator>, <ore:ingotSoularium>, null, null], 
  [<ore:ingotSoularium>, <openblocks:xp_drain>, <ore:ingotSoularium>, null, null], 
  [<ore:ingotSoularium>, <ore:ingotSoularium>, <ore:ingotSoularium>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:xpjuice> * 1500)
  .addOutput(<enderio:block_xp_vacuum>)
    .addTool(<ore:artisansLens>, 32)
  .create();

    RecipeBuilder.get("mage")
  .setShaped([
    [null, null, <ore:itemVibrantCrystal>, <ore:skullSentientEnder>, null], 
  [null, null, <ore:itemInfinityRod>, <ore:itemVibrantCrystal>, null], 
  [null, <ore:itemInfinityRod>, null, null, null], 
  [<ore:itemInfinityRod>, null, null, null, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:xpjuice> * 1000)
  .addOutput(<enderio:item_travel_staff>)
    .addTool(<ore:artisansLens>, 32)
  .create();

      RecipeBuilder.get("mage")
  .setShaped([
   [null, null, <ore:itemPulsatingCrystal>, <ore:skullGuardianDiode>, null], 
  [null, null, <ore:itemInfinityRod>, <ore:itemPulsatingCrystal>, null], 
  [null, <ore:itemInfinityRod>, null, null, null], 
  [<ore:itemInfinityRod>, null, null, null, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:xpjuice> * 1000)
  .addOutput(<enderio:item_rod_of_return>)
    .addTool(<ore:artisansLens>, 32)
  .create();

        RecipeBuilder.get("mage")
  .setShaped([
   [<ore:ingotEndSteel>, <ore:ingotEndSteel>, <ore:ingotEndSteel>], 
  [<ore:ingotEndSteel>, null, <ore:ingotEndSteel>], 
  [null, null, null]])
  .setFluid(<liquid:xpjuice> * 1500)
  .addOutput(<enderio:item_end_steel_helmet>)
    .addTool(<ore:artisansLens>, 32)
  .create();

          RecipeBuilder.get("mage")
  .setShaped([
   [<ore:ingotEndSteel>, <ore:ingotEndSteel>, <ore:ingotEndSteel>], 
  [<ore:ingotEndSteel>, null, <ore:ingotEndSteel>], 
  [<ore:ingotEndSteel>, null, <ore:ingotEndSteel>]])
  .setFluid(<liquid:xpjuice> * 1500)
  .addOutput(<enderio:item_end_steel_leggings>)
    .addTool(<ore:artisansLens>, 32)
  .create();

          RecipeBuilder.get("mage")
  .setShaped([
   [null, null, null], 
  [<ore:ingotEndSteel>, null, <ore:ingotEndSteel>], 
  [<ore:ingotEndSteel>, null, <ore:ingotEndSteel>]])
  .setFluid(<liquid:xpjuice> * 1500)
  .addOutput(<enderio:item_end_steel_boots>)
    .addTool(<ore:artisansLens>, 32)
  .create();

          RecipeBuilder.get("mage")
  .setShaped([
   [<ore:ingotEndSteel>, null, <ore:ingotEndSteel>], 
  [<ore:ingotEndSteel>, <simplyjetpacks:metaitemmods:11>, <ore:ingotEndSteel>], 
  [<ore:ingotEndSteel>, <ore:ingotEndSteel>, <ore:ingotEndSteel>]])
  .setFluid(<liquid:xpjuice> * 1500)
  .addOutput(<simplyjetpacks:itemjetpack:9>)
    .addTool(<ore:artisansLens>, 32)
  .create();


          RecipeBuilder.get("mage")
  .setShaped([
   [<ore:ingotEndSteel>, null, <ore:ingotEndSteel>], 
  [<ore:ingotEndSteel>, <ore:ingotEndSteel>, <ore:ingotEndSteel>], 
  [<ore:ingotEndSteel>, <ore:ingotEndSteel>, <ore:ingotEndSteel>]])
  .setFluid(<liquid:xpjuice> * 1500)
  .addOutput(<enderio:item_end_steel_chestplate>)
    .addTool(<ore:artisansLens>, 32)
  .create();

            RecipeBuilder.get("mage")
  .setShaped([
  [null, <ore:ingotEndSteel>, <ore:ingotEndSteel>, <ore:ingotEndSteel>, null], 
  [<ore:ingotEndSteel>, null, <ore:ingotEndSteel>, null, <ore:ingotEndSteel>], 
  [null, null, <ore:ingotEndSteel>, null, null], 
  [null, null, <ore:ingotEndSteel>, null, null], 
  [null, null, <ore:ingotEndSteel>, null, null]])
  .setFluid(<liquid:xpjuice> * 1500)
  .addOutput(<enderio:item_end_steel_pickaxe>)
    .addTool(<ore:artisansLens>, 32)
  .create();

              RecipeBuilder.get("mage")
  .setShaped([
  [<ore:ingotEndSteel>, <ore:ingotEndSteel>, <ore:ingotEndSteel>, <ore:ingotEndSteel>, null], 
  [<ore:ingotEndSteel>, <ore:ingotEndSteel>, <ore:ingotEndSteel>, <ore:ingotEndSteel>, null], 
  [<ore:ingotEndSteel>, <ore:ingotEndSteel>, <ore:ingotEndSteel>, null, null], 
  [null, null, <ore:ingotEndSteel>, null, null], 
  [null, null, <ore:ingotEndSteel>, null, null]])
  .setFluid(<liquid:xpjuice> * 1500)
  .addOutput(<enderio:item_end_steel_axe>)
    .addTool(<ore:artisansLens>, 32)
  .create();

          RecipeBuilder.get("mage")
  .setShaped([
  [null, null, <ore:ingotEndSteel>, <ore:ingotEndSteel>, <ore:ingotEndSteel>], 
  [null, <ore:ingotEndSteel>, null, null, <natura:materials:7>], 
  [<ore:ingotEndSteel>, null, null, <natura:materials:7>, null], 
  [<ore:ingotEndSteel>, null, <natura:materials:7>, null, null], 
  [<ore:ingotEndSteel>, <natura:materials:7>, null, null, null]])
  .setFluid(<liquid:xpjuice> * 1500)
  .addOutput(<enderio:item_end_steel_bow>)
    .addTool(<ore:artisansLens>, 32)
  .create();

            RecipeBuilder.get("mage")
  .setShaped([
  [null, null, null, null, <ore:ingotEndSteel>], 
  [null, null, null, <ore:ingotEndSteel>, null], 
  [null, <ore:ingotEndSteel>, <ore:ingotEndSteel>, null, null], 
  [null, <ore:ingotEndSteel>, <ore:ingotEndSteel>, null, null], 
  [<ore:ingotEndSteel>, null, null, null, null]])
  .setFluid(<liquid:xpjuice> * 1500)
  .addOutput(<enderio:item_end_steel_sword>)
    .addTool(<ore:artisansLens>, 32)
  .create();

            RecipeBuilder.get("mage")
  .setShaped([
  [<toughasnails:tan_icon>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <toughasnails:tan_icon>], 
  [<contenttweaker:infinity_plate>, <better_diving:wiring_kit>, <ore:skullZombieController>, <better_diving:wiring_kit>, <contenttweaker:infinity_plate>], 
  [<contenttweaker:infinity_plate>, <ore:toolHoe>, <ore:itemMachineChassi>, <thermalfoundation:tool.shears_diamond>, <contenttweaker:infinity_plate>], 
  [<contenttweaker:infinity_plate>, <ore:gearVibrant>, <ore:itemVibrantCrystal>, <ore:gearVibrant>, <contenttweaker:infinity_plate>], 
  [<toughasnails:tan_icon>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:xpjuice> * 1500)
  .addOutput(<enderio:block_farm_station>)
    .addTool(<ore:artisansLens>, 32)
  .create();

            RecipeBuilder.get("mage")
  .setShaped([
  [<toughasnails:tan_icon>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <toughasnails:tan_icon>], 
  [<contenttweaker:infinity_plate>, <better_diving:wiring_kit>, <ore:skullZombieController>, <better_diving:wiring_kit>, <contenttweaker:infinity_plate>], 
  [<contenttweaker:infinity_plate>, <enderio:item_broken_spawner>, <ore:itemMachineChassi>, <enderio:item_broken_spawner>, <contenttweaker:infinity_plate>], 
  [<contenttweaker:infinity_plate>, <ore:gearDark>, <ore:itemPrecientCrystal>, <ore:gearDark>, <contenttweaker:infinity_plate>], 
  [<toughasnails:tan_icon>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:xpjuice> * 1500)
  .addOutput(<enderio:block_powered_spawner>)
    .addTool(<ore:artisansLens>, 32)
  .create();


                                   RecipeBuilder.get("mage")
  .setShaped([
  [<ore:itemPulsatingCrystal>, <ore:itemPulsatingCrystal>, <ore:itemPulsatingCrystal>, null, null], 
  [<enderio:item_power_conduit:2>, <enderio:item_power_conduit:2>, <enderio:item_power_conduit:2>, null, null], 
  [<ore:itemPulsatingCrystal>, <ore:itemPulsatingCrystal>, <ore:itemPulsatingCrystal>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:xpjuice> * 1000)
  .addOutput(<thermaldynamics:duct_0:5> * 2)
    .addTool(<ore:artisansLens>, 18)
  .create();