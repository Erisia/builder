#packmode artisansimple
import mods.artisanworktables.builder.RecipeBuilder;


//  Shapeless ======================================================================================================================

  RecipeBuilder.get("basic")
  .setShapeless([<minecraft:stone_button>, <minecraft:wooden_slab>, <better_diving:wiring_kit>])
      .addOutput(<cyclicmagic:doorbell_simple>)
    .create();


//  Shaped ==============================================================================================================================

    RecipeBuilder.get("basic")
  .setShaped([
  [<minecraft:brick_block>, <minecraft:brick_block>, null, null, null], 
  [<minecraft:brick_block>, <minecraft:brick_block>, null, null, null], 
  [null, null, <ore:plateElectrum>, null, null], 
  [null, null, null, <ore:plateElectrum>, null], 
  [null, null, null, null, <ore:plateElectrum>]])
    .addOutput(<notenoughwands:building_wand>)
    .create();

    RecipeBuilder.get("basic")
  .setShaped([
  [null, null, null, <minecraft:prismarine_crystals>, <minecraft:prismarine_crystals>], 
  [null, null, null, <minecraft:prismarine_crystals>, <minecraft:prismarine_crystals>], 
  [null, null, <ore:slabWood>, null, null], 
  [null, <ore:slabWood>, null, null, null], 
  [<ore:slabWood>, null, null, null, null]])
    .addOutput(<chisel:chisel_diamond>)
    .create();

      RecipeBuilder.get("basic")
  .setShaped([
  [null, null, null, <minecraft:prismarine_crystals>, <thermalfoundation:material:515>], 
  [null, null, null, <better_diving:wiring_kit>, <minecraft:prismarine_crystals>], 
  [null, null, <ore:slabWood>, null, null], 
  [null, <ore:slabWood>, null, null, null], 
  [<ore:slabWood>, null, null, null, null]])
    .addOutput(<chisel:chisel_hitech>)
    .create();

      RecipeBuilder.get("basic")
  .setShaped([
  [null, null, null, <ore:ingotIron>, <ore:ingotIron>], 
  [null, null, null, <ore:ingotIron>, <ore:ingotIron>], 
  [null, null, <ore:slabWood>, null, null], 
  [null, <ore:slabWood>, null, null, null], 
  [<ore:slabWood>, null, null, null, null]])
    .addOutput(<chisel:chisel_iron>)
    .create();

        RecipeBuilder.get("basic")
  .setShaped([
  [<minecraft:stick>, <ore:slabWood>, <minecraft:stick>],
  [<minecraft:string>, <ore:gearWood>, <minecraft:string>], 
  [<ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>]])
  .addOutput(<waterstrainer:strainer_base>)
    .create();

          RecipeBuilder.get("basic")
  .setShaped([
  [<minecraft:fence>, <magneticraft:crafting:6>, <minecraft:fence>],
  [<magneticraft:box>, <ore:plankTreatedWood>, <ore:plankTreatedWood>], 
  [<ore:slabStone>, <ore:slabStone>, <ore:slabStone>]])
  .addOutput(<magneticraft:sluice_box>)
    .create();

        RecipeBuilder.get("basic")
  .setShaped([
  [<ore:fenceTreatedWood>, <ore:plankTreatedWood>, <ore:fenceTreatedWood>],
  [<ore:plankTreatedWood>, <ore:gearWood>, <ore:plankTreatedWood>], 
  [<ore:fenceTreatedWood>, <ore:plankTreatedWood>, <ore:fenceTreatedWood>]])
  .addOutput(<magneticraft:box>)
    .create();

          RecipeBuilder.get("basic")
  .setShaped([
  [<ore:plankTreatedWood>, <ore:stickTreatedWood>, <ore:plankTreatedWood>], 
  [<ore:plankTreatedWood>, <ore:stickTreatedWood>, <ore:plankTreatedWood>], 
  [<ore:plankTreatedWood>, null, <ore:plankTreatedWood>]])
  .addOutput(<immersiveengineering:wooden_decoration:0> * 4)
    .create();

          RecipeBuilder.get("basic")
  .setShaped([
  [null, null, null], 
  [<ore:plankTreatedWood>, null, null], 
  [<ore:plankTreatedWood>, null, null]])
  .addOutput(<immersiveengineering:material:0> * 4)
    .create();

          RecipeBuilder.get("basic")
  .setShaped([
  [null, <ore:nuggetElectrum>, <ore:nuggetElectrum>], 
  [null, <ore:ingotElectrum>, <ore:nuggetElectrum>], 
  [<ore:plateElectrum>, null, null]])
  .addOutput(<storagedrawers:drawer_key>)
    .create();

            RecipeBuilder.get("basic")
  .setShaped([
  [null, <ore:nuggetElectrum>, <ore:ingotElectrum>], 
  [null, <ore:ingotElectrum>, <ore:nuggetElectrum>], 
  [<ore:plateElectrum>, null, null]])
  .addOutput(<storagedrawers:quantify_key>)
    .create();

            RecipeBuilder.get("basic")
  .setShaped([
  [null, <ore:nuggetElectrum>, <ore:ingotElectrum>], 
  [<ore:nuggetElectrum>, <ore:ingotElectrum>, null], 
  [<ore:plateElectrum>, null, null]])
  .addOutput(<storagedrawers:personal_key>)
    .create();

              RecipeBuilder.get("basic")
  .setShaped([
  [<ore:nuggetElectrum>, <ore:nuggetElectrum>, <ore:ingotElectrum>], 
  [null, <ore:ingotElectrum>, null], 
  [<ore:plateElectrum>, null, null]])
  .addOutput(<storagedrawers:shroud_key>)
    .create();

            RecipeBuilder.get("basic")
  .setShaped([
  [<ore:plankWood>, <ore:plankWood>, <ore:plankWood>], 
  [<ore:plankWood>, null, <ore:plankWood>], 
  [<ore:plankWood>, <ore:plankWood>, <ore:plankWood>]])
  .addOutput(<minecraft:chest>)
    .create();

          RecipeBuilder.get("basic")
  .setShaped([
  [<minecraft:planks:0>, <minecraft:stick>, <minecraft:planks:0>], 
  [<minecraft:planks:0>, <minecraft:stick>, <minecraft:planks:0>], 
  [<minecraft:planks:0>, null, <minecraft:planks:0>]])
  .addOutput(<minecraft:fence:0> * 2)
    .create();

            RecipeBuilder.get("basic")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>], 
  [<ore:plankTreatedWood>, null, null, null, <ore:plankTreatedWood>], 
  [<ore:plankTreatedWood>, null, <minecraft:chest>, null, <ore:plankTreatedWood>], 
  [<ore:plankTreatedWood>, null, null, null, <ore:plankTreatedWood>], 
  [<toughasnails:tan_icon>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>]])
  .addOutput(<storagedrawers:basicdrawers>.withTag({material: "oak"}))
      .create();

            RecipeBuilder.get("basic")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>], 
  [<ore:plankTreatedWood>, null, null, null, <ore:plankTreatedWood>], 
  [<ore:plankTreatedWood>, <minecraft:chest>, null, <minecraft:chest>, <ore:plankTreatedWood>], 
  [<ore:plankTreatedWood>, null, null, null, <ore:plankTreatedWood>], 
  [<toughasnails:tan_icon>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>]])
  .addOutput(<storagedrawers:basicdrawers:1>.withTag({material: "oak"}))
      .create();

            RecipeBuilder.get("basic")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>], 
  [<ore:plankTreatedWood>, null, <minecraft:chest>, null, <ore:plankTreatedWood>], 
  [<ore:plankTreatedWood>, <minecraft:chest>, null, <minecraft:chest>, <ore:plankTreatedWood>], 
  [<ore:plankTreatedWood>, null, <minecraft:chest>, null, <ore:plankTreatedWood>], 
  [<toughasnails:tan_icon>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:plankTreatedWood>, <toughasnails:tan_icon>]])
  .addOutput(<storagedrawers:basicdrawers:2>.withTag({material: "oak"}))
      .create();

            RecipeBuilder.get("basic")
  .setShaped([
  [<toughasnails:tan_icon>, <embers:plate_caminite>, <embers:plate_caminite>, <toughasnails:tan_icon>, null], 
  [<embers:plate_caminite>, null, null, <embers:plate_caminite>, null], 
  [<embers:plate_caminite>, null, null, <embers:plate_caminite>, null], 
  [<toughasnails:tan_icon>, <embers:plate_caminite>, <embers:plate_caminite>, <toughasnails:tan_icon>, null], 
  [null, null, null, null, null]])
  .addOutput(<ezstorage:blank_box>)
        .create();

              RecipeBuilder.get("basic")
  .setShaped([
  [<toughasnails:tan_icon>, <embers:plate_caminite>, <embers:plate_caminite>, <toughasnails:tan_icon>, null], 
  [<embers:plate_caminite>, <better_diving:wiring_kit>, <ore:gearSignalum>, <embers:plate_caminite>, null], 
  [<embers:plate_caminite>, <ore:gearSignalum>, <better_diving:wiring_kit>, <embers:plate_caminite>, null], 
  [<toughasnails:tan_icon>, <embers:plate_caminite>, <embers:plate_caminite>, <toughasnails:tan_icon>, null], 
  [null, null, null, null, null]])
  .addOutput(<ezstorage:storage_core>)
        .create();

                RecipeBuilder.get("basic")
  .setShaped([
  [<toughasnails:tan_icon>, <embers:plate_caminite>, <embers:plate_caminite>, <toughasnails:tan_icon>, null], 
  [<embers:plate_caminite>, <extratan:tempered_glass_block>, <thermalfoundation:material:514>, <embers:plate_caminite>, null], 
  [<embers:plate_caminite>, <thermalfoundation:material:514>, <extratan:tempered_glass_block>, <embers:plate_caminite>, null], 
  [<toughasnails:tan_icon>, <embers:plate_caminite>, <embers:plate_caminite>, <toughasnails:tan_icon>, null], 
  [null, null, null, null, null]])
  .addOutput(<ezstorage:access_terminal>)
        .create();

                  RecipeBuilder.get("basic")
  .setShaped([
 [<toughasnails:tan_icon>, <embers:plate_caminite>, <embers:plate_caminite>, <toughasnails:tan_icon>, null], 
  [<embers:plate_caminite>, <ore:plateSignalum>, <thermalfoundation:material:513>, <embers:plate_caminite>, null], 
  [<embers:plate_caminite>, <thermalfoundation:material:513>, <ore:plateSignalum>, <embers:plate_caminite>, null], 
  [<toughasnails:tan_icon>, <embers:plate_caminite>, <embers:plate_caminite>, <toughasnails:tan_icon>, null], 
  [null, null, null, null, null]])
  .addOutput(<ezstorage:search_box>)
        .create();

                  RecipeBuilder.get("basic")
  .setShaped([
 [<toughasnails:tan_icon>, <embers:plate_caminite>, <embers:plate_caminite>, <toughasnails:tan_icon>, null], 
  [<embers:plate_caminite>, <minecraft:chest>, <minecraft:chest>, <embers:plate_caminite>, null], 
  [<embers:plate_caminite>, <minecraft:chest>, <minecraft:chest>, <embers:plate_caminite>, null], 
  [<toughasnails:tan_icon>, <embers:plate_caminite>, <embers:plate_caminite>, <toughasnails:tan_icon>, null], 
  [null, null, null, null, null]])
  .addOutput(<ezstorage:storage_box>)
        .create();

                    RecipeBuilder.get("basic")
  .setShaped([
 [null, <ore:plankWood>, null], 
  [<ore:plankWood>, <ore:plankWood>, <ore:plankWood>], 
  [null, <ore:plankWood>, null]])
  .addOutput(<thermalfoundation:material:22>)
    .create();

                    RecipeBuilder.get("basic")
  .setShaped([
 [<ore:plankWood>, null, <ore:plankWood>], 
  [null, <ore:plankWood>, null], 
  [<ore:plankWood>, null, <ore:plankWood>]])
  .addOutput(<enderio:item_material:9>)
    .create();



                RecipeBuilder.get("basic")
  .setShaped([
 [<glacidus:underground_planks>, null, <glacidus:underground_planks>], 
  [<glacidus:underground_planks>, null, <glacidus:underground_planks>], 
  [<toughasnails:tan_icon>, <glacidus:underground_planks>, <toughasnails:tan_icon>]])
  .addOutput(<agricraft:water_channel_normal>.withTag({agri_material_meta: 5, agri_material: "chisel:planks-jungle"}) * 2)
        .create();

                RecipeBuilder.get("basic")
  .setShaped([
 [<glacidus:underground_planks>, <glacidus:underground_planks>, <glacidus:underground_planks>], 
  [<glacidus:underground_planks>, null, <glacidus:underground_planks>], 
  [<toughasnails:tan_icon>, <glacidus:underground_planks>, <toughasnails:tan_icon>]])
  .addOutput(<agricraft:water_channel_full>.withTag({agri_material_meta: 5, agri_material: "chisel:planks-jungle"}) * 2)
        .create();

                  RecipeBuilder.get("basic")
  .setShaped([
 [<glacidus:underground_planks>, null, <glacidus:underground_planks>], 
  [<embers:pump>, null, <embers:pump>], 
  [<glacidus:underground_planks>, null, <glacidus:underground_planks>]])
  .addOutput(<agricraft:water_channel_valve>.withTag({agri_material_meta: 5, agri_material: "chisel:planks-jungle"}))
        .create();

                  RecipeBuilder.get("basic")
  .setShaped([
 [<glacidus:underground_planks>, <extratan:tempered_glass_block>, <glacidus:underground_planks>], 
  [<glacidus:underground_planks>, <extratan:tempered_glass_block>, <glacidus:underground_planks>], 
  [<toughasnails:tan_icon>, <glacidus:underground_planks>, <toughasnails:tan_icon>]])
  .addOutput(<agricraft:water_tank>.withTag({agri_material_meta: 5, agri_material: "chisel:planks-jungle"}))
        .create();

                  RecipeBuilder.get("basic")
  .setShaped([
 [<glacidus:underground_planks>, null, <glacidus:underground_planks>], 
  [<glacidus:underground_planks>, <openblocks:tank>, <glacidus:underground_planks>], 
  [<toughasnails:tan_icon>, <glacidus:underground_planks>, <toughasnails:tan_icon>]])
  .addOutput(<agricraft:water_tank>.withTag({agri_material_meta: 5, agri_material: "chisel:planks-jungle"}))
        .create();

                  RecipeBuilder.get("basic")
  .setShaped([
 [<glacidus:underground_stick>, <glacidus:underground_stick>, null], 
  [<glacidus:underground_stick>, <glacidus:underground_stick>, null], 
  [null, null, null]])
  .addOutput(<agricraft:crop_sticks> * 2)
      .create();

                    RecipeBuilder.get("basic")
  .setShaped([
 [null, null, null, <agricraft:crop_sticks>, null], 
  [null, null, <agricraft:crop_sticks>, <agricraft:crop_sticks>, <agricraft:crop_sticks>], 
  [null, null, <glacidus:underground_stick>, <agricraft:crop_sticks>, null], 
  [null, <glacidus:underground_stick>, null, null, null], 
  [<glacidus:underground_stick>, null, null, null, null]])
  .addOutput(<agricraft:rake>)
        .create();

                    RecipeBuilder.get("basic")
  .setShaped([
[null, null, null, <ore:barsIron>, null], 
  [null, null, <ore:barsIron>, <ore:barsIron>, <ore:barsIron>], 
  [null, null, <glacidus:underground_stick>, <ore:barsIron>, null], 
  [null, <glacidus:underground_stick>, null, null, null], 
  [<glacidus:underground_stick>, null, null, null, null]])
  .addOutput(<agricraft:rake:1>)
        .create();

                    RecipeBuilder.get("basic")
  .setShaped([
[null, null, null, null, <glacidus:underground_stick>], 
  [null, null, null, <glacidus:underground_stick>, null], 
  [null, <ore:plateAluminum>, <glacidus:underground_stick>, null, null], 
  [null, <ore:plateAluminum>, <ore:plateAluminum>, null, null], 
  [<ore:plateAluminum>, null, null, null, null]])
  .addOutput(<agricraft:trowel>)
        .create();

                    RecipeBuilder.get("basic")
  .setShaped([
[<ore:plateAluminum>, null, null, null, null], 
  [<ore:plateAluminum>, <ore:plateAluminum>, null, null, null], 
  [null, <ore:plateAluminum>, <glacidus:underground_stick>, null, null], 
  [null, <glacidus:underground_stick>, null, <glacidus:underground_stick>, null], 
  [null, null, <glacidus:underground_stick>, null, <glacidus:underground_stick>]])
  .addOutput(<agricraft:clipper>)
        .create();

                    RecipeBuilder.get("basic")
  .setShaped([
[<glacidus:underground_stick>, <extratan:tempered_glass_block>, <extratan:tempered_glass_block>, <extratan:tempered_glass_block>, <glacidus:underground_stick>], 
  [<glacidus:underground_stick>, <extratan:tempered_glass_block>, <extratan:tempered_glass_block>, <extratan:tempered_glass_block>, <glacidus:underground_stick>], 
  [<glacidus:underground_stick>, <glacidus:underground_log>, <extratan:tempered_glass_block>, <glacidus:underground_log>, <glacidus:underground_stick>], 
  [<glacidus:underground_planks>, <ore:plateAluminum>, <ore:plateAluminum>, <ore:plateAluminum>, <glacidus:underground_planks>], 
  [<glacidus:underground_planks>, <ore:plateAluminum>, <glacidus:underground_log>, <ore:plateAluminum>, <glacidus:underground_planks>]])
  .addOutput(<agricraft:seed_analyzer>)
        .create();

                    RecipeBuilder.get("basic")
  .setShaped([
[<ore:stickWood>, <ore:plankWood>, <ore:stickWood>], 
  [<ore:plankWood>, <ore:stickWood>, <ore:plankWood>], 
  [<ore:stickWood>, <ore:plankWood>, <ore:stickWood>]])
  .addOutput(<cyclicmagic:block_fragile_weak> * 2)
      .create();

                    RecipeBuilder.get("basic")
  .setShaped([
  [<ore:plankWood>, <ore:stickWood>, <ore:plankWood>], 
  [<ore:stickWood>, <ore:stickWood>, <ore:stickWood>], 
  [<ore:plankWood>, <ore:stickWood>, <ore:plankWood>]])
  .addOutput(<cyclicmagic:block_fragile_auto> * 2)
      .create();

                    RecipeBuilder.get("basic")
  .setShaped([
  [<ore:plankWood>, <ore:stickWood>, <ore:plankWood>], 
  [<ore:stickWood>, <ore:plankWood>, <ore:stickWood>], 
  [<ore:plankWood>, <ore:stickWood>, <ore:plankWood>]])
  .addOutput(<cyclicmagic:block_fragile> * 2)
      .create();

                    RecipeBuilder.get("basic")
  .setShaped([
    [<toughasnails:tan_icon>, <embers:plate_caminite>, <embers:plate_caminite>, <embers:plate_caminite>, <toughasnails:tan_icon>], 
  [<embers:plate_caminite>, null, null, null, <embers:plate_caminite>], 
  [<embers:plate_caminite>, null, <minecraft:crafting_table>, null, <embers:plate_caminite>], 
  [<embers:plate_caminite>, null, null, null, <embers:plate_caminite>], 
  [<toughasnails:tan_icon>, <embers:plate_caminite>, <embers:plate_caminite>, <embers:plate_caminite>, <toughasnails:tan_icon>]])
  .addOutput(<ezstorage:crafting_box>)
        .create();


                    RecipeBuilder.get("basic")
  .setShaped([
    [null, null, <ore:blockCheese>], 
  [null, <ore:stickWood>, null], 
  [<ore:stickWood>, null, null]])
  .addOutput(<rats:cheese_stick>)
    .create();


RecipeBuilder.get("basic")
  .setShaped([
    [<natura:nether_planks:1>, null, <natura:nether_planks:1>, null, <natura:nether_planks:1>],
    [null, <natura:nether_planks:1>, <natura:nether_planks:1>, <natura:nether_planks:1>, null],
    [<natura:nether_planks:1>, <natura:nether_planks:1>, <natura:nether_planks:1>, <natura:nether_planks:1>, <natura:nether_planks:1>],
    [null, null, <natura:nether_planks:1>, null, null],
    [null, null, <natura:nether_planks:1>, null, null]])
  .addOutput(<immersiveengineering:material:10>)
        .create();

  RecipeBuilder.get("basic")
  .setShaped([
    [<extratan:tempered_glass_block>, <extratan:tempered_glass_block>, <extratan:tempered_glass_block>], 
  [<ore:dustRedstone>, <minecraft:clock>, <ore:dustRedstone>], 
  [<ore:slabWood>, <ore:slabWood>, <ore:slabWood>]])
  .addOutput(<minecraft:daylight_detector>)
        .create();
