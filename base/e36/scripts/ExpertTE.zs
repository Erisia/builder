//REMOVE RECIPES
recipes.remove(<thermalexpansion:frame:64>);//DEVICE FRAME
recipes.remove(<thermalexpansion:frame:0>);//MACHINE FRAME
recipes.remove(<thermalfoundation:material:513>);//REDSTONE RECEPTION COIL
recipes.remove(<thermalfoundation:material:514>);//REDSTONE TRANSMISSION COIL
recipes.remove(<thermalfoundation:material:515>);//REDSTONE CONDUCTANCE COIL
recipes.remove(<thermalexpansion:machine:1>);//PULVERIZER
recipes.remove(<thermalexpansion:machine:0>);//REDSTONE FURNACE
recipes.remove(<thermalfoundation:upgrade:0>);//HARDENED UPGRADE KIT
recipes.remove(<thermalfoundation:upgrade:1>);//REINFORCED UPGRADE KIT
recipes.remove(<thermalfoundation:upgrade:2>);//SIGNALUM UPGRADE KIT
recipes.remove(<thermalfoundation:upgrade:3>);//RESONANT UPGRADE KIT
recipes.remove(<thermalexpansion:machine:3>);//INDUCTION SMELTER
recipes.remove(<thermalexpansion:machine:6>);//MAGMA CRUCIBLE
recipes.remove(<thermalexpansion:machine:8>);//FLUID TRANSPOSER
recipes.remove(<simplyjetpacks:metaitem:4>);//LEATHER STRAP
recipes.remove(<thermalexpansion:dynamo:0>);//STEAM DYNAMO
recipes.remove(<simplyjetpacks:metaitemmods:26>);//LEADSTONE THRUSTER
recipes.remove(<thermalexpansion:dynamo:3>);//REACTANT DYNAMO
recipes.remove(<simplyjetpacks:metaitemmods:27>);//HARDENED THRUSTER
recipes.remove(<thermalexpansion:dynamo:1>);//MAGMATIC DYNAMO
recipes.remove(<simplyjetpacks:metaitemmods:28>);//REINFORCED THRUSTER
recipes.remove(<thermalexpansion:dynamo:4>);//ENERVATION DYNAMO
recipes.remove(<simplyjetpacks:metaitemmods:29>);//RESONANT THRUSTER
recipes.remove(<thermalexpansion:dynamo:2>);//COMPRESSION DYNAMO
recipes.remove(<thermalfoundation:material:1027>);//PETROTHEUM DUST
recipes.remove(<thermalfoundation:material:1024>);//PYROTHEUM DUST
recipes.remove(<thermalfoundation:material:1025>);//CRYOTHEUM DUST
recipes.remove(<thermalfoundation:material:1026>);//AEROTHEUM DUST
recipes.remove(<thermalexpansion:machine:2>);//SAWMILL
recipes.remove(<thermalfoundation:material:98>);//INVAR BLEND
recipes.remove(<thermaldynamics:duct_0:0>);//LEADSTONE FLUXDUCT
recipes.remove(<thermalexpansion:capacitor:0>);//LEADSTONE CAPACITOR
recipes.remove(<thermaldynamics:retriever:0>);//RETRIEVER
recipes.remove(<thermaldynamics:retriever:2>);//RETRIEVER
recipes.remove(<thermalcultivation:watering_can>);//WATERING CAN
recipes.remove(<thermalcultivation:watering_can:4>);//WATERING CAN
//ADD RECIPES
recipes.addShaped(<thermalexpansion:frame:64>,[[<ore:ingotSteel>,<minecraft:glass>,<ore:ingotSteel>],
																[<minecraft:glass>,<ore:gearCopper>,<minecraft:glass>],
																[<ore:ingotSteel>,<minecraft:glass>,<ore:ingotSteel>]]);//DEVICE FRAME
recipes.addShaped(<thermalexpansion:frame:0>,[[<ore:ingotDesh>,<ic2:glass:0>,<ore:ingotDesh>],
																[<ic2:glass:0>,<ore:gearCobalt>,<ic2:glass:0>],
																[<ore:ingotDesh>,<ic2:glass:0>,<ore:ingotDesh>]]);//MACHINE FRAME	
recipes.addShaped(<thermalexpansion:frame:0>,[[<ore:ingotDesh>,<thermalfoundation:glass:3>,<ore:ingotDesh>],
																[<thermalfoundation:glass:3>,<ore:gearCobalt>,<thermalfoundation:glass:3>],
																[<ore:ingotDesh>,<thermalfoundation:glass:3>,<ore:ingotDesh>]]);//MACHINE FRAME	
recipes.addShaped(<thermalfoundation:material:513>,[[null,null,<actuallyadditions:item_crystal_empowered:0>],
																[null,<contenttweaker:empowered_gold_ingot>,null],
																[<actuallyadditions:item_crystal_empowered:0>,null,null]]);//REDSTONE RECEPTION COIL	
recipes.addShaped(<thermalfoundation:material:514>,[[null,null,<actuallyadditions:item_crystal_empowered:0>],
																[null,<contenttweaker:empowered_silver_ingot>,null],
																[<actuallyadditions:item_crystal_empowered:0>,null,null]]);//REDSTONE TRANSMISSION COIL														
recipes.addShaped(<thermalfoundation:material:515>,[[<actuallyadditions:item_crystal_empowered:0>,null,null],
																[null,<contenttweaker:empowered_aluminium_ingot>,null],
																[null,null,<actuallyadditions:item_crystal_empowered:0>]]);//REDSTONE CONDUCTANCE COIL																			
recipes.addShaped(<thermalexpansion:machine:1>,[[null,<actuallyadditions:block_grinder>,null],
																[<actuallyadditions:item_crystal_empowered:4>,<thermalexpansion:frame:0>,<actuallyadditions:item_crystal_empowered:4>],
																[<ore:gearArdite>,<thermalfoundation:material:513>,<ore:gearArdite>]]);//PULVERIZER
recipes.addShaped(<thermalexpansion:machine:0>,[[null,<actuallyadditions:block_furnace_double>,null],
																[<galacticraftcore:basic_block_moon:14>,<thermalexpansion:frame:0>,<galacticraftcore:basic_block_moon:14>],
																[<ore:gearArdite>,<thermalfoundation:material:513>,<ore:gearArdite>]]);//REDSTONE FURNACE
recipes.addShaped(<thermalfoundation:upgrade:0>,[[null,<ore:ingotInvar>,null],
																[<ore:ingotInvar>,<ore:gearBronze>,<ore:ingotInvar>],
																[<actuallyadditions:item_crystal_empowered:0>,<ore:ingotInvar>,<actuallyadditions:item_crystal_empowered:0>]]);//HARDENED UPGRADE KIT
recipes.addShaped(<thermalfoundation:upgrade:1>,[[null,<thermalfoundation:glass:3>,null],
																[<thermalfoundation:glass:3>,<ore:gearCarbon>,<thermalfoundation:glass:3>],
																[<actuallyadditions:item_crystal_empowered:0>,<thermalfoundation:glass:3>,<actuallyadditions:item_crystal_empowered:0>]]);//REINFORCED UPGRADE KIT
recipes.addShaped(<thermalfoundation:upgrade:2>,[[null,<ore:ingotSignalum>,null],
																[<ore:ingotSignalum>,<ore:gearPalladium>,<ore:ingotSignalum>],
																[<actuallyadditions:item_crystal_empowered:0>,<ore:ingotSignalum>,<actuallyadditions:item_crystal_empowered:0>]]);//SIGNALUM UPGRADE KIT
recipes.addShaped(<thermalfoundation:upgrade:3>,[[null,<ore:ingotEnderium>,null],
																[<ore:ingotEnderium>,<ore:gearMagnesium>,<ore:ingotEnderium>],
																[<actuallyadditions:item_crystal_empowered:0>,<ore:ingotEnderium>,<actuallyadditions:item_crystal_empowered:0>]]);//RESONANT UPGRADE KIT
recipes.addShaped(<thermalexpansion:machine:3>,[[null,<botania:manaresource:15>,null],
																[<ore:ingotDesh>,<thermalexpansion:frame:0>,<ore:ingotDesh>],
																[<ore:gearArdite>,<thermalfoundation:material:513>,<ore:gearArdite>]]);//INDUCTION SMELTER
recipes.addShaped(<thermalexpansion:machine:6>,[[null,<thermalfoundation:material:515>,null],
																[<extraplanets:mercury:0>,<thermalexpansion:frame:0>,<extraplanets:mercury:0>],
																[<ore:gearArdite>,<thermalfoundation:material:513>,<ore:gearArdite>]]);//MAGMA CRUCIBLE
recipes.addShaped(<thermalexpansion:machine:8>,[[null,<ic2:crafting:3>,null],
																[<thermalfoundation:glass:3>,<thermalexpansion:frame:0>,<thermalfoundation:glass:3>],
																[<ore:gearArdite>,<thermalfoundation:material:513>,<ore:gearArdite>]]);//FLUID TRANSPOSER
recipes.addShaped(<simplyjetpacks:metaitem:4>,[[null,null,null],
																[<minecraft:leather>,<ore:ingotMeteoricIron>,<minecraft:leather>],
																[<minecraft:leather>,<ore:ingotMeteoricIron>,<minecraft:leather>]]);//LEATHER STRAP
recipes.addShaped(<thermalexpansion:dynamo:0>,[[null,<thermalfoundation:material:514>,null],
																[<ore:ingotDesh>,<ore:gearArdite>,<ore:ingotDesh>],
																[<ore:ingotMeteoricIron>,<actuallyadditions:item_crystal_empowered:0>,<ore:ingotMeteoricIron>]]);//STEAM DYNAMO
recipes.addShaped(<simplyjetpacks:metaitemmods:26>,[[<ore:ingotMeteoricIron>,<thermalfoundation:material:513>,<ore:ingotMeteoricIron>],
																[<thermalfoundation:glass:3>,<thermalexpansion:dynamo:0>,<thermalfoundation:glass:3>],
																[<ore:ingotMeteoricIron>,<actuallyadditions:item_crystal_empowered:0>,<ore:ingotMeteoricIron>]]);//LEADSTONE THRUSTER
recipes.addShaped(<thermalexpansion:dynamo:3>,[[null,<thermalfoundation:material:514>,null],
																[<ore:ingotDesh>,<ore:gearCobalt>,<ore:ingotDesh>],
																[<ore:ingotTitanium>,<actuallyadditions:item_crystal_empowered:0>,<ore:ingotTitanium>]]);//REACTANT DYNAMO
recipes.addShaped(<simplyjetpacks:metaitemmods:27>,[[<ore:ingotDesh>,<thermalfoundation:material:513>,<ore:ingotDesh>],
																[<thermalfoundation:glass:3>,<thermalexpansion:dynamo:3>,<thermalfoundation:glass:3>],
																[<ore:ingotDesh>,<actuallyadditions:item_crystal_empowered:0>,<ore:ingotDesh>]]);//HARDENED THRUSTER
recipes.addShaped(<thermalexpansion:dynamo:1>,[[null,<thermalfoundation:material:514>,null],
																[<ore:ingotCarbon>,<ore:gearCarbon>,<ore:ingotCarbon>],
																[<ore:ingotTitanium>,<actuallyadditions:item_crystal_empowered:0>,<ore:ingotTitanium>]]);//MAGMATIC DYNAMO
recipes.addShaped(<simplyjetpacks:metaitemmods:28>,[[<ore:ingotTitanium>,<thermalfoundation:material:513>,<ore:ingotTitanium>],
																[<thermalfoundation:glass:3>,<thermalexpansion:dynamo:1>,<thermalfoundation:glass:3>],
																[<ore:ingotTitanium>,<actuallyadditions:item_crystal_empowered:0>,<ore:ingotTitanium>]]);//REINFORCED THRUSTER
recipes.addShaped(<thermalexpansion:dynamo:4>,[[null,<thermalfoundation:material:514>,null],
																[<ore:ingotCarbon>,<ore:gearPalladium>,<ore:ingotCarbon>],
																[<ore:ingotPalladium>,<actuallyadditions:item_crystal_empowered:0>,<ore:ingotPalladium>]]);//ENERVATION DYNAMO
recipes.addShaped(<simplyjetpacks:metaitemmods:29>,[[<ore:ingotEnderium>,<thermalfoundation:material:513>,<ore:ingotEnderium>],
																[<thermalfoundation:glass_alloy:7>,<thermalexpansion:dynamo:4>,<thermalfoundation:glass_alloy:7>],
																[<ore:ingotEnderium>,<actuallyadditions:item_crystal_empowered:0>,<ore:ingotEnderium>]]);//RESONANT THRUSTER
recipes.addShaped(<thermalexpansion:dynamo:2>,[[null,<thermalfoundation:material:514>,null],
																[<ore:ingotMagnesium>,<ore:gearMagnesium>,<ore:ingotMagnesium>],
																[<ore:ingotPalladium>,<actuallyadditions:item_crystal_empowered:0>,<ore:ingotPalladium>]]);//COMPRESSION DYNAMO
recipes.addShaped(<thermalexpansion:machine:2>,[[null,<thermalfoundation:material:657>,null],
																[<immersiveengineering:conveyor>,<thermalexpansion:frame:0>,<immersiveengineering:conveyor>],
																[<ore:gearArdite>,<thermalfoundation:material:513>,<ore:gearArdite>]]);//SAWMILL
recipes.addShaped(<thermaldynamics:duct_0:0>*12,[[<actuallyadditions:item_crystal:0>,<actuallyadditions:item_crystal:0>,<actuallyadditions:item_crystal:0>],
																[<ore:ingotLead>,<galacticraftcore:basic_item:13>,<ore:ingotLead>],
																[<actuallyadditions:item_crystal:0>,<actuallyadditions:item_crystal:0>,<actuallyadditions:item_crystal:0>]]);//LEADSTONE FLUXDUCT
recipes.addShaped(<thermalexpansion:capacitor:0>*4,[[null,<contenttweaker:empowered_lead_ingot>,null],
																[<contenttweaker:empowered_copper_ingot>,<actuallyadditions:item_battery_quintuple>,<contenttweaker:empowered_copper_ingot>],
																[null,<contenttweaker:empowered_lead_ingot>,null]]);//LEADSTONE CAPACITOR
recipes.addShaped(<thermaldynamics:duct_16:3>*2,[[null,null,null],
																[<minecraft:iron_ingot>,<ore:ingotLead>,<minecraft:iron_ingot>],
																[null,null,null]]);//HARDENED FLUIDUCT (OPAQUE)
recipes.addShaped(<thermaldynamics:retriever>,[[null,null,null],
																[<minecraft:iron_nugget>,<ore:ingotLead>,<minecraft:iron_nugget>],
																[<galacticraftcore:item_basic_moon:0>,<minecraft:ender_eye>,<galacticraftcore:item_basic_moon:0>]]);//RETRIEVER
recipes.addShaped(<thermaldynamics:retriever:2>,[[null,null,null],
																[<minecraft:iron_nugget>,<ore:ingotLead>,<minecraft:iron_nugget>],
																[<ore:ingotPalladium>,<minecraft:ender_eye>,<ore:ingotPalladium>]]);//RETRIEVER

recipes.addShaped(<contenttweaker:empty_fuel_cell>,[[<thermalfoundation:material:358>,<contenttweaker:terra_glass>,<thermalfoundation:material:358>],
																[<contenttweaker:terra_glass>,null,<contenttweaker:terra_glass>],
																[<thermalfoundation:material:358>,<contenttweaker:terra_glass>,<thermalfoundation:material:358>]]);//RETRIEVER
recipes.addShaped(<thermaldynamics:relay>,[[<ore:nuggetSteel>,<minecraft:quartz>,<ore:nuggetSteel>],
																[<ore:ingotLead>,<minecraft:redstone>,<ore:ingotLead>],
																]);//RELAY
recipes.addShapeless(<thermalfoundation:material:1027>*2,[<ic2:dust:15>,<ore:dustObsidian>,<ore:dustBasalz>,<ore:dustTitanium>]);//PETROTHEUM DUST
recipes.addShapeless(<thermalfoundation:material:1024>*2,[<ic2:dust:15>,<ore:dustSulfur>,<minecraft:blaze_powder>,<ore:dustCarbon>]);//PYROTHEUM DUST
recipes.addShapeless(<thermalfoundation:material:1025>*2,[<ic2:dust:15>,<actuallyadditions:item_crystal:0>,<ore:dustBlizz>,<mysticalagriculture:ice_essence>]);//CRYOTHEUM DUST
recipes.addShapeless(<thermalfoundation:material:1026>*2,[<ic2:dust:15>,<actuallyadditions:item_crystal:0>,<ore:dustBlitz>,<ore:dustSaltpeter>]);//AEROTHEUM DUST
recipes.addShapeless(<galacticraftcore:bucket_oil>,[<forge:bucketfilled>.withTag({FluidName: "crude_oil", Amount: 1000})]);//OIL
//FLUID TRANSPOSER
mods.thermalexpansion.Transposer.addFillRecipe(<thermalfoundation:ore_fluid:2>, <galacticraftcore:basic_block_moon:4>, <liquid:redstone> * 1000, 5000);
//DESTABILIZED REDSTONE ORE
mods.thermalexpansion.Transposer.addFillRecipe(<contenttweaker:grassoline_fuel_cell>, <contenttweaker:empty_fuel_cell>, <liquid:refined_biofuel> * 250, 5000);
mods.thermalexpansion.Transposer.addFillRecipe(<avaritia:resource:6>, <contenttweaker:inert_infinity_alloy>, <liquid:infinity_fluid> * 1000, 10000);
mods.thermalexpansion.InductionSmelter.addRecipe(<contenttweaker:terra_glass>, <thermalfoundation:material:1027>, <thermalfoundation:glass:3>, 5000);
mods.thermalexpansion.InductionSmelter.addRecipe(<contenttweaker:bio_napalm_cell>, <contenttweaker:grassoline_fuel_cell>, <thermalfoundation:material:832>, 5000);
mods.thermalexpansion.InductionSmelter.addRecipe(<solarflux:photovoltaic_cell_2>, <contenttweaker:empowered_silver_ingot>, <solarflux:photovoltaic_cell_1>, 10000);
mods.thermalexpansion.InductionSmelter.addRecipe(<woot:stygianironore>, <minecraft:iron_ore>, <woot:soulsanddust>, 10000);//STYGIAN IRON ORE
mods.thermalexpansion.InductionSmelter.addRecipe(<solarflux:photovoltaic_cell_3>, <thermalfoundation:material:134>, <solarflux:photovoltaic_cell_2>, 20000);
mods.thermalexpansion.Compactor.addPressRecipe(<ic2:resource:12>, <ic2:plate:3>*8, 5000);//MACHINE BLOCK
mods.thermalexpansion.Compactor.addPressRecipe(<ic2:resource:12>, <thermalfoundation:material:32>*8, 5000);//MACHINE BLOCK
mods.thermalexpansion.Compactor.addPressRecipe(<contenttweaker:duskstone_plate>, <contenttweaker:duskstone_ingot>, 5000);//DUSKSTONE PLATE
mods.thermalexpansion.Compactor.addPressRecipe(<woot:stygianironplate>, <woot:stygianironingot>, 5000);//STYGIAN IRON PLATE
mods.thermalexpansion.RedstoneFurnace.removeRecipe(<minecraft:coal>);

mods.thermalexpansion.Pulverizer.removeRecipe(<thermalfoundation:material:128>);
mods.thermalexpansion.Pulverizer.removeRecipe(<thermalfoundation:material:129>);
mods.thermalexpansion.Pulverizer.removeRecipe(<thermalfoundation:material:130>);
mods.thermalexpansion.Pulverizer.removeRecipe(<thermalfoundation:material:131>);
mods.thermalexpansion.Pulverizer.removeRecipe(<minecraft:iron_ingot>);
mods.thermalexpansion.Pulverizer.removeRecipe(<minecraft:gold_ingot>);

mods.thermalexpansion.Pulverizer.addRecipe(<thermalfoundation:material:64>, <thermalfoundation:material:128>, 2000);
mods.thermalexpansion.Pulverizer.addRecipe(<thermalfoundation:material:65>, <thermalfoundation:material:129>, 2000);
mods.thermalexpansion.Pulverizer.addRecipe(<thermalfoundation:material:66>, <thermalfoundation:material:130>, 2000);
mods.thermalexpansion.Pulverizer.addRecipe(<thermalfoundation:material:67>, <thermalfoundation:material:131>, 2000);
mods.thermalexpansion.Pulverizer.addRecipe(<minecraft:iron_ingot>, <thermalfoundation:material:0>, 2000);
mods.thermalexpansion.Pulverizer.addRecipe(<minecraft:gold_ingot>, <thermalfoundation:material:1>, 2000);

mods.thermalexpansion.Crucible.addRecipe(<liquid:nitrogen_fluid>*1000, <extraplanets:frozen_nitrogen>, 2000);