
//RECIPES
//------------------------------------------------------------------------------------------------------------
//REMOVE RECIPES
furnace.remove(<draconicevolution:draconium_ingot>, <draconicevolution:draconium_ore:*>);
recipes.remove(<draconicevolution:draconium_ingot>);
recipes.remove(<draconicevolution:draconium_dust>);
recipes.remove(<draconicevolution:draconic_core>);
mods.immersiveengineering.Crusher.removeRecipe(<draconicevolution:draconium_dust>);
mods.immersiveengineering.ArcFurnace.removeRecipe(<draconicevolution:draconium_ingot>);
mods.mekanism.enrichment.removeRecipe(<draconicevolution:draconium_ore:*>, <draconicevolution:draconium_dust>);
mods.actuallyadditions.Crusher.removeRecipe(<draconicevolution:draconium_dust>);
mods.bloodmagic.AlchemyTable.removeRecipe([<draconicevolution:draconium_ore:*>, <bloodmagic:cutting_fluid>]);
mods.thermalexpansion.RedstoneFurnace.removeRecipe(<draconicevolution:draconium_ore>);
mods.thermalexpansion.Pulverizer.removeRecipe(<draconicevolution:draconium_ore>);
mods.thermalexpansion.InductionSmelter.removeRecipe(<minecraft:sand:*>, <draconicevolution:draconium_ore>);
mods.thermalexpansion.InductionSmelter.removeRecipe(<thermalfoundation:material:865>, <draconicevolution:draconium_ore>);
mods.thermalexpansion.InductionSmelter.removeRecipe(<thermalfoundation:material:866>, <draconicevolution:draconium_ore>);
mods.astralsorcery.Grindstone.removeRecipe(<draconicevolution:draconium_dust>);
recipes.remove(<draconicevolution:crafting_injector>);//CRAFTING INJECTOR
recipes.remove(<draconicevolution:wyvern_core>);//WYVERN CORE
recipes.remove(<draconicevolution:wyvern_helm>);//WYVERN HELM
recipes.remove(<draconicevolution:wyvern_chest>);//WYVERN CHESTPLATE
recipes.remove(<draconicevolution:wyvern_legs>);//WYVERN LEGGINGS
recipes.remove(<draconicevolution:wyvern_boots>);//WYVERN BOOTS
recipes.remove(<draconicevolution:potentiometer>);//POTENTIOMETER
//ADD RECIPES
recipes.addShaped(<draconicevolution:crafting_injector>,[[<calculator:flawlessdiamond>,<draconicevolution:draconic_core>,<calculator:flawlessdiamond>],
																[<botania:shimmerrock>,<actuallyadditions:block_crystal_empowered:5>,<botania:shimmerrock>],
																[<botania:shimmerrock>,<botania:shimmerrock>,<botania:shimmerrock>]]);//CRAFTING INJECTOR
recipes.addShaped(<draconicevolution:wyvern_core>,[[<draconicevolution:draconium_ingot>,<draconicevolution:draconic_core>,<draconicevolution:draconium_ingot>],
																[<draconicevolution:draconic_core>,<contenttweaker:bloodshine_ingot>,<draconicevolution:draconic_core>],
																[<draconicevolution:draconium_ingot>,<draconicevolution:draconic_core>,<draconicevolution:draconium_ingot>]]);//WYVERN CORE
recipes.addShaped(<contenttweaker:draconium_gear>,[[null,<draconicevolution:draconium_ingot>,null],
																[<draconicevolution:draconium_ingot>,null,<draconicevolution:draconium_ingot>],
																[null,<draconicevolution:draconium_ingot>,null]]);//WYVERN CORE
recipes.addShaped(<draconicevolution:potentiometer>,[[null,<minecraft:cake>,null],
																[null,<minecraft:comparator>,null],
																[null,<minecraft:redstone_block>,null]]);//POTENTIOMETER
recipes.addShapeless(<contenttweaker:wyvern_helm_base>,[<extraplanets:zinc_helmet:*>,<redstonearsenal:armor.helmet_flux:*>,<ic2:quantum_helmet:*>,<botania:terrasteelhelm:*>,<draconicevolution:wyvern_core>,<draconicevolution:wyvern_energy_core>]);
recipes.addShapeless(<contenttweaker:wyvern_chest_base>,[<extraplanets:zinc_chest:*>,<redstonearsenal:armor.plate_flux:*>,<ic2:quantum_chestplate:*>,<botania:terrasteelchest:*>,<draconicevolution:wyvern_core>,<draconicevolution:wyvern_energy_core>]);
recipes.addShapeless(<contenttweaker:wyvern_legs_base>,[<extraplanets:zinc_legings:*>,<redstonearsenal:armor.legs_flux:*>,<ic2:quantum_leggings:*>,<botania:terrasteellegs:*>,<draconicevolution:wyvern_core>,<draconicevolution:wyvern_energy_core>]);
recipes.addShapeless(<contenttweaker:wyvern_boots_base>,[<extraplanets:zinc_boots:*>,<redstonearsenal:armor.boots_flux:*>,<ic2:quantum_boots:*>,<botania:terrasteelboots:*>,<draconicevolution:wyvern_core>,<draconicevolution:wyvern_energy_core>]);

recipes.addShapeless(<draconicevolution:draconium_ingot>*9,[<draconicevolution:draconium_block>]);
//DRACONIUM PROCESSING

mods.mekanism.chemical.dissolution.addRecipe(<draconicevolution:draconium_ore>, <gas:dirtydraconium>*800);
mods.mekanism.chemical.dissolution.addRecipe(<draconicevolution:draconium_ore:1>, <gas:dirtydraconium>*800);
mods.mekanism.chemical.dissolution.addRecipe(<draconicevolution:draconium_ore:2>, <gas:dirtydraconium>*800);
mods.mekanism.chemical.washer.addRecipe(<gas:dirtydraconium>, <gas:cleandraconium>);
mods.mekanism.chemical.crystallizer.addRecipe(<gas:cleandraconium>*200, <contenttweaker:draconium_crystal>);
mods.mekanism.chemical.injection.addRecipe(<contenttweaker:draconium_crystal>, <gas:hydrogen chloride>, <contenttweaker:draconium_shard>);
mods.mekanism.purification.addRecipe(<contenttweaker:draconium_shard>, <gas:oxygen>, <contenttweaker:draconium_clump>);
mods.mekanism.crusher.addRecipe(<contenttweaker:draconium_clump>, <contenttweaker:draconium_dustdirty>);
mods.mekanism.enrichment.addRecipe(<contenttweaker:draconium_dustdirty>, <draconicevolution:draconium_dust>);