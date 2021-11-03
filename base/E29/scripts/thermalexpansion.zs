import mods.thermalexpansion.Transposer;
import mods.thermalexpansion.Pulverizer;
import mods.thermalexpansion.InductionSmelter;

//Transposer
mods.thermalexpansion.Transposer.addFillRecipe(<enderio:item_material:20>, <contenttweaker:infinity_fragment>, <liquid:aerotheum> * 200, 3000);

mods.thermalexpansion.Transposer.addFillRecipe(<minecraft:coal>, <minecraft:coal:1>, <liquid:purified_water> * 100, 500);

mods.thermalexpansion.Transposer.addFillRecipe(<modularforcefieldsystem:forcicium>, <embers:crystal_ember>, <liquid:nutrient_distillation> * 200, 1500);

mods.thermalexpansion.Transposer.addFillRecipe(<extendedcrafting:material:33>, <minecraft:gold_ingot>, <liquid:hootch> * 10000, 150000);

mods.thermalexpansion.Transposer.addFillRecipe(<environmentaltech:photovoltaic_cell>, <enderio:item_material:3>, <liquid:redstone> * 500, 16000);

mods.thermalexpansion.Transposer.addFillRecipe(<enderio:item_cold_fire_igniter>, <minecraft:flint_and_steel>, <liquid:cryotheum> * 1000, 32000);

mods.thermalexpansion.Transposer.addFillRecipe(<enderio:item_basic_capacitor>, <contenttweaker:emptycap>, <liquid:redstone> * 500, 8000);

mods.thermalexpansion.Transposer.addFillRecipe(<enderio:item_basic_capacitor:1>, <contenttweaker:emptycap>, <liquid:petrotheum> * 500, 16000);

mods.thermalexpansion.Transposer.addFillRecipe(<enderio:item_alloy_ingot:1>, <enderio:item_alloy_ingot:9>, <liquid:redstone> * 250, 16000);

mods.thermalexpansion.Transposer.addFillRecipe(<enderio:item_basic_capacitor:2>, <contenttweaker:emptycap>, <liquid:vapor_of_levity> * 500, 16000);

mods.thermalexpansion.Transposer.addFillRecipe(<thermalfoundation:material:167>, <enderio:item_material:39>, <liquid:ender> * 250, 16000);

mods.thermalexpansion.Transposer.addFillRecipe(<enderio:item_material:14>, <contenttweaker:diamond_chunk>, <liquid:ender> * 250, 16000);

mods.thermalexpansion.Transposer.addFillRecipe(<enderio:item_material:15>, <contenttweaker:emerald_chunk>, <liquid:ender> * 250, 16000);

mods.thermalexpansion.Transposer.addFillRecipe(<enderio:block_tele_pad>, <enderio:item_material:1>, <liquid:vapor_of_levity> * 250, 16000);

//Pulverizer
mods.thermalexpansion.Pulverizer.addRecipe(<contenttweaker:infinity_shard> * 2, <redstone_lock:infinityore>, 3500, <contenttweaker:infinity_shard>, 70);

mods.thermalexpansion.Pulverizer.addRecipe(<contenttweaker:infinity_fragment> * 4, <contenttweaker:infinity_shard>, 3500, <thermalfoundation:material:771>, 70);

//Induction Smelter
mods.thermalexpansion.InductionSmelter.addRecipe(<enderio:item_material:39>, <thermalfoundation:material:131>, <thermalfoundation:material:134>, 3500);

//Magma Crucible
mods.thermalexpansion.Crucible.removeRecipe(<minecraft:ice>);
mods.thermalexpansion.Crucible.addRecipe(<liquid:xpjuice> * 5, <rats:assorted_vegetables>, 500);
mods.thermalexpansion.Crucible.addRecipe(<liquid:solder> * 250, <contenttweaker:wire_solder>, 500);
mods.thermalexpansion.Crucible.addRecipe(<liquid:glue> * 500, <embers:adhesive>, 500);
mods.thermalexpansion.Crucible.addRecipe(<liquid:purified_water> * 250, <minecraft:ice>, 500);

//Compactor
mods.thermalexpansion.Compactor.addStorageRecipe(<redstone_lock:farmgoodscrate>, <rats:assorted_vegetables> * 15, 5000);
mods.thermalexpansion.Compactor.addStorageRecipe(<redstone_lock:farmgoodsbin>, <redstone_lock:farmgoodscrate> * 15, 25000);
mods.thermalexpansion.Compactor.addStorageRecipe(<minecraft:diamond>, <minecraft:coal_block> * 9, 2500000);
mods.thermalexpansion.Compactor.addStorageRecipe(<minecraft:emerald>, <minecraft:prismarine:1> * 9, 2500000);