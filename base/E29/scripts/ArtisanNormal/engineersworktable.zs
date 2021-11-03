#packmode artisannormal
import mods.artisanworktables.builder.RecipeBuilder;

//  Shapeless ======================================================================================================================
RecipeBuilder.get("engineer")
  .setShapeless([<ore:plateCopper>])
  .addOutput(<immersiveengineering:material:20>)
  .addTool(<ore:artisansCutters>, 4)
  .create();

  RecipeBuilder.get("engineer")
  .setShapeless([<ore:ingotInvar>, <scannable:module_blank>, <ore:ingotInvar>])
  .addOutput(<thermalfoundation:upgrade>)
  .addTool(<ore:artisansCutters>, 12)
  .create();

    RecipeBuilder.get("engineer")
  .setShapeless([<ore:ingotElectrum>, <contenttweaker:blank_upgradebase>, <ore:ingotElectrum>])
  .addOutput(<thermalfoundation:upgrade:1>)
  .addTool(<ore:artisansCutters>, 12)
  .create();

    RecipeBuilder.get("engineer")
  .setShapeless([<ore:ingotSignalum>, <contenttweaker:blank_upgradebase>, <ore:ingotSignalum>])
  .addOutput(<thermalfoundation:upgrade:2>)
  .addTool(<ore:artisansCutters>, 12)
  .create();

    RecipeBuilder.get("engineer")
  .setShapeless([<ore:ingotEnderium>, <contenttweaker:blank_upgradebase>, <ore:ingotEnderium>])
  .addOutput(<thermalfoundation:upgrade:3>)
  .addTool(<ore:artisansCutters>, 12)
  .create();

    RecipeBuilder.get("engineer")
  .setShapeless([<ore:gearElectrum>, <contenttweaker:blank_upgradebase>, <ore:gearElectrum>])
  .addOutput(<thermalfoundation:upgrade:33>)
  .addTool(<ore:artisansCutters>, 12)
  .create();

    RecipeBuilder.get("engineer")
  .setShapeless([<ore:gearSignalum>, <contenttweaker:blank_upgradebase>, <ore:gearSignalum>])
  .addOutput(<thermalfoundation:upgrade:34>)
  .addTool(<ore:artisansCutters>, 12)
  .create();

  RecipeBuilder.get("engineer")
  .setShapeless([<ore:gearEnderium>, <contenttweaker:blank_upgradebase>, <ore:gearEnderium>])
  .addOutput(<thermalfoundation:upgrade:35>)
  .addTool(<ore:artisansCutters>, 12)
  .create();

  RecipeBuilder.get("engineer")
  .setShapeless([<minecraft:hardened_clay>, <immersiveengineering:wirecoil>, <minecraft:hardened_clay>])
  .addOutput(<immersiveengineering:connector>)
  .addTool(<ore:artisansCutters>, 12)
  .create();

  RecipeBuilder.get("engineer")
  .setShapeless([<minecraft:hardened_clay>, <immersiveengineering:wirecoil:1>, <minecraft:hardened_clay>])
  .addOutput(<immersiveengineering:connector:2>)
  .addTool(<ore:artisansCutters>, 12)
  .create();

  RecipeBuilder.get("engineer")
  .setShapeless([<minecraft:hardened_clay>, <immersiveengineering:wirecoil:2>, <minecraft:hardened_clay>])
  .addOutput(<immersiveengineering:connector:4>)
  .addTool(<ore:artisansCutters>, 12)
  .create();

    RecipeBuilder.get("engineer")
  .setShapeless([<minecraft:hardened_clay>, <immersiveengineering:connector>, <minecraft:hardened_clay>])
  .addOutput(<immersiveengineering:connector:1>)
  .addTool(<ore:artisansCutters>, 12)
  .create();


  RecipeBuilder.get("engineer")
  .setShapeless([<minecraft:hardened_clay>, <immersiveengineering:connector:2>, <minecraft:hardened_clay>])
  .addOutput(<immersiveengineering:connector:3>)
  .addTool(<ore:artisansCutters>, 12)
  .create();


  RecipeBuilder.get("engineer")
  .setShapeless([<minecraft:hardened_clay>, <immersiveengineering:connector:4>, <minecraft:hardened_clay>])
  .addOutput(<immersiveengineering:connector:5>)
  .addTool(<ore:artisansCutters>, 12)
  .create();


  RecipeBuilder.get("engineer")
  .setShapeless([<ore:gearCopper>, <embers:pipe>])
  .addOutput(<embers:pump>)
  .addTool(<ore:artisansCutters>, 8)
  .create();

    RecipeBuilder.get("engineer")
  .setShapeless([<ore:gearCopper>, <minecraft:hopper>])
  .addOutput(<embers:item_dropper>)
  .addTool(<ore:artisansCutters>, 8)
  .create();

  RecipeBuilder.get("engineer")
  .setShapeless([<ore:gearCopper>, <embers:item_pipe>])
  .addOutput(<embers:item_pump>)
  .addTool(<ore:artisansCutters>, 8)
  .create();

RecipeBuilder.get("engineer")
  .setShapeless([<ore:plateElectrum>])
  .addOutput(<immersiveengineering:material:21>)
  .addTool(<ore:artisansCutters>, 4)
  .create();

  RecipeBuilder.get("engineer")
  .setShapeless([<ore:plateAluminum>])
  .addOutput(<immersiveengineering:material:22>)
  .addTool(<ore:artisansCutters>, 4)
  .create();

  RecipeBuilder.get("engineer")
  .setShapeless([<ore:plateSteel>])
  .addOutput(<immersiveengineering:material:23>)
  .addTool(<ore:artisansCutters>, 4)
  .create();

    RecipeBuilder.get("engineer")
  .setShapeless([<ore:wireAluminum>, <immersiveengineering:wirecoil:5>])
  .addOutput(<better_diving:wiring_kit>)
  .addTool(<ore:artisansCutters>, 4)
  .create();

      RecipeBuilder.get("engineer")
  .setShapeless([<ore:gearSilver>, <immersiveengineering:wirecoil:5>, <minecraft:compass>])
  .addOutput(<embers:fluid_gauge>)
  .addTool(<ore:artisansCutters>, 12)
  .create();

        RecipeBuilder.get("engineer")
  .setShapeless([<ore:plateSilver>, <better_diving:wiring_kit>])
  .addOutput(<thermalfoundation:material:514>)
  .addTool(<ore:artisansCutters>, 12)
  .create();

        RecipeBuilder.get("engineer")
  .setShapeless([<ore:ingotIron>, <ore:ingotIron>])
  .addOutput(<immersiveengineering:material:1> * 2)
  .addTool(<ore:artisansCutters>, 4)
  .create();



//  Shaped ==============================================================================================================================
  RecipeBuilder.get("engineer")
  .setShaped([
	[<ore:wireCopper>, <ore:wireCopper>, <ore:wireCopper>], 
  [<ore:wireCopper>, <ore:stickTreatedWood>, <ore:wireCopper>], 
  [<ore:wireCopper>, <ore:wireCopper>, <ore:wireCopper>]])
  .addOutput(<immersiveengineering:metal_decoration0:0>)
  .addTool(<ore:artisansCutters>, 16)
  .create();

  RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:wireElectrum>, <ore:wireElectrum>, <ore:wireElectrum>], 
  [<ore:wireElectrum>, <ore:stickTreatedWood>, <ore:wireElectrum>], 
  [<ore:wireElectrum>, <ore:wireElectrum>, <ore:wireElectrum>]])
  .addOutput(<immersiveengineering:metal_decoration0:1>)
  .addTool(<ore:artisansCutters>, 16)
  .create();

  RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:wireSteel>, <ore:wireSteel>, <ore:wireSteel>], 
  [<ore:wireSteel>, <ore:stickTreatedWood>, <ore:wireSteel>], 
  [<ore:wireSteel>, <ore:wireSteel>, <ore:wireSteel>]])
  .addOutput(<immersiveengineering:metal_decoration0:2>)
  .addTool(<ore:artisansCutters>, 16)
  .create();

    RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:wireCopper>, <ore:wireCopper>, <ore:slabTreatedWood>], 
	[<ore:wireCopper>, <ore:stickTreatedWood>, <ore:wireCopper>], 
	[<ore:slabTreatedWood>, <ore:wireCopper>, <ore:wireCopper>]])
  .addOutput(<immersiveengineering:wirecoil:0>)
  .addTool(<ore:artisansCutters>, 8)
  .create();

    RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:wireElectrum>, <ore:wireElectrum>, <ore:slabTreatedWood>], 
	[<ore:wireElectrum>, <ore:stickTreatedWood>, <ore:wireElectrum>], 
	[<ore:slabTreatedWood>, <ore:wireElectrum>, <ore:wireElectrum>]])
  .addOutput(<immersiveengineering:wirecoil:1>)
  .addTool(<ore:artisansCutters>, 8)
  .create();

      RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:wireSteel>, <ore:wireSteel>, <ore:slabTreatedWood>], 
	[<ore:wireSteel>, <ore:stickTreatedWood>, <ore:wireSteel>], 
	[<ore:slabTreatedWood>, <ore:wireSteel>, <ore:wireSteel>]])
  .addOutput(<immersiveengineering:wirecoil:2>)
  .addTool(<ore:artisansCutters>, 8)
  .create();

      RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:dustRedstone>, <ore:dustRedstone>, <ore:slabTreatedWood>], 
	[<ore:dustRedstone>, <ore:stickTreatedWood>, <ore:dustRedstone>], 
	[<ore:slabTreatedWood>, <ore:dustRedstone>, <ore:dustRedstone>]])
  .addOutput(<immersiveengineering:wirecoil:5>)
  .addTool(<ore:artisansCutters>, 8)
  .create();

      RecipeBuilder.get("engineer")
  .setShaped([
  [null, null, <ore:ingotGold>], 
	[null, <better_diving:wiring_kit>, null], 
	[<ore:ingotGold>, null, null]])
  .addOutput(<thermalfoundation:material:513>)
  .addTool(<ore:artisansCutters>, 8)
  .create();

        RecipeBuilder.get("engineer")
  .setShaped([
  [null, null, <ore:ingotSilver>], 
	[null, <better_diving:wiring_kit>, null], 
	[<ore:ingotSilver>, null, null]])
  .addOutput(<thermalfoundation:material:514>)
  .addTool(<ore:artisansCutters>, 8)
  .create();

        RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:ingotCopper>, null, null], 
	[null, <better_diving:wiring_kit>, null], 
	[null, null, <ore:ingotCopper>]])
  .addOutput(<thermalfoundation:material:515>)
  .addTool(<ore:artisansCutters>, 8)
  .create();

          RecipeBuilder.get("engineer")
  .setShaped([
  [<embers:adhesive>, <embers:adhesive>, <embers:adhesive>], 
	[<ore:blockGlassColorless>, <ore:blockGlassColorless>, <ore:blockGlassColorless>], 
	[<embers:adhesive>, <embers:adhesive>, <embers:adhesive>]])
  .addOutput(<embers:pipe> * 3)
  .addTool(<ore:artisansCutters>, 8)
  .create();

          RecipeBuilder.get("engineer")
  .setShaped([
  [<embers:adhesive>, <embers:adhesive>, <embers:adhesive>], 
  [<ore:plateAluminum>, <ore:plateAluminum>, <ore:plateAluminum>], 
  [<embers:adhesive>, <embers:adhesive>, <embers:adhesive>]])
  .addOutput(<embers:item_pipe> * 2)
  .addTool(<ore:artisansCutters>, 8)
  .create();

          RecipeBuilder.get("engineer")
  .setShaped([
  [null, <embers:block_caminite_brick_slab>, <embers:copper_cell>, <embers:block_caminite_brick_slab>, null], 
  [null, <ore:plateLead>, null, <ore:plateLead>, null], 
  [null, <ore:plateLead>, null, <ore:plateLead>, null], 
  [<ore:gearBronze>, <ore:plateLead>, null, <ore:plateLead>, <ore:gearBronze>], 
  [<embers:stairs_caminite_brick>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick_slab>, <embers:stairs_caminite_brick>]])
  .addOutput(<embers:ember_activator>)
  .addTool(<ore:artisansCutters>, 48)
  .create();

            RecipeBuilder.get("engineer")
  .setShaped([
  [null, <minecraft:redstone_torch>, null], 
  [<embers:plate_caminite>, <ore:gearTin>, <embers:plate_caminite>], 
  [<embers:plate_caminite>, <thermalfoundation:material:514>, <embers:plate_caminite>]])
  .addOutput(<embers:ember_emitter>)
  .addTool(<ore:artisansCutters>, 8)
  .create();

            RecipeBuilder.get("engineer")
    .setShaped([
  [null, <minecraft:redstone_torch>, null], 
  [<embers:plate_caminite>, <ore:gearCopper>, <embers:plate_caminite>], 
  [<embers:plate_caminite>, <thermalfoundation:material:514>, <embers:plate_caminite>]])
  .addOutput(<embers:ember_receiver>)
  .addTool(<ore:artisansCutters>, 16)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

            RecipeBuilder.get("engineer")
  .setShaped([
  [null, <minecraft:repeater>, null], 
  [<ore:blockGlassColorless>, <better_diving:wiring_kit>, <ore:blockGlassColorless>], 
  [<ore:blockGlassColorless>, <ore:plateSilver>, <ore:blockGlassColorless>]])
  .addOutput(<immersiveengineering:connector:13>)
  .addTool(<ore:artisansCutters>, 16)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

              RecipeBuilder.get("engineer")
  .setShaped([
  [<embers:block_caminite_brick>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick>], 
	[<embers:block_caminite_brick_slab>, null, null, null, <embers:block_caminite_brick_slab>], 
	[<embers:block_caminite_brick_slab>, null, <immersiveengineering:metal_decoration0>, null, <embers:block_caminite_brick_slab>], 
	[<embers:block_caminite_brick_slab>, null, null, null, <embers:block_caminite_brick_slab>], 
	[<embers:block_caminite_brick>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick>]])
  .addOutput(<embers:copper_cell>)
  .addTool(<ore:artisansCutters>, 16)
  .create();

            RecipeBuilder.get("engineer")
  .setShaped([
  [null, null, null], 
	[null, <ore:gearCopper>, null], 
	[<embers:stairs_caminite_brick>, <embers:block_caminite_brick_slab>, <embers:stairs_caminite_brick>]])
  .addOutput(<embers:ember_relay>)
  .addTool(<ore:artisansCutters>, 16)
  .create();

              RecipeBuilder.get("engineer")
  .setShaped([
  [<embers:block_caminite_brick>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick>], 
  [<embers:block_caminite_brick_slab>, <immersiveengineering:drillhead>, <embers:winding_gears>, <immersiveengineering:drillhead>, <embers:block_caminite_brick_slab>], 
  [<embers:block_caminite_brick_slab>, null, <minecraft:hopper>, null, <embers:block_caminite_brick_slab>], 
  [<embers:block_caminite_brick_slab>, <immersiveengineering:drillhead>, <embers:winding_gears>, <immersiveengineering:drillhead>, <embers:block_caminite_brick_slab>], 
  [<embers:block_caminite_brick>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick_slab>, <embers:block_caminite_brick>]])
  .addOutput(<embers:ember_bore>)
  .addTool(<ore:artisansCutters>, 128)
  .create();


            RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:magma_shard>, <embers:plate_caminite>, <toughasnails:magma_shard>], 
  [<embers:plate_caminite>, <embers:plate_caminite>, <embers:plate_caminite>], 
  [<toughasnails:magma_shard>, <embers:plate_caminite>, <toughasnails:magma_shard>]])
  .addOutput(<embers:archaic_light>)
  .addTool(<ore:artisansCutters>, 16)
  .addTool(<ore:artisansSolderer>, 32)
  .create();


            RecipeBuilder.get("engineer")
  .setShaped([
    [<modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, null], 
  [<modularmachinery:itemmodularium>, <better_diving:wiring_kit>, <thermalfoundation:material:515>, <modularmachinery:itemmodularium>, null], 
  [<modularmachinery:itemmodularium>, <minecraft:stone_button>, <minecraft:stone_button>, <modularmachinery:itemmodularium>, null], 
  [<modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, null], 
  [null, null, null, null, null]])
  .addOutput(<modularmachinery:blockcontroller>)
  .addTool(<ore:artisansCutters>, 16)
  .addTool(<ore:artisansSolderer>, 32)
  .create();


            RecipeBuilder.get("engineer")
  .setShaped([
  [<modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, null, null], 
  [<modularmachinery:itemmodularium>, <embers:ember_receiver>, <modularmachinery:itemmodularium>, null, null], 
  [<modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .addOutput(<modulardiversity:blockemberinputhatch:5>)
  .addTool(<ore:artisansCutters>, 16)
  .create();


            RecipeBuilder.get("engineer")
  .setShaped([
  [<modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, null, null], 
  [<modularmachinery:itemmodularium>, <embers:winding_gears>, <modularmachinery:itemmodularium>, null, null], 
  [<modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .addOutput(<modulardiversity:blockmystmechinput>)
  .addTool(<ore:artisansCutters>, 16)
  .create();

              RecipeBuilder.get("engineer")
  .setShaped([
  [<modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, null, null], 
  [<embers:winding_gears>, null, <embers:winding_gears>, null, null], 
  [<modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .addOutput(<modulardiversity:blockmystmechoutput>)
  .addTool(<ore:artisansCutters>, 16)
  .create();

            RecipeBuilder.get("engineer")
  .setShaped([
  [<modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, null, null], 
  [<modularmachinery:itemmodularium>, <minecraft:chest>, <modularmachinery:itemmodularium>, null, null], 
  [<modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .addOutput(<modularmachinery:blockinputbus:2>)
  .addTool(<ore:artisansCutters>, 16)
  .create();

            RecipeBuilder.get("engineer")
  .setShaped([
  [<modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, null, null], 
  [<modularmachinery:itemmodularium>, <minecraft:hopper>, <modularmachinery:itemmodularium>, null, null], 
  [<modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .addOutput(<modularmachinery:blockoutputbus:2>)
  .addTool(<ore:artisansCutters>, 16)
  .create();

              RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:plateAluminum>, <embers:pump>, <ore:plateAluminum>], 
  [<ore:plateAluminum>, <immersiveengineering:toolupgrade>, <ore:plateAluminum>], 
  [<ore:plateAluminum>, <ore:plateAluminum>, <ore:plateAluminum>]])
  .addOutput(<better_diving:standard_o2_tank>)
  .addTool(<ore:artisansCutters>, 32)
  .create();

              RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:plateAluminum>, <embers:pump>, <ore:plateAluminum>], 
  [<ore:plateAluminum>, <immersiveengineering:toolupgrade:3>, <ore:plateAluminum>], 
  [<ore:plateAluminum>, <better_diving:reinforced_o2_tank>.anyDamage(), <ore:plateAluminum>]])
  .addOutput(<better_diving:high_capacity_o2_tank>)
  .addTool(<ore:artisansCutters>, 32)
  .create();

                RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:plateAluminum>, <embers:pump>, <ore:plateAluminum>], 
  [<ore:plateAluminum>, <immersiveengineering:toolupgrade>, <ore:plateAluminum>], 
  [<ore:plateAluminum>, <better_diving:standard_o2_tank>.anyDamage(), <ore:plateAluminum>]])
  .addOutput(<better_diving:reinforced_o2_tank>)
  .addTool(<ore:artisansCutters>, 32)
  .create();

                RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateTin>, <ore:plateTin>, <ore:plateTin>, <toughasnails:tan_icon>], 
  [<ore:plateTin>, <minecraft:armor_stand>, <minecraft:chest>, <minecraft:armor_stand>, <ore:plateTin>], 
  [<ore:plateTin>, <minecraft:chest>, <minecraft:stone_button>, <minecraft:chest>, <ore:plateTin>], 
  [<ore:plateTin>, <minecraft:armor_stand>, <minecraft:chest>, <minecraft:armor_stand>, <ore:plateTin>], 
  [<toughasnails:tan_icon>, <ore:plateTin>, <ore:plateTin>, <ore:plateTin>, <toughasnails:tan_icon>]])
  .addOutput(<gearswap:gearswapperiron>)
  .addTool(<ore:artisansCutters>, 32)
  .create();

                RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateLead>, <better_diving:wiring_kit>, <ore:plateLead>, <toughasnails:tan_icon>], 
  [<ore:plateLead>, <ore:blockGlassColorless>, <ore:blockGlassColorless>, <ore:blockGlassColorless>, <ore:plateLead>], 
  [<better_diving:wiring_kit>, <ore:blockGlassColorless>, <thermalfoundation:material:513>, <ore:blockGlassColorless>, <better_diving:wiring_kit>], 
  [<ore:plateLead>, <ore:blockGlassColorless>, <ore:blockGlassColorless>, <ore:blockGlassColorless>, <ore:plateLead>], 
  [<toughasnails:tan_icon>, <ore:plateLead>, <better_diving:wiring_kit>, <ore:plateLead>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 200)
  .addOutput(<cyclicmagic:battery>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

                RecipeBuilder.get("engineer")
  .setShaped([
[null, null, null, null, null], 
  [<ore:blockGlassColorless>, <ore:blockGlassColorless>, <ore:blockGlassColorless>, <ore:blockGlassColorless>, <ore:blockGlassColorless>], 
  [<ore:plateInvar>, <minecraft:hopper>, <ore:gearSilver>, <minecraft:hopper>, <ore:plateInvar>], 
  [<ore:plateInvar>, <better_diving:wiring_kit>, <ore:chest>, <better_diving:wiring_kit>, <ore:plateInvar>], 
  [<ore:plateInvar>, <ore:plateInvar>, <ore:plateInvar>, <ore:plateInvar>, <ore:plateInvar>]])
  .setFluid(<liquid:solder> * 200)
  .addOutput(<chisel:auto_chisel>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

                  RecipeBuilder.get("engineer")
  .setShaped([
[<toughasnails:tan_icon>, <ore:plateAluminum>, <ore:plateAluminum>, <ore:plateAluminum>, <toughasnails:tan_icon>], 
  [<ore:plateAluminum>, <minecraft:stone_button>, <minecraft:hopper>, <minecraft:stone_button>, <ore:plateAluminum>], 
  [<ore:plateAluminum>, <thermalfoundation:material:514>, <better_diving:wiring_kit>, <thermalfoundation:material:514>, <ore:plateAluminum>], 
  [<ore:plateAluminum>, <minecraft:stone_button>, <minecraft:hopper>, <minecraft:stone_button>, <ore:plateAluminum>], 
  [<toughasnails:tan_icon>, <ore:plateAluminum>, <ore:plateAluminum>, <ore:plateAluminum>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 200)
  .addOutput(<storagedrawers:controller>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

                  RecipeBuilder.get("engineer")
  .setShaped([
[<toughasnails:tan_icon>, <ore:plateAluminum>, <ore:plateAluminum>, <ore:plateAluminum>, <toughasnails:tan_icon>], 
  [<ore:plateAluminum>, <minecraft:glass>, <minecraft:hopper>, <minecraft:glass>, <ore:plateAluminum>], 
  [<ore:plateAluminum>, <thermalfoundation:material:513>, <better_diving:wiring_kit>, <thermalfoundation:material:513>, <ore:plateAluminum>], 
  [<ore:plateAluminum>, <minecraft:glass>, <minecraft:hopper>, <minecraft:glass>, <ore:plateAluminum>], 
  [<toughasnails:tan_icon>, <ore:plateAluminum>, <ore:plateAluminum>, <ore:plateAluminum>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 200)
  .addOutput(<storagedrawers:controllerslave>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

                  RecipeBuilder.get("engineer")
  .setShaped([
  [<contenttweaker:wire_solder>, <contenttweaker:wire_solder>, <contenttweaker:wire_solder>], 
  [null, <minecraft:bucket>, null], 
  [<contenttweaker:wire_solder>, <contenttweaker:wire_solder>, <contenttweaker:wire_solder>]])
  .addOutput(<forge:bucketfilled>.withTag({FluidName: "solder", Amount: 1000}))
  .addTool(<ore:artisansSolderer>, 32)
  .create();

                  RecipeBuilder.get("engineer")
  .setShaped([
[null, null, <thermalfoundation:material:515>, null, null], 
  [null, <ore:plateBronze>, <ore:gearSilver>, <ore:plateBronze>, null], 
  [null, null, <minecraft:hardened_clay>, null, null], 
  [null, null, <minecraft:hardened_clay>, null, null], 
  [null, <ore:slabLead>, <minecraft:hardened_clay>, <ore:slabLead>, null]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<immersiveengineering:connector:11>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

                  RecipeBuilder.get("engineer")
  .setShaped([
[<ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:slabSheetmetalCopper>, <ore:plankTreatedWood>, <ore:plankTreatedWood>], 
  [<ore:plateLead>, <ore:dustRedstone>, <ore:dustRedstone>, <ore:dustRedstone>, <ore:plateLead>], 
  [<ore:plateLead>, <better_diving:wiring_kit>, <immersiveengineering:metal_decoration0>, <better_diving:wiring_kit>, <ore:plateLead>], 
  [<ore:plateLead>, <ore:dustRedstone>, <ore:dustRedstone>, <ore:dustRedstone>, <ore:plateLead>], 
  [<ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:slabSheetmetalCopper>, <ore:plankTreatedWood>, <ore:plankTreatedWood>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<immersiveengineering:metal_device0>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

                  RecipeBuilder.get("engineer")
  .setShaped([
[<ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:slabSheetmetalSilver>, <ore:plankTreatedWood>, <ore:plankTreatedWood>], 
  [<ore:plateLead>, <ore:dustRedstone>, <ore:dustRedstone>, <ore:dustRedstone>, <ore:plateLead>], 
  [<ore:plateLead>, <immersiveengineering:metal_decoration0>, <better_diving:wiring_kit>, <immersiveengineering:metal_decoration0>, <ore:plateLead>], 
  [<ore:plateLead>, <ore:dustRedstone>, <ore:dustRedstone>, <ore:dustRedstone>, <ore:plateLead>], 
  [<ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:slabSheetmetalSilver>, <ore:plankTreatedWood>, <ore:plankTreatedWood>]])
  .setFluid(<liquid:solder> * 1000)
  .addOutput(<immersiveengineering:metal_device0:1>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

                    RecipeBuilder.get("engineer")
  .setShaped([
[<ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:slabSheetmetalElectrum>, <ore:plankTreatedWood>, <ore:plankTreatedWood>], 
  [<ore:plateLead>, <ore:dustRedstone>, <ore:dustRedstone>, <ore:dustRedstone>, <ore:plateLead>], 
  [<ore:plateLead>, <immersiveengineering:metal_decoration0:1>, <better_diving:wiring_kit>, <immersiveengineering:metal_decoration0:1>, <ore:plateLead>], 
  [<ore:plateLead>, <ore:dustRedstone>, <ore:dustRedstone>, <ore:dustRedstone>, <ore:plateLead>], 
  [<ore:plankTreatedWood>, <ore:plankTreatedWood>, <ore:slabSheetmetalElectrum>, <ore:plankTreatedWood>, <ore:plankTreatedWood>]])
  .setFluid(<liquid:solder> * 2000)
  .addOutput(<immersiveengineering:metal_device0:2>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

                    RecipeBuilder.get("engineer")
  .setShaped([
[<ore:slabSheetmetalConstantan>, <ore:slabSheetmetalConstantan>, <immersiveengineering:material:9>, <ore:slabSheetmetalConstantan>, <ore:slabSheetmetalConstantan>], 
  [<ore:plateLead>, <ore:dustRedstone>, <ore:dustRedstone>, <ore:dustRedstone>, <ore:plateLead>], 
  [<immersiveengineering:material:9>, <better_diving:wiring_kit>, <immersiveengineering:metal_device0>, <better_diving:wiring_kit>, <immersiveengineering:material:9>], 
  [<ore:plateLead>, <ore:dustRedstone>, <ore:dustRedstone>, <ore:dustRedstone>, <ore:plateLead>], 
  [<ore:stickSteel>, null, null, null, <ore:stickSteel>]])
  .setFluid(<liquid:solder> * 1000)
  .addOutput(<immersivepetroleum:metal_device:1>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

RecipeBuilder.get("engineer")
  .setShaped([
[<ore:stickAluminum>, <ore:plateSilver>, <ore:stickAluminum>], 
  [<ore:plateSilver>, <better_diving:wiring_kit>, <ore:plateSilver>], 
  [<ore:stickAluminum>, <ore:plateSilver>, <ore:stickAluminum>]])
  .addOutput(<thermalexpansion:frame:64>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

RecipeBuilder.get("engineer")
  .setShaped([
[<toughasnails:tan_icon>, <ore:plateLead>, <ore:plateLead>, <toughasnails:tan_icon>, null], 
  [<ore:plateLead>, <thermalfoundation:material:514>, <assistedprogression:item_pipette>, <ore:plateLead>, null], 
  [<ore:plateLead>, <ore:itemEmptyBucket>, <thermalfoundation:material:515>, <ore:plateLead>, null], 
  [<toughasnails:tan_icon>, <ore:plateLead>, <ore:plateLead>, <toughasnails:tan_icon>, null], 
  [null, null, null, null, null]])
  .addOutput(<thermalexpansion:device:3>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

RecipeBuilder.get("engineer")
  .setShaped([
[<toughasnails:tan_icon>, <ore:plateLead>, <ore:plateLead>, <toughasnails:tan_icon>, null], 
  [<ore:plateLead>, <thermalfoundation:material:514>, <fluidfunnel:funnel>, <ore:plateLead>, null], 
  [<ore:plateLead>, <ore:itemEmptyBucket>, <thermalfoundation:material:515>, <ore:plateLead>, null], 
  [<toughasnails:tan_icon>, <ore:plateLead>, <ore:plateLead>, <toughasnails:tan_icon>, null], 
  [null, null, null, null, null]])
  .addOutput(<thermalexpansion:device>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:plateNickel>, <minecraft:comparator>, <minecraft:repeater>, <ore:plateNickel>, null], 
  [<ore:dustRedstone>, <ore:dustRedstone>, <ore:dustRedstone>, <ore:dustRedstone>, null], 
  [<ore:dustRedstone>, <ore:dustRedstone>, <ore:dustRedstone>, <ore:dustRedstone>, null], 
  [<ore:plateNickel>, <minecraft:repeater>, <minecraft:comparator>, <ore:plateNickel>, null], 
  [null, null, null, null, null]])
  .addOutput(<assistedprogression:block_redstone_clock>)
  .addTool(<ore:artisansCutters>, 12)
  .addTool(<ore:artisansSolderer>, 12)
  .create();

RecipeBuilder.get("engineer")
  .setShaped([
   [<modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>], 
  [<modularmachinery:itemmodularium>, <fluidfunnel:funnel>, <modularmachinery:itemmodularium>], 
  [<modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>]])
  .addOutput(<modularmachinery:blockfluidinputhatch:1>)
  .addTool(<ore:artisansCutters>, 12)
  .addTool(<ore:artisansSolderer>, 12)
  .create();

RecipeBuilder.get("engineer")
  .setShaped([
    [<modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>], 
  [<modularmachinery:itemmodularium>, <morebuckets:copper_bucket>, <modularmachinery:itemmodularium>], 
  [<modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>]])
  .addOutput(<modularmachinery:blockfluidinputhatch:2>)
  .addTool(<ore:artisansCutters>, 12)
  .addTool(<ore:artisansSolderer>, 12)
  .create();

RecipeBuilder.get("engineer")
  .setShaped([
     [<modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>], 
  [<modularmachinery:itemmodularium>, <thermalfoundation:material:515>, <modularmachinery:itemmodularium>], 
  [<modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>, <modularmachinery:itemmodularium>]])
  .addOutput(<modularmachinery:blockenergyoutputhatch>)
  .addTool(<ore:artisansCutters>, 12)
  .addTool(<ore:artisansSolderer>, 12)
  .create();

RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:plateSteel>, null, <extratan:tempered_glass_block>, null, <ore:plateSteel>], 
  [<ore:plateSteel>, <extratan:tempered_glass_block>, <modularmachinery:blockcontroller>, <extratan:tempered_glass_block>, <ore:plateSteel>], 
  [<ore:plateSteel>, <extratan:tempered_glass_block>, <minecraft:stone_brick_stairs>, <extratan:tempered_glass_block>, <ore:plateSteel>], 
  [<openblocks:hang_glider>, <embers:caminite_lever>, <immersiveengineering:metal_device0>, <embers:caminite_lever>, <openblocks:hang_glider>], 
  [<simplyjetpacks:metaitemmods:27>, <ore:plateSteel>, <ore:plateSteel>, <ore:plateSteel>, <simplyjetpacks:metaitemmods:27>]])
  .setFluid(<liquid:solder> * 1000)
  .addOutput(<better_diving:seamoth>)
  .addTool(<ore:artisansCutters>, 48)
  .addTool(<ore:artisansSolderer>, 48)
  .create();

RecipeBuilder.get("engineer")
  .setShaped([
  [null, <ore:plateInvar>, null, null, null], 
  [<ore:plateInvar>, <minecraft:flint_and_steel>, <ore:plateInvar>, null, null], 
  [<ore:plateInvar>, <immersiveengineering:material:9>, <ore:plateInvar>, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:solder> * 200)
  .addOutput(<simplyjetpacks:metaitemmods:27>)
  .addTool(<ore:artisansCutters>, 12)
  .addTool(<ore:artisansSolderer>, 12)
  .create();

RecipeBuilder.get("engineer")
  .setShaped([
    [null, <ore:plateAluminum>, null], 
  [<ore:plateAluminum>, <ore:plateAluminum>, <ore:plateAluminum>], 
  [<ore:plateAluminum>, <ore:plateAluminum>, <ore:plateAluminum>]])
  .setFluid(<liquid:solder> * 250)
  .addOutput(<openblocks:hang_glider> * 2)
  .addTool(<ore:artisansCutters>, 12)
  .addTool(<ore:artisansSolderer>, 12)
  .create();

RecipeBuilder.get("engineer")
  .setShaped([
   [<toughasnails:tan_icon>, <ore:plateNickel>, <ore:plateNickel>, <toughasnails:tan_icon>, null], 
	[<ore:plateNickel>, <thermalfoundation:material:515>, <ore:itemBlazeRod>, <ore:plateNickel>, null], 
	[<ore:plateNickel>, <better_diving:wiring_kit>, <thermalfoundation:material:513>, <ore:plateNickel>, null], 
	[<toughasnails:tan_icon>, <ore:plateNickel>, <ore:plateNickel>, <toughasnails:tan_icon>, null], 
	[null, null, null, null, null]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:machine:9>)
  .addTool(<ore:artisansCutters>, 24)
  .addTool(<ore:artisansSolderer>, 24)
  .create();


RecipeBuilder.get("engineer")
  .setShaped([
 [<ore:plateAluminum>, <immersiveengineering:material:9>, <ore:plateAluminum>], 
  [<ore:plateAluminum>, <better_diving:wiring_kit>, <ore:plateAluminum>], 
  [<ore:plateAluminum>, <ore:plateAluminum>, <ore:plateAluminum>]])
  .setFluid(<liquid:solder> * 200)
  .addOutput(<better_diving:power_cell>)
  .addTool(<ore:artisansCutters>, 12)
  .addTool(<ore:artisansSolderer>, 12)
  .create();


RecipeBuilder.get("engineer")
  .setShaped([
 [null, <ore:plateLead>, null, <ore:plateLead>, null], 
  [<ore:plateLead>, <thermalfoundation:material:513>, <ore:plateLead>, <thermalfoundation:material:513>, <ore:plateLead>], 
  [<ore:plateLead>, <better_diving:wiring_kit>, <ore:plateLead>, <better_diving:wiring_kit>, <ore:plateLead>], 
  [<ore:plateLead>, <simplyjetpacks:metaitemmods:21>, <ore:plateLead>, <simplyjetpacks:metaitemmods:21>, <ore:plateLead>], 
  [<ore:plateLead>, <simplyjetpacks:metaitemmods:26>, null, <simplyjetpacks:metaitemmods:26>, <ore:plateLead>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<simplyjetpacks:itemjetpack:10>)
  .addTool(<ore:artisansCutters>, 12)
  .addTool(<ore:artisansSolderer>, 12)
  .create();


RecipeBuilder.get("engineer")
  .setShaped([
	[<toughasnails:tan_icon>, <ore:plateNickel>, <ore:plateNickel>, <toughasnails:tan_icon>, null], 
	[<ore:plateNickel>, <thermalfoundation:material:515>, <fluidfunnel:funnel>, <ore:plateNickel>, null], 
	[<ore:plateNickel>, <better_diving:wiring_kit>, <thermalfoundation:material:513>, <ore:plateNickel>, null], 
	[<toughasnails:tan_icon>, <ore:plateNickel>, <ore:plateNickel>, <toughasnails:tan_icon>, null], 
	[null, null, null, null, null]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:machine:8>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

RecipeBuilder.get("engineer")
  .setShaped([
 [<toughasnails:tan_icon>, <ore:plateNickel>, <ore:plateNickel>, <toughasnails:tan_icon>, null], 
  [<ore:plateNickel>, <thermalfoundation:material:515>, <cookingforblockheads:fridge>, <ore:plateNickel>, null], 
  [<ore:plateNickel>, <better_diving:wiring_kit>, <thermalfoundation:material:513>, <ore:plateNickel>, null], 
  [<toughasnails:tan_icon>, <ore:plateNickel>, <ore:plateNickel>, <toughasnails:tan_icon>, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:machine:14>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

RecipeBuilder.get("engineer")
  .setShaped([
	[<toughasnails:tan_icon>, <ore:plateNickel>, <ore:plateNickel>, <toughasnails:tan_icon>, null], 
	[<ore:plateNickel>, <thermalfoundation:material:515>, <ore:blockMagma>, <ore:plateNickel>, null], 
	[<ore:plateNickel>, <ore:blockMagma>, <thermalfoundation:material:513>, <ore:plateNickel>, null], 
	[<toughasnails:tan_icon>, <ore:plateNickel>, <ore:plateNickel>, <toughasnails:tan_icon>, null], 
	[null, null, null, null, null]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:machine:6>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

RecipeBuilder.get("engineer")
  .setShaped([
  [null, <ore:plateLead>, <ore:plateLead>, null, null], 
  [<ore:plateLead>, <better_diving:wiring_kit>, <better_diving:wiring_kit>, <ore:plateLead>, null], 
  [<ore:plateLead>, <natura:flint_and_blaze>, <natura:flint_and_blaze>, <ore:plateLead>, null], 
  [<ore:plateLead>, <immersiveengineering:material:9>, <immersiveengineering:material:9>, <ore:plateLead>, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<simplyjetpacks:metaitemmods:26>)
  .addTool(<ore:artisansCutters>, 22)
  .addTool(<ore:artisansSolderer>, 22)
  .create();

  RecipeBuilder.get("engineer")
  .setShaped([
  [null, <ore:plateElectrum>, <ore:plateElectrum>, null, null], 
  [<ore:plateElectrum>, <better_diving:wiring_kit>, <better_diving:wiring_kit>, <ore:plateElectrum>, null], 
  [<ore:plateElectrum>, <natura:flint_and_blaze>, <natura:flint_and_blaze>, <ore:plateElectrum>, null], 
  [<ore:plateElectrum>, <immersiveengineering:material:9>, <immersiveengineering:material:9>, <ore:plateElectrum>, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<simplyjetpacks:metaitemmods:28>)
  .addTool(<ore:artisansCutters>, 22)
  .addTool(<ore:artisansSolderer>, 22)
  .create();

  RecipeBuilder.get("engineer")
  .setShaped([
  [null, <ore:plateEnderium>, <ore:plateEnderium>, null, null], 
  [<ore:plateEnderium>, <better_diving:wiring_kit>, <better_diving:wiring_kit>, <ore:plateEnderium>, null], 
  [<ore:plateEnderium>, <natura:flint_and_blaze>, <natura:flint_and_blaze>, <ore:plateEnderium>, null], 
  [<ore:plateEnderium>, <immersiveengineering:material:9>, <immersiveengineering:material:9>, <ore:plateEnderium>, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<simplyjetpacks:metaitemmods:29>)
  .addTool(<ore:artisansCutters>, 22)
  .addTool(<ore:artisansSolderer>, 22)
  .create();

RecipeBuilder.get("engineer")
  .setShaped([
  [null, <ore:ingot_dark_soularium>, <ore:ingot_dark_soularium>, null, null], 
  [<ore:ingot_dark_soularium>, <ore:gearIronInfinity>, <ore:gearIronInfinity>, <ore:ingot_dark_soularium>, null], 
  [<ore:ingot_dark_soularium>, <enderio:item_cold_fire_igniter>.withTag({"enderio:famount": 1000}), <enderio:item_cold_fire_igniter>.withTag({"enderio:famount": 1000}), <ore:ingot_dark_soularium>, null], 
  [<ore:ingot_dark_soularium>, <immersiveengineering:material:9>, <immersiveengineering:material:9>, <ore:ingot_dark_soularium>, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<simplyjetpacks:metaitemmods:11>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

RecipeBuilder.get("engineer")
  .setShaped([
  [null, <ore:ingot_dark_soularium>, null, <ore:ingot_dark_soularium>, null], 
  [<ore:ingot_dark_soularium>, <enderio:item_basic_capacitor:2>, <ore:ingot_dark_soularium>, <enderio:item_basic_capacitor:2>, <ore:ingot_dark_soularium>], 
  [<ore:ingot_dark_soularium>, <ore:skullSentientEnder>, <ore:ingot_dark_soularium>, <ore:skullSentientEnder>, <ore:ingot_dark_soularium>], 
  [<ore:ingot_dark_soularium>, <contenttweaker:infinity_flare>, <ore:ingot_dark_soularium>, <contenttweaker:infinity_flare>, <ore:ingot_dark_soularium>], 
  [<ore:ingot_dark_soularium>, <simplyjetpacks:metaitemmods:28>, null, <simplyjetpacks:metaitemmods:28>, <ore:ingot_dark_soularium>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<simplyjetpacks:metaitemmods:11>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

  RecipeBuilder.get("engineer")
  .setShaped([
    [<toughasnails:tan_icon>, <ore:plateLumium>, <ore:plateLumium>, <toughasnails:tan_icon>, null], 
  [<ore:plateLumium>, <thermalfoundation:material:515>, <minecraft:furnace>, <ore:plateLumium>, null], 
  [<ore:plateLumium>, <ore:dustAerotheum>, <thermalfoundation:material:513>, <ore:plateLumium>, null], 
  [<toughasnails:tan_icon>, <ore:plateLumium>, <ore:plateLumium>, <toughasnails:tan_icon>, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:machine>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

  RecipeBuilder.get("engineer")
  .setShaped([
	[<toughasnails:tan_icon>, <ore:plateLumium>, <ore:plateLumium>, <toughasnails:tan_icon>, null], 
	[<ore:plateLumium>, <thermalfoundation:material:515>, <ore:compressedFlint2x>, <ore:plateLumium>, null], 
	[<ore:plateLumium>, <appliedenergistics2:grindstone>, <thermalfoundation:material:513>, <ore:plateLumium>, null], 
	[<toughasnails:tan_icon>, <ore:plateLumium>, <ore:plateLumium>, <toughasnails:tan_icon>, null], 
	[null, null, null, null, null]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:machine:1>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

  RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateLumium>, <ore:plateLumium>, <ore:plateLumium>, <toughasnails:tan_icon>], 
  [<ore:plateLumium>, <ore:gearGold>, <thermalfoundation:material:514>, <ore:gearGold>, <ore:plateLumium>], 
  [<ore:plateLumium>, <extratan:tempered_glass_block>, <thermalfoundation:material:657>, <extratan:tempered_glass_block>, <ore:plateLumium>], 
  [<ore:plateLumium>, <ore:gearGold>, <better_diving:wiring_kit>, <ore:gearGold>, <ore:plateLumium>], 
  [<toughasnails:tan_icon>, <ore:plateLumium>, <ore:plateLumium>, <ore:plateLumium>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:machine:2>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

  RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateLumium>, <ore:plateLumium>, <toughasnails:tan_icon>, null], 
  [<ore:plateLumium>, <thermalfoundation:material:515>, <ore:gearNickel>, <ore:plateLumium>, null], 
  [<ore:plateLumium>, <minecraft:furnace>, <thermalfoundation:material:513>, <ore:plateLumium>, null], 
  [<toughasnails:tan_icon>, <ore:plateLumium>, <ore:plateLumium>, <toughasnails:tan_icon>, null], 
  [null, null, null, null, null]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:machine:3>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

  RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateLumium>, <ore:plateLumium>, <ore:plateLumium>, <toughasnails:tan_icon>], 
  [<ore:plateLumium>, <minecraft:mycelium>, <thermalfoundation:material:514>, <minecraft:mycelium>, <ore:plateLumium>], 
  [<ore:plateLumium>, <extratan:tempered_glass_block>, <thermalfoundation:fertilizer:2>, <extratan:tempered_glass_block>, <ore:plateLumium>], 
  [<ore:plateLumium>, <minecraft:mycelium>, <better_diving:wiring_kit>, <minecraft:mycelium>, <ore:plateLumium>], 
  [<toughasnails:tan_icon>, <ore:plateLumium>, <ore:plateLumium>, <ore:plateLumium>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:machine:4>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

  RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateLead>, <ore:plateLead>, <ore:plateLead>, <toughasnails:tan_icon>], 
  [<ore:plateLead>, <ore:gearSilver>, <thermalfoundation:material:514>, <ore:gearSilver>, <ore:plateLead>], 
  [<ore:plateLead>, <extratan:tempered_glass_block>, <minecraft:piston>, <extratan:tempered_glass_block>, <ore:plateLead>], 
  [<ore:plateLead>, <ore:gearSilver>, <better_diving:wiring_kit>, <ore:gearSilver>, <ore:plateLead>], 
  [<toughasnails:tan_icon>, <ore:plateLead>, <ore:plateLead>, <ore:plateLead>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:machine:5>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();


  RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateLead>, <ore:plateLead>, <ore:plateLead>, <toughasnails:tan_icon>], 
  [<ore:plateLead>, <ore:gearSilver>, <thermalfoundation:material:514>, <ore:gearSilver>, <ore:plateLead>], 
  [<ore:plateLead>, <extratan:tempered_glass_block>, <embers:pump>, <extratan:tempered_glass_block>, <ore:plateLead>], 
  [<ore:plateLead>, <ore:gearSilver>, <better_diving:wiring_kit>, <ore:gearSilver>, <ore:plateLead>], 
  [<toughasnails:tan_icon>, <ore:plateLead>, <ore:plateLead>, <ore:plateLead>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:machine:7>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

    RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateLead>, <ore:plateLead>, <ore:plateLead>, <toughasnails:tan_icon>], 
  [<ore:plateLead>, <ore:gearSilver>, <thermalfoundation:material:514>, <ore:gearSilver>, <ore:plateLead>], 
  [<ore:plateLead>, <extratan:tempered_glass_block>, <minecraft:crafting_table>, <extratan:tempered_glass_block>, <ore:plateLead>], 
  [<ore:plateLead>, <ore:gearSilver>, <better_diving:wiring_kit>, <ore:gearSilver>, <ore:plateLead>], 
  [<toughasnails:tan_icon>, <ore:plateLead>, <ore:plateLead>, <ore:plateLead>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:machine:11>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

    RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateLead>, <ore:plateLead>, <ore:plateLead>, <toughasnails:tan_icon>], 
  [<ore:plateLead>, <ore:gearSilver>, <thermalfoundation:material:514>, <ore:gearSilver>, <ore:plateLead>], 
  [<ore:plateLead>, <extratan:tempered_glass_block>, <minecraft:brewing_stand>, <extratan:tempered_glass_block>, <ore:plateLead>], 
  [<ore:plateLead>, <ore:gearSilver>, <better_diving:wiring_kit>, <ore:gearSilver>, <ore:plateLead>], 
  [<toughasnails:tan_icon>, <ore:plateLead>, <ore:plateLead>, <ore:plateLead>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:machine:12>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

      RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateLead>, <ore:plateLead>, <ore:plateLead>, <toughasnails:tan_icon>], 
  [<ore:plateLead>, <ore:gearSilver>, <thermalfoundation:material:514>, <ore:gearSilver>, <ore:plateLead>], 
  [<ore:plateLead>, <extratan:tempered_glass_block>, <minecraft:enchanting_table>, <extratan:tempered_glass_block>, <ore:plateLead>], 
  [<ore:plateLead>, <ore:gearSilver>, <better_diving:wiring_kit>, <ore:gearSilver>, <ore:plateLead>], 
  [<toughasnails:tan_icon>, <ore:plateLead>, <ore:plateLead>, <ore:plateLead>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:machine:13>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

        RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateLead>, <ore:plateLead>, <ore:plateLead>, <toughasnails:tan_icon>], 
  [<ore:plateLead>, <ore:gearSilver>, <thermalfoundation:material:514>, <ore:gearSilver>, <ore:plateLead>], 
  [<ore:plateLead>, <extratan:tempered_glass_block>, <embers:mixer>, <extratan:tempered_glass_block>, <ore:plateLead>], 
  [<ore:plateLead>, <ore:gearSilver>, <better_diving:wiring_kit>, <ore:gearSilver>, <ore:plateLead>], 
  [<toughasnails:tan_icon>, <ore:plateLead>, <ore:plateLead>, <ore:plateLead>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:machine:15>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

        RecipeBuilder.get("engineer")
  .setShaped([
  [null, null, <ore:plateLead>, null, null], 
	[<immersiveengineering:connector:4>, <better_diving:wiring_kit>, <ore:plateLead>, <better_diving:wiring_kit>, <immersiveengineering:connector:4>], 
	[null, <ore:plateLead>, <immersiveengineering:metal_device0>, <ore:plateLead>, null], 
	[null, <ore:plateLead>, <embers:winding_gears>, <ore:plateLead>, null], 
	[null, <ore:plateLead>, <ore:plateLead>, <ore:plateLead>, null]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:capacitor>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

        RecipeBuilder.get("engineer")
  .setShaped([
  [null, null, <ore:plateInvar>, null, null], 
	[<immersiveengineering:connector:4>, <better_diving:wiring_kit>, <ore:plateInvar>, <better_diving:wiring_kit>, <immersiveengineering:connector:4>], 
	[null, <ore:plateInvar>, <thermalexpansion:capacitor>, <ore:plateInvar>, null], 
	[null, <ore:plateInvar>, <embers:winding_gears>, <ore:plateInvar>, null], 
	[null, <ore:plateInvar>, <ore:plateInvar>, <ore:plateInvar>, null]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:capacitor:1>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

        RecipeBuilder.get("engineer")
  .setShaped([
  [null, null, <ore:plateElectrum>, null, null], 
	[<immersiveengineering:connector:4>, <better_diving:wiring_kit>, <ore:plateElectrum>, <better_diving:wiring_kit>, <immersiveengineering:connector:4>], 
	[null, <ore:plateElectrum>, <thermalexpansion:capacitor:1>, <ore:plateElectrum>, null], 
	[null, <ore:plateElectrum>, <embers:winding_gears>, <ore:plateElectrum>, null], 
	[null, <ore:plateElectrum>, <ore:plateElectrum>, <ore:plateElectrum>, null]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:capacitor:2>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

        RecipeBuilder.get("engineer")
  .setShaped([
  [null, null, <ore:plateSignalum>, null, null], 
	[<immersiveengineering:connector:4>, <better_diving:wiring_kit>, <ore:plateSignalum>, <better_diving:wiring_kit>, <immersiveengineering:connector:4>], 
	[null, <ore:plateSignalum>, <thermalexpansion:capacitor:2>, <ore:plateSignalum>, null], 
	[null, <ore:plateSignalum>, <embers:winding_gears>, <ore:plateSignalum>, null], 
	[null, <ore:plateSignalum>, <ore:plateSignalum>, <ore:plateSignalum>, null]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:capacitor:3>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

          RecipeBuilder.get("engineer")
  .setShaped([
  [null, null, <ore:plateEnderium>, null, null], 
	[<immersiveengineering:connector:4>, <better_diving:wiring_kit>, <ore:plateEnderium>, <better_diving:wiring_kit>, <immersiveengineering:connector:4>], 
	[null, <ore:plateEnderium>, <thermalexpansion:capacitor:3>, <ore:plateEnderium>, null], 
	[null, <ore:plateEnderium>, <embers:winding_gears>, <ore:plateEnderium>, null], 
	[null, <ore:plateEnderium>, <ore:plateEnderium>, <ore:plateEnderium>, null]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:capacitor:4>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

          RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <assistedprogression:item_trash_bag>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:gearSilver>, <thermalexpansion:frame:64>, <ore:gearSilver>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <assistedprogression:item_trash_bag>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:device:1>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

          RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <minecraft:potion>.withTag({Potion: "cofhcore:haste+"}), <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:gearSilver>, <thermalexpansion:frame:64>, <ore:gearSilver>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <minecraft:potion>.withTag({Potion: "cofhcore:haste+"}), <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:device:2>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

          RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <waterstrainer:strainer_survivalist_dense>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:gearSilver>, <thermalexpansion:frame:64>, <ore:gearSilver>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <waterstrainer:strainer_survivalist_dense>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:device:4>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

          RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <minecraft:hopper>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:gearSilver>, <thermalexpansion:frame:64>, <ore:gearSilver>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <minecraft:hopper>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:device:5>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

            RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <fluidfunnel:funnel>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:gearSilver>, <thermalexpansion:frame:64>, <ore:gearSilver>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <fluidfunnel:funnel>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:device:6>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

              RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <minecraft:book>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:gearSilver>, <thermalexpansion:frame:64>, <ore:gearSilver>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <minecraft:book>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:device:7>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

                RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <minecraft:experience_bottle>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:gearSilver>, <thermalexpansion:frame:64>, <ore:gearSilver>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <minecraft:experience_bottle>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:device:8>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

                  RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <redstone_lock:dookie>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:gearSilver>, <thermalexpansion:frame:64>, <ore:gearSilver>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <redstone_lock:dookie>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:device:9>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

                    RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <minecraft:piston>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:gearSilver>, <thermalexpansion:frame:64>, <ore:gearSilver>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <minecraft:piston>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:device:10>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

                      RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <tinymobfarm:lasso>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:gearNickel>, <thermalexpansion:frame:64>, <ore:gearNickel>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <tinymobfarm:lasso>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:device:11>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

                        RecipeBuilder.get("engineer")
  .setShaped([
  [<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <embers:item_pump>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:gearNickel>, <thermalexpansion:frame:64>, <ore:gearNickel>, <ore:plateBronze>], 
	[<ore:plateBronze>, <ore:blockGlassHardened>, <embers:item_pump>, <ore:blockGlassHardened>, <ore:plateBronze>], 
	[<toughasnails:tan_icon>, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, <toughasnails:tan_icon>]])
  .setFluid(<liquid:solder> * 500)
  .addOutput(<thermalexpansion:device:11>)
  .addTool(<ore:artisansCutters>, 32)
  .addTool(<ore:artisansSolderer>, 32)
  .create();

                        RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:itemConduitBinder>, <ore:itemConduitBinder>, <ore:itemConduitBinder>], 
	[<embers:item_pipe>, <embers:item_pipe>, <embers:item_pipe>], 
	[<ore:itemConduitBinder>, <ore:itemConduitBinder>, <ore:itemConduitBinder>]])
  .addOutput(<enderio:item_item_conduit> * 3)
  .addTool(<ore:artisansCutters>, 12)
  .create();

                          RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:itemConduitBinder>, <ore:itemConduitBinder>, <ore:itemConduitBinder>], 
	[<embers:pipe>, <embers:pipe>, <embers:pipe>], 
	[<ore:itemConduitBinder>, <ore:itemConduitBinder>, <ore:itemConduitBinder>]])
  .addOutput(<enderio:item_liquid_conduit> * 3)
  .addTool(<ore:artisansCutters>, 12)
  .create();

                          RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:blockGlassHardened>, <ore:blockGlassHardened>, <ore:blockGlassHardened>], 
	[<enderio:item_liquid_conduit>, <enderio:item_liquid_conduit>, <enderio:item_liquid_conduit>], 
	[<ore:blockGlassHardened>, <ore:blockGlassHardened>, <ore:blockGlassHardened>]])
  .addOutput(<enderio:item_liquid_conduit> * 3)
  .addTool(<ore:artisansCutters>, 12)
  .create();

                            RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:itemConduitBinder>, <ore:itemConduitBinder>, <ore:itemConduitBinder>], 
	[<enderio:item_liquid_conduit>, <enderio:item_liquid_conduit>, <enderio:item_liquid_conduit>], 
	[<ore:itemConduitBinder>, <ore:itemConduitBinder>, <ore:itemConduitBinder>]])
  .addOutput(<enderio:item_liquid_conduit:1> * 3)
  .addTool(<ore:artisansCutters>, 12)
  .create();

                            RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:dustBedrock>, <ore:dustBedrock>, <ore:dustBedrock>], 
	[<enderio:item_liquid_conduit:1>, <enderio:item_liquid_conduit:1>, <enderio:item_liquid_conduit:1>], 
	[<ore:dustBedrock>, <ore:dustBedrock>, <ore:dustBedrock>]])
  .addOutput(<enderio:item_liquid_conduit:2> * 3)
  .addTool(<ore:artisansCutters>, 12)
  .create();

                            RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:itemConduitBinder>, <ore:itemConduitBinder>, <ore:itemConduitBinder>], 
	[<ore:dustRedstone>, <ore:dustRedstone>, <ore:dustRedstone>], 
	[<ore:itemConduitBinder>, <ore:itemConduitBinder>, <ore:itemConduitBinder>]])
  .addOutput(<enderio:item_redstone_conduit> * 3)
  .addTool(<ore:artisansCutters>, 12)
  .create();

                            RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:itemConduitBinder>, <ore:itemConduitBinder>, <ore:itemConduitBinder>], 
	[<thermalfoundation:material:515>, <thermalfoundation:material:515>, <thermalfoundation:material:515>], 
	[<ore:itemConduitBinder>, <ore:itemConduitBinder>, <ore:itemConduitBinder>]])
  .addOutput(<enderio:item_power_conduit:1> * 3)
  .addTool(<ore:artisansCutters>, 12)
  .create();

                              RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:dustBedrock>, <ore:dustBedrock>, <ore:dustBedrock>], 
	[<enderio:item_power_conduit:1>, <enderio:item_power_conduit:1>, <enderio:item_power_conduit:1>], 
	[<ore:dustBedrock>, <ore:dustBedrock>, <ore:dustBedrock>]])
  .addOutput(<enderio:item_power_conduit:2> * 3)
  .addTool(<ore:artisansCutters>, 12)
  .create();

                            RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:itemConduitBinder>, <ore:itemConduitBinder>, <ore:itemConduitBinder>], 
	[<better_diving:wiring_kit>, <better_diving:wiring_kit>, <better_diving:wiring_kit>], 
	[<ore:itemConduitBinder>, <ore:itemConduitBinder>, <ore:itemConduitBinder>]])
  .addOutput(<enderio:item_power_conduit> * 3)
  .addTool(<ore:artisansCutters>, 12)
  .create();


                              RecipeBuilder.get("engineer")
  .setShaped([
  [<ore:dustRedstone>, null, <ore:dustRedstone>], 
	[null, <ore:plateTin>, null], 
	[<ore:dustRedstone>, null, <ore:dustRedstone>]])
  .addOutput(<thermalfoundation:material:512> * 3)
  .addTool(<ore:artisansCutters>, 6)
  .create();

                              RecipeBuilder.get("engineer")
  .setShaped([
  [<contenttweaker:sheet_rubber>, <ore:blockGlassColorless>, <contenttweaker:sheet_rubber>], 
	[<ore:blockGlassColorless>, <ore:blockGlassColorless>, <ore:blockGlassColorless>], 
	[<contenttweaker:sheet_rubber>, <ore:blockGlassColorless>, <contenttweaker:sheet_rubber>]])
  .addOutput(<openblocks:tank>)
  .addTool(<ore:artisansCutters>, 18)
  .create();

                      RecipeBuilder.get("engineer")
  .setShaped([
    [<ore:blockLapis>, <ore:blockLapis>, <ore:blockDiamond>, <ore:blockLapis>, <ore:blockLapis>], 
  [<ore:blockLapis>, <ore:netherStar>, <redstone_lock:fakeegg>, <ore:netherStar>, <ore:blockLapis>], 
  [<ore:blockLapis>, <ore:blockLapis>, <ore:blockDiamond>, <ore:blockLapis>, <ore:blockLapis>], 
  [null, <ore:itemSkull>, <ore:itemSkull>, <ore:itemSkull>, null], 
  [<ore:blockQuartz>, <ore:blockQuartz>, <ore:blockQuartz>, <ore:blockQuartz>, <ore:blockQuartz>]])
  .setFluid(<liquid:xpjuice> * 5000)
  .addOutput(<artisanworktables:workshop:7>)
  .addTool(<ore:artisansCutters>, 512)
  .addTool(<ore:artisansSolderer>, 512)
  .create();

                      RecipeBuilder.get("engineer")
  .setShaped([
    [null, <ore:gearSignalum>, <ore:gearSignalum>, <ore:gearSignalum>, null], 
	[null, null, <ore:stickSteel>, null, null], 
	[null, null, <ore:stickSteel>, null, null], 
	[null, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, null], 
	[null, <ore:plateBronze>, <ore:plateBronze>, <ore:plateBronze>, null]])
  .addOutput(<weirdinggadget:weirding_gadget>)
  .addTool(<ore:artisansCutters>, 48)
  .addTool(<ore:artisansSolderer>, 48)
  .create();

RecipeBuilder.get("engineer")
  .setShaped([
    [<thermalfoundation:material:323>, <thermalfoundation:material:323>, <thermalfoundation:material:323>],
    [<immersiveengineering:metal_decoration0>, <immersiveengineering:metal_decoration0:2>, <immersiveengineering:metal_decoration0>],
    [<thermalfoundation:material:323>, <thermalfoundation:material:323>, <thermalfoundation:material:323>]])
  .setFluid(<liquid:solder> * 1000)
  .addTool(<ore:artisansCutters>, 48)
  .addTool(<ore:artisansSolderer>, 48)
  .addOutput(<immersiveengineering:metal_device1:3>)
  .create();

  RecipeBuilder.get("engineer")
  .setShaped([
    [<ore:platePlatinum>, <better_diving:wiring_kit>, <ore:platePlatinum>], 
  [<minecraft:crafting_table>, <immersiveengineering:metal_decoration0:4>, <minecraft:crafting_table>], 
  [<ore:platePlatinum>, <better_diving:wiring_kit>, <ore:platePlatinum>]])
  .addTool(<ore:artisansCutters>, 28)
  .addOutput(<cyclicmagic:auto_crafter>)
  .create();

 RecipeBuilder.get("engineer")
  .setShaped([[<ore:ingotLumium>, <ore:dustRedstone>, <ore:ingotLumium>], [<ore:enderpearl>, <ore:dustRedstone>, <ore:enderpearl>], [<ore:ingotLumium>, <ore:gemLapis>, <ore:ingotLumium>]])
  .setFluid(<liquid:solder> * 1000)
  .addTool(<ore:artisansCutters>, 24)
  .addTool(<ore:artisansSolderer>, 24)
.addOutput(<buildinggadgets:destructiontool>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[<ore:ingotGold>, <ore:dustRedstone>, <ore:ingotGold>], [<ore:gemEmerald>, <ore:dustRedstone>, <ore:gemEmerald>], [<ore:ingotGold>, <ore:gemLapis>, <ore:ingotGold>]])
  .setFluid(<liquid:solder> * 1000)
  .addTool(<ore:artisansCutters>, 24)
  .addTool(<ore:artisansSolderer>, 24)
.addOutput(<buildinggadgets:templatemanager>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[<ore:ingotLumium>, <ore:dustRedstone>, <ore:ingotLumium>], [<ore:gemDiamond>, <ore:gemLapis>, <ore:gemDiamond>], [<ore:ingotLumium>, <ore:gemLapis>, <ore:ingotLumium>]])
  .setFluid(<liquid:solder> * 1000)
  .addTool(<ore:artisansCutters>, 24)
  .addTool(<ore:artisansSolderer>, 24)
.addOutput(<buildinggadgets:exchangertool>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[<ore:ingotLumium>, <ore:ingotLumium>, <ore:ingotLumium>], [<ore:ingotLumium>, <buildinggadgets:constructionpaste>, <ore:ingotLumium>], [<ore:ingotLumium>, <ore:ingotLumium>, <ore:ingotLumium>]])
  .setFluid(<liquid:solder> * 1000)
  .addTool(<ore:artisansCutters>, 24)
  .addTool(<ore:artisansSolderer>, 24)
.addOutput(<buildinggadgets:constructionpastecontainer>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[<ore:ingotLumium>, <ore:dustRedstone>, <ore:ingotLumium>], [<ore:gemDiamond>, <ore:dustRedstone>, <ore:gemDiamond>], [<ore:ingotLumium>, <ore:gemLapis>, <ore:ingotLumium>]])
  .setFluid(<liquid:solder> * 1000)
  .addTool(<ore:artisansCutters>, 24)
  .addTool(<ore:artisansSolderer>, 24)
.addOutput(<buildinggadgets:buildingtool>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[<ore:ingotLumium>, <ore:dustRedstone>, <ore:ingotLumium>], [<ore:gemEmerald>, <ore:dustRedstone>, <ore:gemEmerald>], [<ore:ingotLumium>, <ore:gemLapis>, <ore:ingotLumium>]])
  .setFluid(<liquid:solder> * 1000)
  .addTool(<ore:artisansCutters>, 24)
  .addTool(<ore:artisansSolderer>, 24)
.addOutput(<buildinggadgets:copypastetool>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[<buildinggadgets:constructionpastecontainert2>, <ore:gemDiamond>, <buildinggadgets:constructionpastecontainert2>], [<ore:gemDiamond>, <ore:gemDiamond>, <ore:gemDiamond>], [<buildinggadgets:constructionpastecontainert2>, <ore:gemDiamond>, <buildinggadgets:constructionpastecontainert2>]])
  .setFluid(<liquid:solder> * 1000)
  .addTool(<ore:artisansCutters>, 8)
  .addTool(<ore:artisansSolderer>, 8)
.addOutput(<buildinggadgets:constructionpastecontainert3>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[<buildinggadgets:constructionpastecontainer>, <ore:ingotGold>, <buildinggadgets:constructionpastecontainer>], [<ore:ingotGold>, <ore:ingotGold>, <ore:ingotGold>], [<buildinggadgets:constructionpastecontainer>, <ore:ingotGold>, <buildinggadgets:constructionpastecontainer>]])
  .setFluid(<liquid:solder> * 1000)
  .addTool(<ore:artisansCutters>, 8)
  .addTool(<ore:artisansSolderer>, 8)
.addOutput(<buildinggadgets:constructionpastecontainert2>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[null, null, <ore:itemEmptyBucket>, null, null], 
  [null, <ore:plateTin>, <thermalexpansion:tank>, <ore:plateTin>, null], 
  [null, <ore:plateTin>, null, <ore:plateTin>, null], 
  [null, <ore:plateTin>, null, <ore:plateTin>, null], 
  [null, <ore:plateTin>, <ore:plateTin>, <ore:plateTin>, null]])
  .setFluid(<liquid:solder> * 1000)
  .addTool(<ore:artisansCutters>, 48)
  .addTool(<ore:artisansSolderer>, 48)
.addOutput(<thermalexpansion:reservoir>)
.create();


 RecipeBuilder.get("engineer")
  .setShaped([[null, null, <ore:itemEmptyBucket>, null, null], 
  [null, <ore:plateInvar>, <thermalexpansion:tank>, <ore:plateInvar>, null], 
  [null, <ore:plateInvar>, <thermalexpansion:reservoir>, <ore:plateInvar>, null], 
  [null, <ore:plateInvar>, null, <ore:plateInvar>, null], 
  [null, <ore:plateInvar>, <ore:plateInvar>, <ore:plateInvar>, null]])
  .setFluid(<liquid:solder> * 1000)
  .addTool(<ore:artisansCutters>, 48)
  .addTool(<ore:artisansSolderer>, 48)
.addOutput(<thermalexpansion:reservoir:1>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[null, null, <ore:itemEmptyBucket>, null, null], 
  [null, <ore:plateElectrum>, <thermalexpansion:tank>, <ore:plateElectrum>, null], 
  [null, <ore:plateElectrum>, <thermalexpansion:reservoir:1>, <ore:plateElectrum>, null], 
  [null, <ore:plateElectrum>, null, <ore:plateElectrum>, null], 
  [null, <ore:plateElectrum>, <ore:plateElectrum>, <ore:plateElectrum>, null]])
  .setFluid(<liquid:solder> * 1000)
  .addTool(<ore:artisansCutters>, 48)
  .addTool(<ore:artisansSolderer>, 48)
.addOutput(<thermalexpansion:reservoir:2>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[null, null, <ore:itemEmptyBucket>, null, null], 
  [null, <ore:plateSignalum>, <thermalexpansion:tank>, <ore:plateSignalum>, null], 
  [null, <ore:plateSignalum>, <thermalexpansion:reservoir:2>, <ore:plateSignalum>, null], 
  [null, <ore:plateSignalum>, null, <ore:plateSignalum>, null], 
  [null, <ore:plateSignalum>, <ore:plateSignalum>, <ore:plateSignalum>, null]])
  .setFluid(<liquid:solder> * 1000)
  .addTool(<ore:artisansCutters>, 48)
  .addTool(<ore:artisansSolderer>, 48)
.addOutput(<thermalexpansion:reservoir:3>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[null, null, <ore:itemEmptyBucket>, null, null], 
  [null, <ore:plateEnderium>, <thermalexpansion:tank>, <ore:plateEnderium>, null], 
  [null, <ore:plateEnderium>, <thermalexpansion:reservoir:3>, <ore:plateEnderium>, null], 
  [null, <ore:plateEnderium>, null, <ore:plateEnderium>, null], 
  [null, <ore:plateEnderium>, <ore:plateEnderium>, <ore:plateEnderium>, null]])
  .setFluid(<liquid:solder> * 1000)
  .addTool(<ore:artisansCutters>, 48)
  .addTool(<ore:artisansSolderer>, 48)
.addOutput(<thermalexpansion:reservoir:4>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[null, <ore:plateLead>, null, null, null], 
  [<ore:plateGold>, <better_diving:wiring_kit>, <ore:plateGold>, null, null], 
  [null, <ore:plateLead>, null, null, null], 
  [null, null, null, null, null], 
  [null, null, null, null, null]])
  .addTool(<ore:artisansCutters>, 8)
  .addTool(<ore:artisansSolderer>, 8)
.addOutput(<thermalfoundation:material:640>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[null, <minecraft:daylight_detector>, null, <minecraft:daylight_detector>, null], 
  [<immersiveengineering:material:8>, <ore:plateElectrum>, <cyclicmagic:sound_player>, <ore:plateElectrum>, <immersiveengineering:material:8>], 
  [<ore:plateElectrum>, <ore:plateElectrum>, <better_diving:wiring_kit>, <ore:plateElectrum>, <ore:plateElectrum>], 
  [null, <ore:plateElectrum>, <thermalfoundation:material:514>, <ore:plateElectrum>, null], 
  [null, <ore:plateElectrum>, <ore:plateElectrum>, <ore:plateElectrum>, null]])
  .setFluid(<liquid:solder> * 500)
  .addTool(<ore:artisansCutters>, 28)
  .addTool(<ore:artisansSolderer>, 28)
.addOutput(<scannable:scanner>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[<ore:woolOrange>, <ore:woolOrange>, <ore:woolOrange>, <ore:woolOrange>, <ore:woolOrange>], 
  [<ore:woolOrange>, <ore:dustRedstone>, <cyclicmagic:doorbell_simple>, <ore:dustRedstone>, <ore:woolOrange>], 
  [<ore:woolOrange>, <cyclicmagic:doorbell_simple>, <cyclicmagic:doorbell_simple>, <cyclicmagic:doorbell_simple>, <ore:woolOrange>], 
  [<ore:woolOrange>, <ore:dustRedstone>, <cyclicmagic:doorbell_simple>, <ore:dustRedstone>, <ore:woolOrange>], 
  [<ore:woolOrange>, <ore:woolOrange>, <ore:woolOrange>, <ore:woolOrange>, <ore:woolOrange>]])
  .addTool(<ore:artisansCutters>, 18)
  .addTool(<ore:artisansSolderer>, 18)
.addOutput(<cyclicmagic:sound_player>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[<toughasnails:tan_icon>, <ore:plateSilver>, <ore:plateSilver>, <ore:plateSilver>, <toughasnails:tan_icon>], 
  [<ore:plateSilver>, <armorunder:cooling_goo>, <ore:blockGlassHardened>, <armorunder:heating_goo>, <ore:plateSilver>], 
  [<ore:plateSilver>, <toughasnails:thermometer>, <better_diving:wiring_kit>, <toughasnails:thermometer>, <ore:plateSilver>], 
  [<ore:plateSilver>, <armorunder:heating_goo>, <ore:blockGlassHardened>, <armorunder:cooling_goo>, <ore:plateSilver>], 
  [<toughasnails:tan_icon>, <ore:plateSilver>, <ore:plateSilver>, <ore:plateSilver>, <toughasnails:tan_icon>]])
  .addTool(<ore:artisansCutters>, 28)
  .addTool(<ore:artisansSolderer>, 28)
.addOutput(<tanaddons:portable_temp_regulator>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[<ore:plateSilver>, <minecraft:daylight_detector>, <ore:plateSilver>], 
  [<armorunder:heating_goo>, <better_diving:wiring_kit>, <armorunder:cooling_goo>], 
  [<ore:plateSilver>, <minecraft:daylight_detector>, <ore:plateSilver>]])
  .addTool(<ore:artisansCutters>, 12)
  .addTool(<ore:artisansSolderer>, 12)
.addOutput(<toughasnails:thermometer>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[null, <modularmachinery:itemmodularium>, null], 
	[<modularmachinery:itemmodularium>, <minecraft:chest>, <modularmachinery:itemmodularium>], 
	[null, <modularmachinery:itemmodularium>, null]])
  .addTool(<ore:artisansCutters>, 12)
  .addTool(<ore:artisansSolderer>, 12)
.addOutput(<modularmachinery:blockinputbus>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[<modularmachinery:itemmodularium>, null, <modularmachinery:itemmodularium>], 
	[<modularmachinery:itemmodularium>, <minecraft:chest>, <modularmachinery:itemmodularium>], 
	[null, <modularmachinery:itemmodularium>, null]])
  .addTool(<ore:artisansCutters>, 12)
  .addTool(<ore:artisansSolderer>, 12)
.addOutput(<modularmachinery:blockoutputbus>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[null, <ore:gearInvar>, null], 
  [<simplyjetpacks:metaitemmods:27>, <simplyjetpacks:itemjetpack:10>, <simplyjetpacks:metaitemmods:27>], 
  [null, <ore:gearInvar>, null]])
  .setFluid(<liquid:solder> * 500)
  .addTool(<ore:artisansCutters>, 28)
  .addTool(<ore:artisansSolderer>, 28)
.addOutput(<simplyjetpacks:itemjetpack:11>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[null, <ore:gearElectrum>, null], 
  [<simplyjetpacks:metaitemmods:28>, <simplyjetpacks:itemjetpack:11>, <simplyjetpacks:metaitemmods:28>], 
  [null, <ore:gearElectrum>, null]])
  .setFluid(<liquid:solder> * 500)
  .addTool(<ore:artisansCutters>, 28)
  .addTool(<ore:artisansSolderer>, 28)
.addOutput(<simplyjetpacks:itemjetpack:12>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[null, <ore:gearEnderium>, null], 
  [<simplyjetpacks:metaitemmods:29>, <simplyjetpacks:itemjetpack:12>, <simplyjetpacks:metaitemmods:29>], 
  [null, <ore:gearEnderium>, null]])
  .setFluid(<liquid:solder> * 500)
  .addTool(<ore:artisansCutters>, 28)
  .addTool(<ore:artisansSolderer>, 28)
.addOutput(<simplyjetpacks:itemjetpack:13>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[<ore:plateBronze>, <ore:blockGlassColorless>, <ore:blockGlassColorless>, <ore:blockGlassColorless>, <ore:plateBronze>], 
  [<ore:plateBronze>, <ore:plateBronze>, <ore:blockGlassColorless>, <ore:plateBronze>, <ore:plateBronze>], 
  [<ore:plateBronze>, <ore:blockGlassColorless>, <ore:blockGlassColorless>, <ore:blockGlassColorless>, <ore:plateBronze>], 
  [<ore:plateBronze>, <ore:plateBronze>, <ore:blockGlassColorless>, <ore:plateBronze>, <ore:plateBronze>], 
  [<ore:plateBronze>, <ore:blockGlassColorless>, <ore:blockGlassColorless>, <ore:blockGlassColorless>, <ore:plateBronze>]])
  .setFluid(<liquid:solder> * 500)
  .addTool(<ore:artisansCutters>, 28)
  .addTool(<ore:artisansSolderer>, 28)
.addOutput(<simplyjetpacks:itemjetpack:13>)
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[<ore:plateSilver>, <notenoughwands:building_wand>, <ore:plateSilver>, null, null], 
	[<better_diving:wiring_kit>, <cyclicmagic:block_user>, <better_diving:wiring_kit>, null, null], 
	[<ore:plateSilver>, <ore:plateSilver>, <ore:plateSilver>, null, null], 
	[null, null, null, null, null], 
	[null, null, null, null, null]])
  .setFluid(<liquid:solder> * 250)
  .addTool(<ore:artisansCutters>, 18)
  .addTool(<ore:artisansSolderer>, 18)
.addOutput(<buildinggadgets:buildingtool>.withTag({anchorcoords: [], Energy: 500000, blockstate: {Name: "minecraft:air"}}))
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[<ore:plateSilver>, <notenoughwands:building_wand>, <ore:plateSilver>, null, null], 
	[<better_diving:wiring_kit>, <minecraft:book>, <better_diving:wiring_kit>, null, null], 
	[<ore:plateSilver>, <ore:plateSilver>, <ore:plateSilver>, null, null], 
	[null, null, null, null, null], 
	[null, null, null, null, null]])
  .setFluid(<liquid:solder> * 250)
  .addTool(<ore:artisansCutters>, 18)
  .addTool(<ore:artisansSolderer>, 18)
.addOutput(<buildinggadgets:copypastetool>.withTag({mode: "Copy", Energy: 500000}))
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[<ore:plateSilver>, <notenoughwands:building_wand>, <ore:plateSilver>, null, null], 
	[<better_diving:wiring_kit>, <chisel:chisel_iron>, <better_diving:wiring_kit>, null, null], 
	[<ore:plateSilver>, <ore:plateSilver>, <ore:plateSilver>, null, null], 
	[null, null, null, null, null], 
	[null, null, null, null, null]])
  .setFluid(<liquid:solder> * 250)
  .addTool(<ore:artisansCutters>, 18)
  .addTool(<ore:artisansSolderer>, 18)
.addOutput(<buildinggadgets:exchangertool>.withTag({anchorcoords: [], Energy: 500000, blockstate: {Name: "minecraft:air"}}))
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[<ore:plateSilver>, <notenoughwands:building_wand>, <ore:plateSilver>, null, null], 
	[<better_diving:wiring_kit>, <thermalfoundation:tool.hammer_lead>, <better_diving:wiring_kit>, null, null], 
	[<ore:plateSilver>, <ore:plateSilver>, <ore:plateSilver>, null, null], 
	[null, null, null, null, null], 
	[null, null, null, null, null]])
  .setFluid(<liquid:solder> * 250)
  .addTool(<ore:artisansCutters>, 18)
  .addTool(<ore:artisansSolderer>, 18)
.addOutput(<buildinggadgets:destructiontool>.withTag({overlay: 1 as byte, Energy: 1000000, fuzzy: 1 as byte}))
.create();

 RecipeBuilder.get("engineer")
  .setShaped([[<ore:blockGlass>, <ore:blockGlass>, <ore:blockGlass>], 
	[<ore:blockGlass>, <thermalfoundation:material:514>, <ore:blockGlass>], 
	[<ore:blockGlass>, <ore:blockGlass>, <ore:blockGlass>]])
  .addTool(<ore:artisansCutters>, 18)
.addOutput(<cyclicmagic:wireless_transmitter>)
.create();

