import mods.modularmachinery.RecipeBuilder;


// related machine upgrades


mods.extendedcrafting.TableCrafting.addShaped(<contenttweaker:darkstar_collector>, 
[[<contenttweaker:darkstar_stone>, <contenttweaker:darkstar_stone>, <nuclearcraft:block_depleted_curium>, <contenttweaker:darkstar_stone>, <contenttweaker:darkstar_stone>], 
[<contenttweaker:darkstar_stone>, <contenttweaker:darkstar_stone>, <contenttweaker:darkstar_stone>, <contenttweaker:darkstar_stone>, <contenttweaker:darkstar_stone>], 
[<contenttweaker:darkstar_stone>, <contenttweaker:darkstar_stone>, <contenttweaker:darkstar_catalyst>, <contenttweaker:darkstar_stone>, <contenttweaker:darkstar_stone>], 
[<contenttweaker:darkstar_stone>, <contenttweaker:darkstar_stone>, <contenttweaker:darkstar_stone>, <contenttweaker:darkstar_stone>, <contenttweaker:darkstar_stone>], 
[<contenttweaker:darkstar_stone>, <contenttweaker:darkstar_stone>, <contenttweaker:optical_event_horizon>, <contenttweaker:darkstar_stone>, <contenttweaker:darkstar_stone>]]);  

mods.extendedcrafting.TableCrafting.addShaped(<contenttweaker:elemental_harmonizer>, 
[[<ebwizardry:grand_crystal>, <ebwizardry:grand_crystal>, <contenttweaker:master_wizardry_catalyst>, <ebwizardry:grand_crystal>, <ebwizardry:grand_crystal>], 
[<ebwizardry:grand_crystal>, <ebwizardry:grand_crystal>, <contenttweaker:master_wizardry_catalyst>, <ebwizardry:grand_crystal>, <ebwizardry:grand_crystal>], 
[<ebwizardry:grand_crystal>, <ebwizardry:grand_crystal>, <contenttweaker:optical_event_horizon>, <ebwizardry:grand_crystal>, <ebwizardry:grand_crystal>], 
[<ebwizardry:grand_crystal>, <ebwizardry:grand_crystal>, <contenttweaker:master_wizardry_catalyst>, <ebwizardry:grand_crystal>, <ebwizardry:grand_crystal>], 
[<ebwizardry:grand_crystal>, <ebwizardry:grand_crystal>, <contenttweaker:master_wizardry_catalyst>, <ebwizardry:grand_crystal>, <ebwizardry:grand_crystal>]]);  


// actual line

val gallifreymirrror = RecipeBuilder.newBuilder("gallifreymirrror","gravitational_collapser",200);
gallifreymirrror.addEnergyPerTickInput(1111111);
gallifreymirrror.addItemInput(<contenttweaker:eye_of_gallifrey>*16);
gallifreymirrror.addItemInput(<contenttweaker:rainbow_lens>*16);
gallifreymirrror.addItemInput(<contenttweaker:mythic_excavation_engine>*8);
gallifreymirrror.addItemInput(<contenttweaker:high_strength_transmission>*4);
gallifreymirrror.addItemInput(<contenttweaker:dynatos_catalyst>);
gallifreymirrror.addItemOutput(<contenttweaker:optical_event_horizon>);
gallifreymirrror.build();

val plasmahalite = RecipeBuilder.newBuilder("plasmahalite","plasmatic_condenser",20);
plasmahalite.addFluidInput(<fluid:halite_fluid>*500);
plasmahalite.addItemInput(<contenttweaker:definer_core>*8);
plasmahalite.addItemInput(<contenttweaker:lawrencium_262>*8);
plasmahalite.addItemInput(<contenttweaker:time_crystal>*8);
plasmahalite.addItemInput(<contenttweaker:horcrux>*4);
plasmahalite.addItemInput(<contenttweaker:recursium_ingot>*2);
plasmahalite.addItemInput(<contenttweaker:optical_event_horizon>);
plasmahalite.addItemInput(<extrabotany:lens:6>);
plasmahalite.addItemOutput(<contenttweaker:gallifrey_fabrial>);
plasmahalite.build();

val creationwarren = RecipeBuilder.newBuilder("creationwarren","creation_altar",20);
creationwarren.addEnergyPerTickInput(400000);
creationwarren.addFluidInput(<fluid:darkstarlight>*100);
creationwarren.addFluidInput(<fluid:sacrificial_essence>*100);
creationwarren.addFluidInput(<fluid:pristine_aura>*100);
creationwarren.addFluidInput(<fluid:strange_matter>*100);
creationwarren.addItemInput(<contenttweaker:warren_shard>*4);
creationwarren.addItemInput(<contenttweaker:essence_of_the_mythic_shells>);
creationwarren.addItemOutput(<contenttweaker:warren_rift>);
creationwarren.build();



mods.extendedcrafting.TableCrafting.addShaped(<contenttweaker:halite_imbuement_fabrial>, 
[[<contenttweaker:perfected_gallifreyan_plate>, <thaumcraft:mechanism_complex>, <tconstruct:large_plate>.withTag({Material: "manyullyn"}), <thaumcraft:mechanism_complex>, <contenttweaker:perfected_gallifreyan_plate>], 
[<thaumcraft:mechanism_complex>, <contenttweaker:ancient_recursion>, <contenttweaker:halite_warrior>, <contenttweaker:primordial_recursion>, <thaumcraft:mechanism_complex>], 
[<tconstruct:large_plate>.withTag({Material: "manyullyn"}), <contenttweaker:halite_warrior>, <contenttweaker:gallifrey_fabrial>, <contenttweaker:halite_warrior>, <tconstruct:large_plate>.withTag({Material: "manyullyn"})], 
[<thaumcraft:mechanism_complex>, <contenttweaker:immortal_recursion>, <contenttweaker:halite_warrior>, <contenttweaker:temporal_recursion>, <thaumcraft:mechanism_complex>], 
[<contenttweaker:perfected_gallifreyan_plate>, <thaumcraft:mechanism_complex>, <tconstruct:large_plate>.withTag({Material: "manyullyn"}), <thaumcraft:mechanism_complex>, <contenttweaker:perfected_gallifreyan_plate>]]);  

mods.extendedcrafting.TableCrafting.addShaped(<contenttweaker:pure_halite_cluster>, 

[[<contenttweaker:first_order_ascended_fractal>, null, null, <contenttweaker:warren_rift>, null, <contenttweaker:warren_rift>, null, null, <contenttweaker:first_order_ascended_fractal>], 

[null, <contenttweaker:second_order_ascended_fractal>, null, null, <contenttweaker:fifth_order_ascended_fractal>, null, null, <contenttweaker:second_order_ascended_fractal>, null], 

[null, null, <contenttweaker:third_order_ascended_fractal>, null, null, null, <contenttweaker:third_order_ascended_fractal>, null, null], 

[<contenttweaker:warren_rift>, null, null, <contenttweaker:fourth_order_ascended_fractal>, null, <contenttweaker:fourth_order_ascended_fractal>, null, null, <contenttweaker:warren_rift>], 

[null, <contenttweaker:fifth_order_ascended_fractal>, null, null, <contenttweaker:halite_imbuement_fabrial>, null, null, <contenttweaker:fifth_order_ascended_fractal>, null], 

[<contenttweaker:warren_rift>, null, null, <contenttweaker:fourth_order_ascended_fractal>, null, <contenttweaker:fourth_order_ascended_fractal>, null, null, <contenttweaker:warren_rift>], 

[null, null, <contenttweaker:third_order_ascended_fractal>, null, null, null, <contenttweaker:third_order_ascended_fractal>, null, null], 

[null, <contenttweaker:second_order_ascended_fractal>, null, null, <contenttweaker:fifth_order_ascended_fractal>, null, null, <contenttweaker:second_order_ascended_fractal>, null], 

[<contenttweaker:first_order_ascended_fractal>, null, null, <contenttweaker:warren_rift>, null, <contenttweaker:warren_rift>, null, null, <contenttweaker:first_order_ascended_fractal>]]);  


mods.extendedcrafting.TableCrafting.addShaped(<contenttweaker:core_of_halite_definition>, 
[[<ore:ingotFractalliteHalite>, null, <contenttweaker:well_defined_machine_case>, null, <ore:ingotFractalliteHalite>], 
[null, <contenttweaker:defined_block>, null, <contenttweaker:defined_block>, null], 
[<contenttweaker:well_defined_machine_case>, null, <avaritia:block_resource:1>, null, <contenttweaker:well_defined_machine_case>], 
[null, <contenttweaker:defined_block>, null, <contenttweaker:defined_block>, null], 
[<ore:ingotFractalliteHalite>, null, <contenttweaker:well_defined_machine_case>, null, <ore:ingotFractalliteHalite>]]);  


mods.extendedcrafting.CombinationCrafting.addRecipe(<contenttweaker:greater_gaia_spirit>, 
100000, <contenttweaker:lesser_mana_core>, 
[<botania:manaresource:14>, <botania:manaresource:14>,
<aoa3:shyregem>, <aoa3:shyregem>,
<ore:ingotShadowium>, <ore:ingotShadowium>,
<ore:ingotShadowium>, <ore:ingotShadowium>,
<ore:ingotPhotonium>, <ore:ingotPhotonium>,
<ore:ingotPhotonium>, <ore:ingotPhotonium>]);
