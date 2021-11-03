#packmode artisansimple
import mods.artisanworktables.builder.RecipeBuilder;

//  Shapeless ======================================================================================================================
RecipeBuilder.get("basic")
  .setShapeless([<embers:blend_caminite>, <embers:blend_caminite>])
  .addOutput(<embers:plate_caminite_raw>)
    .create();

RecipeBuilder.get("basic")
  .setShapeless([<contenttweaker:infinity_plate>, <contenttweaker:infinity_plate>])
  .addOutput(<enderio:item_material:71>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<minecraft:coal:1>])
  .addOutput(<thermalfoundation:material:769>)
    .create();

RecipeBuilder.get("basic")
  .setShapeless([<ore:gemDiamond>, <ore:gemDiamond>, <ore:gemDiamond>, <ore:gemDiamond>])
  .addOutput(<contenttweaker:diamond_chunk>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<ore:gemEmerald>, <ore:gemEmerald>, <ore:gemEmerald>, <ore:gemEmerald>])
  .addOutput(<contenttweaker:emerald_chunk>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<contenttweaker:omega_gem>, <contenttweaker:omega_gem>])
  .addOutput(<contenttweaker:omega_plate>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<contenttweaker:infinity_gem>, <contenttweaker:infinity_gem>])
  .addOutput(<contenttweaker:infinity_plate>)
    .create();

RecipeBuilder.get("basic")
  .setShapeless([<ore:plateSteel>, <ore:plateSteel>])
  .addOutput(<immersiveengineering:material:2> * 4)
    .create();

    RecipeBuilder.get("basic")
  .setShapeless([<ore:stickIron>])
  .addOutput(<toughasnails:tan_icon> * 2)
    .create();

RecipeBuilder.get("basic")
  .setShapeless([<ore:ingotIron>, <ore:ingotIron>])
  .addOutput(<thermalfoundation:material:32>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<ore:ingotGold>, <ore:ingotGold>])
  .addOutput(<thermalfoundation:material:33>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<ore:ingotCopper>, <ore:ingotCopper>])
  .addOutput(<thermalfoundation:material:320>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<ore:ingotTin>, <ore:ingotTin>])
  .addOutput(<thermalfoundation:material:321>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<ore:ingotSilver>, <ore:ingotSilver>])
  .addOutput(<thermalfoundation:material:322>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<ore:ingotLead>, <ore:ingotLead>])
  .addOutput(<thermalfoundation:material:323>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<ore:ingotAluminum>, <ore:ingotAluminum>])
  .addOutput(<thermalfoundation:material:324>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<ore:ingotNickel>, <ore:ingotNickel>])
  .addOutput(<thermalfoundation:material:325>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<ore:ingotPlatinum>, <ore:ingotPlatinum>])
  .addOutput(<thermalfoundation:material:326>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<ore:ingotIridium>, <ore:ingotIridium>])
  .addOutput(<thermalfoundation:material:327>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<ore:ingotSteel>, <ore:ingotSteel>])
  .addOutput(<thermalfoundation:material:352>)
    .create();

  RecipeBuilder.get("basic")
  .setShapeless([<ore:ingotElectrum>, <ore:ingotElectrum>])
  .addOutput(<thermalfoundation:material:353>)
    .create();

    RecipeBuilder.get("basic")
  .setShapeless([<ore:ingotInvar>, <ore:ingotInvar>])
  .addOutput(<thermalfoundation:material:354>)
    .create();


  RecipeBuilder.get("basic")
  .setShapeless([<ore:ingotBronze>, <ore:ingotBronze>])
  .addOutput(<thermalfoundation:material:355>)
    .create();


  RecipeBuilder.get("basic")
  .setShapeless([<ore:ingotConstantan>, <ore:ingotConstantan>])
  .addOutput(<thermalfoundation:material:356>)
    .create();


  RecipeBuilder.get("basic")
  .setShapeless([<ore:ingotSignalum>, <ore:ingotSignalum>])
  .addOutput(<thermalfoundation:material:357>)
    .create();

    RecipeBuilder.get("basic")
  .setShapeless([<ore:ingotLumium>, <ore:ingotLumium>])
  .addOutput(<thermalfoundation:material:358>)
    .create();

    RecipeBuilder.get("basic")
  .setShapeless([<ore:ingotEnderium>, <ore:ingotEnderium>])
  .addOutput(<thermalfoundation:material:359>)
    .create();


//  Shaped ==============================================================================================================================
            RecipeBuilder.get("basic")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateIron>, <toughasnails:tan_icon>], 
  [<ore:plateIron>, null, <ore:plateIron>], 
  [<toughasnails:tan_icon>, <ore:plateIron>, <toughasnails:tan_icon>]])
  .addOutput(<immersiveengineering:material:8> * 4)
    .create();

              RecipeBuilder.get("basic")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateSteel>, <toughasnails:tan_icon>], 
  [<ore:plateSteel>, null, <ore:plateSteel>], 
  [<toughasnails:tan_icon>, <ore:plateSteel>, <toughasnails:tan_icon>]])
  .addOutput(<immersiveengineering:material:9> * 4)
    .create();

              RecipeBuilder.get("basic")
  .setShaped([
    [null, null, <ore:ingotAluminum>], 
  [null, <ore:ingotAluminum>, null], 
  [<ore:ingotAluminum>, null, null]])
  .addOutput(<immersiveengineering:material:3> * 2)
    .create();

                RecipeBuilder.get("basic")
  .setShaped([
    [null, null, <ore:stickSteel>], 
  [null, <ore:stickSteel>, null], 
  [<ore:stickSteel>, null, null]])
  .addOutput(<mysticalmechanics:axle_iron> * 2)
    .create();


                RecipeBuilder.get("basic")
  .setShaped([
    [null, <ore:plateSteel>, <ore:plateSteel>], 
  [<ore:plateSteel>, <mysticalmechanics:axle_iron>, <ore:plateSteel>], 
  [null, <ore:plateSteel>, null]])
  .addOutput(<immersiveengineering:drillhead>)
      .create();

                RecipeBuilder.get("basic")
  .setShaped([
    [<ore:plateSteel>, <immersiveengineering:material:8>, <ore:plateSteel>], 
  [<immersiveengineering:material:8>, <mysticalmechanics:axle_iron>, <immersiveengineering:material:8>], 
  [<ore:plateSteel>, <immersiveengineering:material:8>, <ore:plateSteel>]])
  .addOutput(<mysticalmechanics:gearbox_frame>)
      .create();

                  RecipeBuilder.get("basic")
  .setShaped([
    [<ore:plateGold>, <immersiveengineering:material:9>, <ore:plateGold>], 
  [<immersiveengineering:material:9>, <mysticalmechanics:axle_iron>, <immersiveengineering:material:9>], 
  [<ore:plateGold>, <immersiveengineering:material:9>, <ore:plateGold>]])
  .addOutput(<mysticalmechanics:mergebox_frame>)
      .create();

                  RecipeBuilder.get("basic")
  .setShaped([
[<ore:ingotAluminum>, <ore:ingotAluminum>, <ore:ingotAluminum>], 
  [<ore:ingotAluminum>, <ore:blockGlassColorless>, <ore:ingotAluminum>], 
  [<ore:ingotAluminum>, <ore:ingotAluminum>, <ore:ingotAluminum>]])
  .addOutput(<magneticraft:steam_boiler>)
      .create();



                  RecipeBuilder.get("basic")
  .setShaped([
    [<ore:dustRedstone>, <ore:gearCopper>, null], 
  [<ore:gearIron>, <ore:dustRedstone>, null], 
  [null, null, null]])
  .addOutput(<embers:winding_gears>)
    .create();

            RecipeBuilder.get("basic")
  .setShaped([
  [<embers:pipe>, null, null, null, <embers:pipe>], 
  [<embers:pipe>, <ore:blockGlassColorless>, <embers:block_tank>, <ore:blockGlassColorless>, <embers:item_pipe>], 
  [<embers:pipe>, <ore:blockGlassColorless>, <embers:winding_gears>, <ore:blockGlassColorless>, <embers:item_pipe>], 
  [<embers:stairs_caminite_brick>, <ore:blockGlassColorless>, <minecraft:furnace>, <ore:blockGlassColorless>, <embers:stairs_caminite_brick>], 
  [<embers:block_caminite_brick>, <embers:block_caminite_brick>, <embers:block_caminite_brick>, <embers:block_caminite_brick>, <embers:block_caminite_brick>]])
  .addOutput(<embers:steam_engine>)
      .create();

              RecipeBuilder.get("basic")
  .setShaped([
  [<ore:ingotSteel>, <immersiveengineering:material:8>, <ore:ingotSteel>], 
  [<immersiveengineering:material:8>, <embers:winding_gears>, <immersiveengineering:material:8>], 
  [<ore:ingotSteel>, <immersiveengineering:material:8>, <ore:ingotSteel>]])
  .addOutput(<embers:mech_core>)
      .create();

                RecipeBuilder.get("basic")
  .setShaped([
  [<embers:block_caminite_brick>, <embers:block_caminite_brick>, <embers:block_caminite_brick>], 
  [<immersiveengineering:material:8>, <embers:winding_gears>, <immersiveengineering:material:8>], 
  [<ore:ingotSteel>, <immersiveengineering:material:8>, <ore:ingotSteel>]])
  .addOutput(<embers:mech_actuator>)
      .create();

                  RecipeBuilder.get("basic")
  .setShaped([
  [<embers:pipe>, <ore:ingotSteel>, <ore:ingotSteel>], 
  [<immersiveengineering:material:8>, <embers:winding_gears>, <embers:pump>], 
  [<embers:stairs_caminite_brick>, <embers:block_caminite_brick>, <ore:blockHopper>]])
  .addOutput(<embers:mechanical_pump>)
      .create();

                  RecipeBuilder.get("basic")
  .setShaped([
[null, null, null], 
  [<ore:stickAluminum>, <ore:stickAluminum>, <ore:stickAluminum>], 
  [<ore:slabTreatedWood>, <ore:slabTreatedWood>, <ore:slabTreatedWood>]])
  .addOutput(<underwaterrails:basic_underwater_rail> * 8)
      .create();

                    RecipeBuilder.get("basic")
  .setShaped([
[null, null, null], 
  [<ore:plateLead>, <embers:pump>, <ore:plateLead>], 
  [<ore:plateLead>, <extratan:tempered_glass_block>, <ore:plateLead>], 
  [<ore:plateLead>, <ore:plateLead>, <ore:plateLead>]])
  .addOutput(<immersiveengineering:toolupgrade>)
      .create();

                    RecipeBuilder.get("basic")
  .setShaped([
[null, null, null], 
  [<ore:plateSignalum>, <embers:pump>, <ore:plateSignalum>], 
  [<ore:plateSignalum>, <extratan:tempered_glass_block>, <ore:plateSignalum>], 
  [<ore:plateSignalum>, <ore:plateSignalum>, <ore:plateSignalum>]])
  .addOutput(<immersiveengineering:toolupgrade:3>)
      .create();

                    RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:fenceTreatedWood>, null, null, null], 
  [<ore:stickTreatedWood>, <ore:fenceTreatedWood>, <ore:stickTreatedWood>, null, null], 
  [null, <ore:fenceTreatedWood>, null, null, null], 
  [<ore:slabCobblestone>, <ore:slabCobblestone>, <ore:slabCobblestone>, null, null], 
  [null, null, null, null, null]])
  .addOutput(<minecraft:armor_stand>)
      .create();

                    RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotIron>, null], 
  [<ore:ingotIron>, <ore:ingotIron>, <ore:ingotIron>], 
  [null, <ore:ingotIron>, null]])
  .addOutput(<mysticalmechanics:gear_iron>)
      .create();

                      RecipeBuilder.get("basic")
  .setShaped([
[<ore:plateBronze>, null, null, null, <ore:plateBronze>], 
  [<ore:plateBronze>, null, null, null, <ore:plateBronze>], 
  [<ore:plateBronze>, null, null, null, <ore:plateBronze>], 
  [<ore:plateBronze>, null, null, null, <ore:plateBronze>], 
  [null, <ore:plateBronze>, <fluidfunnel:funnel>, <ore:plateBronze>, null]])
  .addOutput(<morebuckets:bronze_bucket>)
      .create();

                      RecipeBuilder.get("basic")
  .setShaped([
[<ore:plateSteel>, null, null, null, <ore:plateSteel>], 
  [<ore:plateSteel>, null, null, null, <ore:plateSteel>], 
  [<ore:plateSteel>, null, null, null, <ore:plateSteel>], 
  [<ore:plateSteel>, null, null, null, <ore:plateSteel>], 
  [null, <ore:plateSteel>, <fluidfunnel:funnel>, <ore:plateSteel>, null]])
  .addOutput(<morebuckets:steel_bucket>)
      .create();

                        RecipeBuilder.get("basic")
  .setShaped([
[<ore:plateSilver>, null, null, null, <ore:plateSilver>], 
  [<ore:plateSilver>, null, null, null, <ore:plateSilver>], 
  [<ore:plateSilver>, null, null, null, <ore:plateSilver>], 
  [<ore:plateSilver>, null, null, null, <ore:plateSilver>], 
  [null, <ore:plateSilver>, <fluidfunnel:funnel>, <ore:plateSilver>, null]])
  .addOutput(<morebuckets:silver_bucket>)
      .create();

                        RecipeBuilder.get("basic")
  .setShaped([
[<ore:gemQuartz>, null, null, null, <ore:gemQuartz>], 
  [<ore:gemQuartz>, null, null, null, <ore:gemQuartz>], 
  [<ore:gemQuartz>, null, null, null, <ore:gemQuartz>], 
  [<ore:gemQuartz>, null, null, null, <ore:gemQuartz>], 
  [null, <ore:gemQuartz>, <fluidfunnel:funnel>, <ore:gemQuartz>, null]])
  .addOutput(<morebuckets:quartz_bucket>)
      .create();

                        RecipeBuilder.get("basic")
  .setShaped([
[<ore:obsidian>, null, null, null, <ore:obsidian>], 
  [<ore:obsidian>, null, null, null, <ore:obsidian>], 
  [<ore:obsidian>, null, null, null, <ore:obsidian>], 
  [<ore:obsidian>, null, null, null, <ore:obsidian>], 
  [null, <ore:obsidian>, <fluidfunnel:funnel>, <ore:obsidian>, null]])
  .addOutput(<morebuckets:obsidian_bucket>)
      .create();

                        RecipeBuilder.get("basic")
  .setShaped([
[<ore:plateGold>, null, null, null, <ore:plateGold>], 
  [<ore:plateGold>, null, null, null, <ore:plateGold>], 
  [<ore:plateGold>, null, null, null, <ore:plateGold>], 
  [<ore:plateGold>, null, null, null, <ore:plateGold>], 
  [null, <ore:plateGold>, <fluidfunnel:funnel>, <ore:plateGold>, null]])
  .addOutput(<morebuckets:golden_bucket>)
      .create();

                        RecipeBuilder.get("basic")
  .setShaped([
[<ore:plateAluminum>, null, <ore:plateAluminum>], 
  [<ore:plateAluminum>, null, <ore:plateAluminum>], 
  [null, <ore:plateAluminum>, null]])
  .addOutput(<morebuckets:aluminum_bucket>)
      .create();

                        RecipeBuilder.get("basic")
  .setShaped([
 [<ore:plateCopper>, null, <ore:plateCopper>], 
  [<ore:plateCopper>, null, <ore:plateCopper>], 
  [null, <ore:plateCopper>, null]])
  .addOutput(<morebuckets:copper_bucket>)
      .create();

                        RecipeBuilder.get("basic")
  .setShaped([
[<ore:plateTin>, null, <ore:plateTin>], 
  [<ore:plateTin>, null, <ore:plateTin>], 
  [null, <ore:plateTin>, null]])
  .addOutput(<morebuckets:tin_bucket>)
      .create();

                        RecipeBuilder.get("basic")
  .setShaped([
[<ore:gemEmerald>, null, null, null, <ore:gemEmerald>], 
  [<ore:gemEmerald>, null, null, null, <ore:gemEmerald>], 
  [<ore:gemEmerald>, null, null, null, <ore:gemEmerald>], 
  [<ore:gemEmerald>, null, null, null, <ore:gemEmerald>], 
  [null, <ore:gemEmerald>, <fluidfunnel:funnel>, <ore:gemEmerald>, null]])
  .addOutput(<morebuckets:emerald_bucket>)
      .create();

                        RecipeBuilder.get("basic")
  .setShaped([
[<ore:gemDiamond>, null, null, null, <ore:gemDiamond>], 
  [<ore:gemDiamond>, null, null, null, <ore:gemDiamond>], 
  [<ore:gemDiamond>, null, null, null, <ore:gemDiamond>], 
  [<ore:gemDiamond>, null, null, null, <ore:gemDiamond>], 
  [null, <ore:gemDiamond>, <fluidfunnel:funnel>, <ore:gemDiamond>, null]])
  .addOutput(<morebuckets:diamond_bucket>)
      .create();

                        RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotIron>, null], 
  [<ore:ingotIron>, <ore:ingotIron>, <ore:ingotIron>], 
  [null, <ore:ingotIron>, null]])
  .addOutput(<thermalfoundation:material:24>)
    .create();

                        RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotGold>, null], 
  [<ore:ingotGold>, <ore:ingotGold>, <ore:ingotGold>], 
  [null, <ore:ingotGold>, null]])
  .addOutput(<thermalfoundation:material:25>)
    .create();

                        RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:gemEmerald>, null], 
  [<ore:gemEmerald>, <ore:gemEmerald>, <ore:gemEmerald>], 
  [null, <ore:gemEmerald>, null]])
  .addOutput(<thermalfoundation:material:27>)
    .create();

                          RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:gemDiamond>, null], 
  [<ore:gemDiamond>, <ore:gemDiamond>, <ore:gemDiamond>], 
  [null, <ore:gemDiamond>, null]])
  .addOutput(<thermalfoundation:material:26>)
    .create();

                        RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotCopper>, null], 
  [<ore:ingotCopper>, <ore:ingotCopper>, <ore:ingotCopper>], 
  [null, <ore:ingotCopper>, null]])
  .addOutput(<thermalfoundation:material:256>)
    .create();

                        RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotTin>, null], 
  [<ore:ingotTin>, <ore:ingotTin>, <ore:ingotTin>], 
  [null, <ore:ingotTin>, null]])
  .addOutput(<thermalfoundation:material:257>)
    .create();

                        RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotSilver>, null], 
  [<ore:ingotSilver>, <ore:ingotSilver>, <ore:ingotSilver>], 
  [null, <ore:ingotSilver>, null]])
  .addOutput(<thermalfoundation:material:258>)
    .create();

                          RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotLead>, null], 
  [<ore:ingotLead>, <ore:ingotLead>, <ore:ingotLead>], 
  [null, <ore:ingotLead>, null]])
  .addOutput(<thermalfoundation:material:259>)
    .create();

                        RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotAluminum>, null], 
  [<ore:ingotAluminum>, <ore:ingotAluminum>, <ore:ingotAluminum>], 
  [null, <ore:ingotAluminum>, null]])
  .addOutput(<thermalfoundation:material:260>)
    .create();

                          RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotNickel>, null], 
  [<ore:ingotNickel>, <ore:ingotNickel>, <ore:ingotNickel>], 
  [null, <ore:ingotNickel>, null]])
  .addOutput(<thermalfoundation:material:261>)
    .create();

                          RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotPlatinum>, null], 
  [<ore:ingotPlatinum>, <ore:ingotPlatinum>, <ore:ingotPlatinum>], 
  [null, <ore:ingotPlatinum>, null]])
  .addOutput(<thermalfoundation:material:262>)
    .create();

                        RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotIridium>, null], 
  [<ore:ingotIridium>, <ore:ingotIridium>, <ore:ingotIridium>], 
  [null, <ore:ingotIridium>, null]])
  .addOutput(<thermalfoundation:material:263>)
    .create();

                          RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotMithril>, null], 
  [<ore:ingotMithril>, <ore:ingotMithril>, <ore:ingotMithril>], 
  [null, <ore:ingotMithril>, null]])
  .addOutput(<thermalfoundation:material:264>)
    .create();

                          RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotSteel>, null], 
  [<ore:ingotSteel>, <ore:ingotSteel>, <ore:ingotSteel>], 
  [null, <ore:ingotSteel>, null]])
  .addOutput(<thermalfoundation:material:288>)
    .create();

                          RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotElectrum>, null], 
  [<ore:ingotElectrum>, <ore:ingotElectrum>, <ore:ingotElectrum>], 
  [null, <ore:ingotElectrum>, null]])
  .addOutput(<thermalfoundation:material:289>)
    .create();

                          RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotInvar>, null], 
  [<ore:ingotInvar>, <ore:ingotInvar>, <ore:ingotInvar>], 
  [null, <ore:ingotInvar>, null]])
  .addOutput(<thermalfoundation:material:290>)
    .create();

                        RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotBronze>, null], 
  [<ore:ingotBronze>, <ore:ingotBronze>, <ore:ingotBronze>], 
  [null, <ore:ingotBronze>, null]])
  .addOutput(<thermalfoundation:material:291>)
    .create();

                          RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotConstantan>, null], 
  [<ore:ingotConstantan>, <ore:ingotConstantan>, <ore:ingotConstantan>], 
  [null, <ore:ingotConstantan>, null]])
  .addOutput(<thermalfoundation:material:292>)
    .create();

                          RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotSignalum>, null], 
  [<ore:ingotSignalum>, <ore:ingotSignalum>, <ore:ingotSignalum>], 
  [null, <ore:ingotSignalum>, null]])
  .addOutput(<thermalfoundation:material:293>)
    .create();

                          RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotLumium>, null], 
  [<ore:ingotLumium>, <ore:ingotLumium>, <ore:ingotLumium>], 
  [null, <ore:ingotLumium>, null]])
  .addOutput(<thermalfoundation:material:294>)
    .create();

                          RecipeBuilder.get("basic")
  .setShaped([
[null, <ore:ingotEnderium>, null], 
  [<ore:ingotEnderium>, <ore:ingotEnderium>, <ore:ingotEnderium>], 
  [null, <ore:ingotEnderium>, null]])
  .addOutput(<thermalfoundation:material:295>)
    .create();

                              RecipeBuilder.get("basic")
  .setShaped([
[null, null, <ore:scaffoldingSteel>, null, null], 
  [null, <ore:scaffoldingSteel>, <immersiveengineering:material:8>, <ore:scaffoldingSteel>, null], 
  [null, <ore:scaffoldingSteel>, <immersiveengineering:material:8>, <ore:scaffoldingSteel>, null], 
  [null, <ore:scaffoldingSteel>, <embers:item_pump>, <ore:scaffoldingSteel>, null], 
  [null, <ore:slabLead>, <thermalfoundation:material:656>, <ore:slabLead>, null]])
    .addOutput(<immersiveengineering:metal_device1:7>.withTag({BlockEntityTag: {dummy: 0, process: 0, active: 0 as byte, ifluxEnergy: 8000, id: "immersiveengineering:sampledrill"}}))
      .create();

                            RecipeBuilder.get("basic")
  .setShaped([
 [null, null, null, null, <magneticraft:pumpjack_drill>], 
  [null, <immersiveengineering:metal_decoration0:4>, <ore:scaffoldingSteel>, <ore:scaffoldingSteel>, <magneticraft:pumpjack_drill>], 
  [<immersiveengineering:metal_decoration0:4>, <immersiveengineering:metal_decoration0:5>, null, <ore:fenceSteel>, <immersiveengineering:metal_device0:5>], 
  [<immersiveengineering:metal_decoration0:3>, <immersiveengineering:metal_decoration0:5>, null, <ore:fenceSteel>, null], 
  [<ore:scaffoldingSteel>, <ore:scaffoldingSteel>, <ore:scaffoldingSteel>, <ore:scaffoldingSteel>, <ore:scaffoldingSteel>]])
    .addOutput(<capsule:capsule:5>.withTag({color: 5544791, size: 7, isReward: 1 as byte, oneUse: 1 as byte, structureName: "config/capsule/rewards/Pumpjack", author: "Your Mom", display: {color: 8072841}, label: "Pumpjack", canRotate: 0 as byte}))
      .create();

                              RecipeBuilder.get("basic")
  .setShaped([
 [<ore:stickSteel>, <ore:stickSteel>, <ore:stickSteel>, null, null], 
  [<ore:stickSteel>, <ore:stickSteel>, <ore:stickSteel>, null, null], 
  [<ore:stickSteel>, <ore:stickSteel>, <ore:stickSteel>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
    .addOutput(<immersiveengineering:metal_decoration1:1> * 2)
      .create();

                              RecipeBuilder.get("basic")
  .setShaped([
[<ore:ingotInvar>, <ore:gearInvar>, <ore:plateInvar>, null, null], 
  [<ore:gearInvar>, <ore:plateInvar>, null, null, null], 
  [<ore:plateInvar>, null, null, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
    .addOutput(<thermalfoundation:material:656>)
      .create();

                              RecipeBuilder.get("basic")
  .setShaped([
[null, null, null, null, null], 
  [null, null, null, null, null], 
  [<ore:ingotLead>, <ore:ingotLead>, <ore:ingotLead>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .addOutput(<immersiveengineering:storage_slab:2> * 2)
    .create();

                              RecipeBuilder.get("basic")
  .setShaped([
 [null, null, null, null, null], 
  [<ore:ingotSteel>, <ore:stickSteel>, <ore:ingotSteel>, null, null], 
  [<ore:ingotSteel>, <ore:stickSteel>, <ore:ingotSteel>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .addOutput(<immersiveengineering:metal_decoration1> * 2)
    .create();

                              RecipeBuilder.get("basic")
  .setShaped([
  [<ore:plateTin>, <ore:plateTin>, <ore:plateTin>, null, null], 
  [<ore:ingotConstantan>, <ore:ingotConstantan>, <ore:ingotConstantan>, null, null], 
  [<ore:plateTin>, <ore:plateTin>, <ore:plateTin>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
    .addOutput(<immersiveengineering:metal_decoration0:4>)
        .create(); 

                                RecipeBuilder.get("basic")
  .setShaped([
  [<ore:plateLead>, <ore:plateLead>, <ore:plateLead>, null, null], 
  [<ore:ingotSteel>, <ore:ingotSteel>, <ore:ingotSteel>, null, null], 
  [<ore:plateLead>, <ore:plateLead>, <ore:plateLead>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
    .addOutput(<immersiveengineering:metal_decoration0:5>)
        .create();

                                RecipeBuilder.get("basic")
  .setShaped([
  [<ore:plateTin>, <ore:plateTin>, <ore:plateTin>, null, null], 
  [<immersiveengineering:wirecoil:5>, <immersiveengineering:wirecoil:5>, <immersiveengineering:wirecoil:5>, null, null], 
  [<ore:plateTin>, <ore:plateTin>, <ore:plateTin>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
    .addOutput(<immersiveengineering:metal_decoration0:3>)
        .create();

                                  RecipeBuilder.get("basic")
  .setShaped([
 [<embers:pipe>, <ore:plateInvar>, null, null, null], 
  [<ore:plateInvar>, null, null, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .addOutput(<magneticraft:pumpjack_drill>)
    .create();

                                    RecipeBuilder.get("basic")
  .setShaped([
 [null, <ore:scaffoldingSteel>, null, null, null], 
  [<embers:pipe>, <embers:pipe>, <embers:pipe>, null, null], 
  [<ore:plateInvar>, <embers:pump>, <ore:plateInvar>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .addOutput(<immersiveengineering:metal_device0:5>)
    .create();

                                    RecipeBuilder.get("basic")
  .setShaped([
[<ore:plateInvar>, <ore:barsIron>, <ore:plateInvar>, null, null], 
  [<ore:barsIron>, <morebuckets:quartz_bucket>, <ore:barsIron>, null, null], 
  [<ore:plateInvar>, <ore:barsIron>, <ore:plateInvar>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .addOutput(<enderio:block_tank>)
    .create();


                                RecipeBuilder.get("basic")
  .setShaped([
   [null, <ore:plateIron>, null], 
  [<ore:plateIron>, null, <ore:plateIron>], 
  [null, <ore:plateIron>, null]])
    .addOutput(<immersiveengineering:sheetmetal:9> * 3)
        .create();

                                RecipeBuilder.get("basic")
  .setShaped([
   [null, <ore:plateCopper>, null], 
  [<ore:plateCopper>, null, <ore:plateCopper>], 
  [null, <ore:plateCopper>, null]])
    .addOutput(<immersiveengineering:sheetmetal:0> * 3)
        .create();

                                  RecipeBuilder.get("basic")
  .setShaped([
   [null, <ore:plateAluminum>, null], 
  [<ore:plateAluminum>, null, <ore:plateAluminum>], 
  [null, <ore:plateAluminum>, null]])
    .addOutput(<immersiveengineering:sheetmetal:1> * 3)
        .create();

                                  RecipeBuilder.get("basic")
  .setShaped([
   [null, <ore:plateLead>, null], 
  [<ore:plateLead>, null, <ore:plateLead>], 
  [null, <ore:plateLead>, null]])
    .addOutput(<immersiveengineering:sheetmetal:2> * 3)
        .create();

                                  RecipeBuilder.get("basic")
  .setShaped([
   [null, <ore:plateSilver>, null], 
  [<ore:plateSilver>, null, <ore:plateSilver>], 
  [null, <ore:plateSilver>, null]])
    .addOutput(<immersiveengineering:sheetmetal:3> * 3)
        .create();

                                  RecipeBuilder.get("basic")
  .setShaped([
   [null, <ore:plateNickel>, null], 
  [<ore:plateNickel>, null, <ore:plateNickel>], 
  [null, <ore:plateNickel>, null]])
    .addOutput(<immersiveengineering:sheetmetal:4> * 3)
        .create();

                                  RecipeBuilder.get("basic")
  .setShaped([
   [null, <ore:plateUranium>, null], 
  [<ore:plateUranium>, null, <ore:plateUranium>], 
  [null, <ore:plateUranium>, null]])
    .addOutput(<immersiveengineering:sheetmetal:5> * 3)
        .create();

                                  RecipeBuilder.get("basic")
  .setShaped([
   [null, <ore:plateConstantan>, null], 
  [<ore:plateConstantan>, null, <ore:plateConstantan>], 
  [null, <ore:plateConstantan>, null]])
    .addOutput(<immersiveengineering:sheetmetal:6> * 3)
        .create();

                                  RecipeBuilder.get("basic")
  .setShaped([
   [null, <ore:plateElectrum>, null], 
  [<ore:plateElectrum>, null, <ore:plateElectrum>], 
  [null, <ore:plateElectrum>, null]])
    .addOutput(<immersiveengineering:sheetmetal:7> * 3)
        .create();

                                  RecipeBuilder.get("basic")
  .setShaped([
   [null, <ore:plateSteel>, null], 
  [<ore:plateSteel>, null, <ore:plateSteel>], 
  [null, <ore:plateSteel>, null]])
    .addOutput(<immersiveengineering:sheetmetal:8> * 3)
        .create();

                                  RecipeBuilder.get("basic")
  .setShaped([
   [null, <ore:plateGold>, null], 
  [<ore:plateGold>, null, <ore:plateGold>], 
  [null, <ore:plateGold>, null]])
    .addOutput(<immersiveengineering:sheetmetal:10>)
        .create();

                                    RecipeBuilder.get("basic")
  .setShaped([
   [<ore:blockGlassColorless>, <ore:plateIron>, <ore:blockGlassColorless>], 
  [<ore:plateIron>, null, <ore:plateIron>], 
  [<ore:blockGlassColorless>, <ore:plateIron>, <ore:blockGlassColorless>]])
  .addOutput(<immersiveengineering:metal_device1:6> * 4)
    .create();

                                    RecipeBuilder.get("basic")
  .setShaped([
   [<ore:plateLead>, <ore:slabLead>, <ore:plateLead>], 
  [<ore:slabLead>, null, <ore:slabLead>], 
  [<ore:plateLead>, <ore:slabLead>, <ore:plateLead>]])
  .addOutput(<immersiveengineering:metal_decoration0:7> * 3)
    .create();

                                      RecipeBuilder.get("basic")
  .setShaped([
   [<ore:plateLead>, <ore:slabSheetmetalCopper>, <ore:plateLead>], 
  [<ore:slabSheetmetalCopper>, null, <ore:slabSheetmetalCopper>], 
  [<ore:plateLead>, <ore:slabSheetmetalCopper>, <ore:plateLead>]])
  .addOutput(<immersiveengineering:metal_decoration0:6> * 2)
    .create();

                                      RecipeBuilder.get("basic")
  .setShaped([
 [null, null, null], 
  [<ore:ingotIron>, <ore:ingotIron>, <ore:ingotIron>], 
  [<ore:ingotIron>, <ore:ingotIron>, <ore:ingotIron>]])
  .addOutput(<minecraft:iron_bars> * 6)
    .create();

                                        RecipeBuilder.get("basic")
  .setShaped([
 [null, null, null], 
  [<enderio:item_alloy_ingot:9>, <enderio:item_alloy_ingot:9>, <enderio:item_alloy_ingot:9>], 
  [<enderio:item_alloy_ingot:9>, <enderio:item_alloy_ingot:9>, <enderio:item_alloy_ingot:9>]])
  .addOutput(<enderio:block_dark_iron_bars> * 6)
    .create();

                                      RecipeBuilder.get("basic")
  .setShaped([
[<ore:stone>, <ore:stone>, <ore:stone>], 
  [<ore:stone>, <ore:gearIron>, <ore:blockHopper>], 
  [<ore:stone>, <ore:stone>, <ore:stone>]])
  .addOutput(<minecraft:dispenser>)
    .create();

                                      RecipeBuilder.get("basic")
  .setShaped([
[<ore:plateSilver>, <ore:plateSilver>, <ore:plateSilver>], 
  [<ore:plateSilver>, <extratan:tempered_glass_block>, <ore:plateSilver>], 
  [<ore:plateSilver>, <ore:plateSilver>, <ore:plateSilver>]])
  .addOutput(<simplyjetpacks:metaitemmods:20>)
    .create();

                                      RecipeBuilder.get("basic")
  .setShaped([
 [null, <ore:gearSteel>, null], 
  [<ore:gearSteel>, <ore:plateSteel>, <ore:gearSteel>], 
  [null, <ore:gearSteel>, null]])
  .addOutput(<thermalfoundation:material:657>)
    .create();

                                      RecipeBuilder.get("basic")
  .setShaped([
[<ore:plateLumium>, <ore:plateLumium>, <ore:plateLumium>], 
  [<ore:plateLumium>, null, <ore:plateLumium>], 
  [<ore:plateLumium>, <ore:plateLumium>, <ore:plateLumium>]])
  .addOutput(<thermalexpansion:cache>)
    .create();

                                      RecipeBuilder.get("basic")
  .setShaped([
[<ore:plateLumium>, <ore:plateLumium>, <ore:plateLumium>], 
  [<ore:plateLumium>, <minecraft:glass>, <ore:plateLumium>], 
  [<ore:plateLumium>, <ore:plateLumium>, <ore:plateLumium>]])
  .addOutput(<thermalexpansion:tank>)
    .create();

                                        RecipeBuilder.get("basic")
  .setShaped([
[null, null, <ore:ingotConstructionAlloy>], 
  [null, <ore:ingotConstructionAlloy>, null], 
  [<ore:ingotConstructionAlloy>, null, null]])
  .addOutput(<enderio:item_material:69> * 2)
    .create();

                                        RecipeBuilder.get("basic")
  .setShaped([
[null, null, <ore:ingotLead>, null, null], 
  [null, <ore:ingotLead>, <minecraft:piston>, <ore:ingotLead>, null], 
  [null, <ore:ingotLead>, null, <ore:ingotLead>, null], 
  [null, <ore:ingotLead>, <minecraft:piston>, <ore:ingotLead>, null], 
  [<ore:ingotLead>, <ore:ingotLead>, <ore:ingotLead>, <ore:ingotLead>, <ore:ingotLead>]])
  .addOutput(<intimepresence:steamhammer>)
    .create();

                                        RecipeBuilder.get("basic")
  .setShaped([
  [<ore:slabSheetmetalSteel>, <ore:slabSheetmetalSteel>, null], 
  [<ore:slabSheetmetalSteel>, <ore:slabSheetmetalSteel>, null], 
  [null, null, null]])
  .addOutput(<immersiveengineering:mold>)
    .create();

                                        RecipeBuilder.get("basic")
  .setShaped([
  [null, <ore:slabSheetmetalSteel>, null], 
  [<ore:slabSheetmetalSteel>, null, <ore:slabSheetmetalSteel>], 
  [null, <ore:slabSheetmetalSteel>, null]])
  .addOutput(<immersiveengineering:mold:1>)
    .create();

                                          RecipeBuilder.get("basic")
  .setShaped([
  [null, null, <ore:slabSheetmetalSteel>], 
  [null, <ore:slabSheetmetalSteel>, null], 
  [<ore:slabSheetmetalSteel>, null, null]])
  .addOutput(<immersiveengineering:mold:2>)
    .create();

                                          RecipeBuilder.get("basic")
  .setShaped([
  [null, null, <ore:slabSheetmetalSteel>], 
  [<ore:slabSheetmetalSteel>, null, null], 
  [null, null, <ore:slabSheetmetalSteel>]])
  .addOutput(<immersiveengineering:mold:4>)
    .create();

                                          RecipeBuilder.get("basic")
  .setShaped([
  [null, <ore:ingotEnergeticAlloy>, null], 
  [<ore:ingotEnergeticAlloy>, <contenttweaker:infinity_plate>, <ore:ingotEnergeticAlloy>], 
  [null, <ore:ingotEnergeticAlloy>, null]])
  .addOutput(<enderio:item_material:12>)
    .create();

                                          RecipeBuilder.get("basic")
  .setShaped([
  [null, <enderio:item_alloy_ingot:2>, null], 
  [<enderio:item_alloy_ingot:2>, <contenttweaker:infinity_plate>, <enderio:item_alloy_ingot:2>], 
  [null, <enderio:item_alloy_ingot:2>, null]])
  .addOutput(<enderio:item_material:13>)
    .create();

                                            RecipeBuilder.get("basic")
  .setShaped([
  [null, <enderio:item_alloy_ingot:6>, null], 
  [<enderio:item_alloy_ingot:6>, <contenttweaker:infinity_plate>, <enderio:item_alloy_ingot:6>], 
  [null, <enderio:item_alloy_ingot:6>, null]])
  .addOutput(<enderio:item_material:73>)
    .create();

                                            RecipeBuilder.get("basic")
  .setShaped([
  [null, <contenttweaker:infinity_shard>, null], 
  [<contenttweaker:infinity_shard>, <contenttweaker:infinity_plate>, <contenttweaker:infinity_shard>], 
  [null, <contenttweaker:infinity_shard>, null]])
  .addOutput(<enderio:item_material:11>)
    .create();

                                            RecipeBuilder.get("basic")
  .setShaped([
  [null, null, <ore:stickSteel>], 
  [null, <ore:stickSteel>, <ore:stickSteel>], 
  [<ore:plateIron>, <ore:plateIron>, <ore:stickSteel>]])
  .addOutput(<ezstorage:dolly>)
    .create();

                                            RecipeBuilder.get("basic")
  .setShaped([
  [null, null, <ore:stickSteel>], 
  [null, <ore:stickSteel>, <ore:stickSteel>], 
  [<ore:plateSteel>, <ore:plateGold>, <ore:stickGold>]])
  .addOutput(<ezstorage:dolly_super>)
    .create();

                                            RecipeBuilder.get("basic")
  .setShaped([
  [<ore:plateLead>, <ore:plateLead>, <ore:plateLead>], 
  [<ore:plateLead>, <immersiveengineering:wooden_device0>, <ore:plateLead>], 
  [<ore:plateLead>, <ore:plateLead>, <ore:plateLead>]])
  .addOutput(<thermalexpansion:strongbox>)
    .create();

                                              RecipeBuilder.get("basic")
  .setShaped([
  [<ore:ingotBronze>, <ore:blockGlassColorless>, <ore:ingotBronze>, null, null], 
  [<ore:ingotBronze>, <ore:ingotBronze>, <ore:ingotBronze>, null, null], 
  [<ore:ingotBronze>, <ore:blockGlassColorless>, <ore:ingotBronze>, null, null], 
  [<ore:ingotBronze>, <ore:ingotBronze>, <ore:ingotBronze>, null, null], 
  [<ore:ingotBronze>, <ore:blockGlassColorless>, <ore:ingotBronze>, null, null]])
  .addOutput(<thermaldynamics:duct_64:3> * 16)
    .create();
