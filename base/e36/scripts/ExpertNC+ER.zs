//REMOVE RECIPES
recipes.remove(<nuclearcraft:manufactory_idle>);//MANUFACTORY
recipes.remove(<nuclearcraft:alloy_furnace_idle>);//ALLOY FURNACE
recipes.remove(<nuclearcraft:spaxelhoe_boron>);//
recipes.remove(<nuclearcraft:spaxelhoe_hard_carbon>);//
recipes.remove(<nuclearcraft:spaxelhoe_tough>);//
recipes.remove(<nuclearcraft:spaxelhoe_boron_nitride>);//
recipes.remove(<nuclearcraft:solar_panel_basic>);//BASIC SOLAR PANEL
recipes.remove(<bigreactors:reactorcontroller>);//REACTOR CONTROLLER
recipes.remove(<nuclearcraft:fission_controller_new_fixed>);//FISSION CONTROLLER
recipes.remove(<nuclearcraft:decay_generator>);//DECAY GENERATOR
mods.astralsorcery.Grindstone.removeRecipe(<ic2:dust:11>);
mods.actuallyadditions.Crusher.removeRecipe(<ic2:dust:11>);
mods.immersiveengineering.ArcFurnace.removeRecipe(<nuclearcraft:ingot:6>);
mods.immersiveengineering.Crusher.removeRecipe(<ic2:dust:11>);

//ADD RECIPES
recipes.addShaped(<nuclearcraft:manufactory_idle>,[[<contenttweaker:empowered_lead_ingot>,<nuclearcraft:part:4>,<contenttweaker:empowered_lead_ingot>],
																[<ore:itemSlagRich>,<mekanism:basicblock:8>,<ore:itemSlagRich>],
																[<contenttweaker:empowered_lead_ingot>,<nuclearcraft:part:4>,<contenttweaker:empowered_lead_ingot>]]);//MANUFACTORY
recipes.addShaped(<nuclearcraft:alloy_furnace_idle>,[[<contenttweaker:empowered_copper_ingot>,<nuclearcraft:part:4>,<contenttweaker:empowered_copper_ingot>],
																[<ore:ingotInvar>,<mekanism:basicblock:8>,<ore:ingotInvar>],
																[<contenttweaker:empowered_copper_ingot>,<nuclearcraft:part:4>,<contenttweaker:empowered_copper_ingot>]]);//ALLOY FURNACE
recipes.addShaped(<bigreactors:reactorcontroller>,[[<bigreactors:reactorcasing>,<ore:ingotYellorium>,<bigreactors:reactorcasing>],
																[<ore:ingotYellorium>,<galacticraftplanets:basic_item_venus:2>,<ore:ingotYellorium>],
																[<bigreactors:reactorcasing>,<nuclearcraft:part:5>,<bigreactors:reactorcasing>]]);//REACTOR CONTROLLER
recipes.addShaped(<nuclearcraft:fission_controller_new_fixed>,[[<nuclearcraft:part:1>,<nuclearcraft:part:5>,<nuclearcraft:part:1>],
																[<nuclearcraft:nuclear_furnace_idle>,<galacticraftplanets:basic_item_venus:2>,<nuclearcraft:nuclear_furnace_idle>],
																[<nuclearcraft:part:1>,<nuclearcraft:part:5>,<nuclearcraft:part:1>]]);//FISSION CONTROLLER
furnace.remove(<*>, <ore:oreBoron>);// Boron Ore
furnace.remove(<*>, <ore:oreLithium>);// Lithium Ore