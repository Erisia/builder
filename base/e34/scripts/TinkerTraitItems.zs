#loader contenttweaker

import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Item;
import mods.contenttweaker.IItemRightClick;
import mods.contenttweaker.Commands;
import mods.contenttweaker.ResourceLocation;


var instanceTEX = mods.contenttweaker.ResourceLocation.create("contenttweaker:textures/items/trait_inferno.png");

  

var trait_alien = VanillaFactory.createItem("trait_alien");	  trait_alien.register();
var trait_antiair = VanillaFactory.createItem("trait_antiair");	  trait_antiair.register();
var trait_anticorrosion = VanillaFactory.createItem("trait_anticorrosion");	  trait_anticorrosion.register();
var trait_apocalypse = VanillaFactory.createItem("trait_apocalypse");	  trait_apocalypse.register();
var trait_aquadynamic = VanillaFactory.createItem("trait_aquadynamic");	  trait_aquadynamic.register();
var trait_aridiculous = VanillaFactory.createItem("trait_aridiculous");	  trait_aridiculous.register();
var trait_autosmelt = VanillaFactory.createItem("trait_autosmelt");	  trait_autosmelt.register();
var trait_baconlicious = VanillaFactory.createItem("trait_baconlicious");	  trait_baconlicious.register();
var trait_baron = VanillaFactory.createItem("trait_baron");	  trait_baron.register();
var trait_blazing = VanillaFactory.createItem("trait_blazing");	  trait_blazing.register();
var trait_blind_bandit = VanillaFactory.createItem("trait_blind_bandit");	  trait_blind_bandit.register();
var trait_blizzard = VanillaFactory.createItem("trait_blizzard");	  trait_blizzard.register();
var trait_bloodlust = VanillaFactory.createItem("trait_bloodlust");	  trait_bloodlust.register();
var trait_body = VanillaFactory.createItem("trait_body");	  trait_body.register();
var trait_bone_shock = VanillaFactory.createItem("trait_bone_shock");	  trait_bone_shock.register();
var trait_botanical = VanillaFactory.createItem("trait_botanical");	  trait_botanical.register();
var trait_broodmother = VanillaFactory.createItem("trait_broodmother");	  trait_broodmother.register();
var trait_brown_magic = VanillaFactory.createItem("trait_brown_magic");	  trait_brown_magic.register();
var trait_chad_thunder = VanillaFactory.createItem("trait_chad_thunder");	  trait_chad_thunder.register();
var trait_cheap = VanillaFactory.createItem("trait_cheap");	  trait_cheap.register();
var trait_cheapskate = VanillaFactory.createItem("trait_cheapskate");	  trait_cheapskate.register();
var trait_chunky = VanillaFactory.createItem("trait_chunky");	  trait_chunky.register();
var trait_coldblooded = VanillaFactory.createItem("trait_coldblooded");	  trait_coldblooded.register();
var trait_coraliumplagued = VanillaFactory.createItem("trait_coraliumplagued");	  trait_coraliumplagued.register();
var trait_counterweight = VanillaFactory.createItem("trait_counterweight");	  trait_counterweight.register();
var trait_critikill = VanillaFactory.createItem("trait_critikill");	  trait_critikill.register();
var trait_crude = VanillaFactory.createItem("trait_crude");	  trait_crude.register();
var trait_crumbling = VanillaFactory.createItem("trait_crumbling");	  trait_crumbling.register();
var trait_dark_traveler = VanillaFactory.createItem("trait_dark_traveler");	  trait_dark_traveler.register();
var trait_darkness = VanillaFactory.createItem("trait_darkness");	  trait_darkness.register();
var trait_democratic_peoples_republic_of_korea = VanillaFactory.createItem("trait_democratic_peoples_republic_of_korea");	  trait_democratic_peoples_republic_of_korea.register();
var trait_dense = VanillaFactory.createItem("trait_dense");	  trait_dense.register();
var trait_devils_strength = VanillaFactory.createItem("trait_devils_strength");	  trait_devils_strength.register();
var trait_direct = VanillaFactory.createItem("trait_direct");	  trait_direct.register();
var trait_discounted = VanillaFactory.createItem("trait_discounted");	  trait_discounted.register();
var trait_dreadplagued = VanillaFactory.createItem("trait_dreadplagued");	  trait_dreadplagued.register();
var trait_duritae = VanillaFactory.createItem("trait_duritae");	  trait_duritae.register();
var trait_ecological = VanillaFactory.createItem("trait_ecological");	  trait_ecological.register();
var trait_elemental = VanillaFactory.createItem("trait_elemental");	  trait_elemental.register();
var trait_enderference = VanillaFactory.createItem("trait_enderference");	  trait_enderference.register();
var trait_endspeed = VanillaFactory.createItem("trait_endspeed");	  trait_endspeed.register();
var trait_energy_eater = VanillaFactory.createItem("trait_energy_eater");	  trait_energy_eater.register();
var trait_energy_repair = VanillaFactory.createItem("trait_energy_repair");	  trait_energy_repair.register();
var trait_ethereal_miner = VanillaFactory.createItem("trait_ethereal_miner");	  trait_ethereal_miner.register();
var trait_evil_aura = VanillaFactory.createItem("trait_evil_aura");	  trait_evil_aura.register();
var trait_evil_pressure = VanillaFactory.createItem("trait_evil_pressure");	  trait_evil_pressure.register();
var trait_experience_boost = VanillaFactory.createItem("trait_experience_boost");	  trait_experience_boost.register();
var trait_famine = VanillaFactory.createItem("trait_famine");	  trait_famine.register();
var trait_flaming_fury = VanillaFactory.createItem("trait_flaming_fury");	  trait_flaming_fury.register();
var trait_flammable = VanillaFactory.createItem("trait_flammable");	  trait_flammable.register();
var trait_fractured = VanillaFactory.createItem("trait_fractured");	  trait_fractured.register();
var trait_freezing = VanillaFactory.createItem("trait_freezing");	  trait_freezing.register();
var trait_fruit_salad = VanillaFactory.createItem("trait_fruit_salad");	  trait_fruit_salad.register();
var trait_ghastly = VanillaFactory.createItem("trait_ghastly");	  trait_ghastly.register();
var trait_glitch = VanillaFactory.createItem("trait_glitch");	  trait_glitch.register();
var trait_global_traveler = VanillaFactory.createItem("trait_global_traveler");	  trait_global_traveler.register();
var trait_glowing = VanillaFactory.createItem("trait_glowing");	  trait_glowing.register();
var trait_hail_hydra = VanillaFactory.createItem("trait_hail_hydra");	  trait_hail_hydra.register();
var trait_he_who_must_not_be_named = VanillaFactory.createItem("trait_he_who_must_not_be_named");	  trait_he_who_must_not_be_named.register();
var trait_healer = VanillaFactory.createItem("trait_healer");	  trait_healer.register();
var trait_heavy = VanillaFactory.createItem("trait_heavy");	  trait_heavy.register();
var trait_hellish = VanillaFactory.createItem("trait_hellish");	  trait_hellish.register();
var trait_high_in_calcium = VanillaFactory.createItem("trait_high_in_calcium");	  trait_high_in_calcium.register();
var trait_hive_defender = VanillaFactory.createItem("trait_hive_defender");	  trait_hive_defender.register();
var trait_holy = VanillaFactory.createItem("trait_holy");	  trait_holy.register();
var trait_illuminati = VanillaFactory.createItem("trait_illuminati");	trait_illuminati.textureLocation = instanceTEX;  trait_illuminati.register();
var trait_im_a_superstar = VanillaFactory.createItem("trait_im_a_superstar");	trait_im_a_superstar.textureLocation = instanceTEX;  trait_im_a_superstar.register();
var trait_infernal_energy = VanillaFactory.createItem("trait_infernal_energy");	trait_infernal_energy.textureLocation = instanceTEX;  trait_infernal_energy.register();
var trait_inferno = VanillaFactory.createItem("trait_inferno");	trait_inferno.textureLocation = instanceTEX;  trait_inferno.register();
var trait_insatiable = VanillaFactory.createItem("trait_insatiable");	trait_insatiable.textureLocation = instanceTEX;  trait_insatiable.register();
var trait_instakill = VanillaFactory.createItem("trait_instakill");	trait_instakill.textureLocation = instanceTEX;  trait_instakill.register();
var trait_jaded = VanillaFactory.createItem("trait_jaded");	trait_jaded.textureLocation = instanceTEX;  trait_jaded.register();
var trait_jagged = VanillaFactory.createItem("trait_jagged");	trait_jagged.textureLocation = instanceTEX;  trait_jagged.register();
var trait_laced = VanillaFactory.createItem("trait_laced");	trait_laced.textureLocation = instanceTEX;  trait_laced.register();
var trait_launch = VanillaFactory.createItem("trait_launch");	trait_launch.textureLocation = instanceTEX;  trait_launch.register();
var trait_lightweight = VanillaFactory.createItem("trait_lightweight");	trait_lightweight.textureLocation = instanceTEX;  trait_lightweight.register();
var trait_living = VanillaFactory.createItem("trait_living");	trait_living.textureLocation = instanceTEX;  trait_living.register();
var trait_magically_brittle = VanillaFactory.createItem("trait_magically_brittle");	trait_magically_brittle.textureLocation = instanceTEX;  trait_magically_brittle.register();
var trait_magically_modifiable = VanillaFactory.createItem("trait_magically_modifiable");	trait_magically_modifiable.textureLocation = instanceTEX;  trait_magically_modifiable.register();
var trait_magnetic = VanillaFactory.createItem("trait_magnetic");	trait_magnetic.textureLocation = instanceTEX;  trait_magnetic.register();
var trait_mana = VanillaFactory.createItem("trait_mana");	trait_mana.textureLocation = instanceTEX;  trait_mana.register();
var trait_mana_eater = VanillaFactory.createItem("trait_mana_eater");	trait_mana_eater.textureLocation = instanceTEX;  trait_mana_eater.register();
var trait_mana_repair = VanillaFactory.createItem("trait_mana_repair");	trait_mana_repair.textureLocation = instanceTEX;  trait_mana_repair.register();
var trait_mind = VanillaFactory.createItem("trait_mind");	trait_mind.textureLocation = instanceTEX;  trait_mind.register();
var trait_mirabile_visu = VanillaFactory.createItem("trait_mirabile_visu");	trait_mirabile_visu.textureLocation = instanceTEX;  trait_mirabile_visu.register();
var trait_moldable = VanillaFactory.createItem("trait_moldable");	trait_moldable.textureLocation = instanceTEX;  trait_moldable.register();
var trait_momentum = VanillaFactory.createItem("trait_momentum");	trait_momentum.textureLocation = instanceTEX;  trait_momentum.register();
var trait_morgan_le_fay = VanillaFactory.createItem("trait_morgan_le_fay");	trait_morgan_le_fay.textureLocation = instanceTEX;  trait_morgan_le_fay.register();
var trait_music_of_the_spheres = VanillaFactory.createItem("trait_music_of_the_spheres");	trait_music_of_the_spheres.textureLocation = instanceTEX;  trait_music_of_the_spheres.register();
var trait_natures_blessing = VanillaFactory.createItem("trait_natures_blessing");	trait_natures_blessing.textureLocation = instanceTEX;  trait_natures_blessing.register();
var trait_natures_power = VanillaFactory.createItem("trait_natures_power");	trait_natures_power.textureLocation = instanceTEX;  trait_natures_power.register();
var trait_natures_wrath = VanillaFactory.createItem("trait_natures_wrath"); trait_natures_wrath.textureLocation = instanceTEX;  	trait_natures_wrath.register();
var trait_overflow = VanillaFactory.createItem("trait_overflow");	trait_overflow.textureLocation = instanceTEX;  trait_overflow.register();
var trait_payback = VanillaFactory.createItem("trait_payback");	trait_payback.textureLocation = instanceTEX;  trait_payback.register();
var trait_petramor = VanillaFactory.createItem("trait_petramor");	trait_petramor.textureLocation = instanceTEX;  trait_petramor.register();
var trait_poisonous = VanillaFactory.createItem("trait_poisonous");	trait_poisonous.textureLocation = instanceTEX;  trait_poisonous.register();
var trait_portly_gentleman = VanillaFactory.createItem("trait_portly_gentleman");	trait_portly_gentleman.textureLocation = instanceTEX;  trait_portly_gentleman.register();
var trait_power_of_the_sun = VanillaFactory.createItem("trait_power_of_the_sun");	trait_power_of_the_sun.textureLocation = instanceTEX;  trait_power_of_the_sun.register();
var trait_precipitate = VanillaFactory.createItem("trait_precipitate");	trait_precipitate.textureLocation = instanceTEX;  trait_precipitate.register();
var trait_prickly = VanillaFactory.createItem("trait_prickly");	trait_prickly.textureLocation = instanceTEX;  trait_prickly.register();
var trait_prosperous = VanillaFactory.createItem("trait_prosperous");	trait_prosperous.textureLocation = instanceTEX;  trait_prosperous.register();
var trait_psi_eater = VanillaFactory.createItem("trait_psi_eater");	trait_psi_eater.textureLocation = instanceTEX;  trait_psi_eater.register();
var trait_psi_repair = VanillaFactory.createItem("trait_psi_repair");	trait_psi_repair.textureLocation = instanceTEX;  trait_psi_repair.register();
var trait_purified = VanillaFactory.createItem("trait_purified");	trait_purified.textureLocation = instanceTEX;  trait_purified.register();
var trait_radioactive = VanillaFactory.createItem("trait_radioactive");	trait_radioactive.textureLocation = instanceTEX;  trait_radioactive.register();
var trait_reflect = VanillaFactory.createItem("trait_reflect");	trait_reflect.textureLocation = instanceTEX;  trait_reflect.register();
var trait_rude_awakening = VanillaFactory.createItem("trait_rude_awakening");	trait_rude_awakening.textureLocation = instanceTEX;  trait_rude_awakening.register();
var trait_runic = VanillaFactory.createItem("trait_runic");	trait_runic.textureLocation = instanceTEX;  trait_runic.register();
var trait_shadow = VanillaFactory.createItem("trait_shadow");	trait_shadow.textureLocation = instanceTEX;  trait_shadow.register();
var trait_sharp = VanillaFactory.createItem("trait_sharp");	trait_sharp.textureLocation = instanceTEX;  trait_sharp.register();
var trait_shock = VanillaFactory.createItem("trait_shock");	trait_shock.textureLocation = instanceTEX;  trait_shock.register();
var trait_shocking = VanillaFactory.createItem("trait_shocking");	trait_shocking.textureLocation = instanceTEX;  trait_shocking.register();
var trait_shyre_synthesis = VanillaFactory.createItem("trait_shyre_synthesis");	trait_shyre_synthesis.textureLocation = instanceTEX;  trait_shyre_synthesis.register();
var trait_slashing = VanillaFactory.createItem("trait_slashing");	trait_slashing.textureLocation = instanceTEX;  trait_slashing.register();
var trait_slimey = VanillaFactory.createItem("trait_slimey");	trait_slimey.textureLocation = instanceTEX;  trait_slimey.register();
var trait_slingshot = VanillaFactory.createItem("trait_slingshot");	trait_slingshot.textureLocation = instanceTEX;  trait_slingshot.register();
var trait_sos = VanillaFactory.createItem("trait_sos");	trait_sos.textureLocation = instanceTEX;  trait_sos.register();
var trait_soul = VanillaFactory.createItem("trait_soul");	trait_soul.textureLocation = instanceTEX;  trait_soul.register();
var trait_soul_harvest = VanillaFactory.createItem("trait_soul_harvest");	trait_soul_harvest.textureLocation = instanceTEX;  trait_soul_harvest.register();
var trait_soul_sap = VanillaFactory.createItem("trait_soul_sap");	trait_soul_sap.textureLocation = instanceTEX;  trait_soul_sap.register();
var trait_spades = VanillaFactory.createItem("trait_spades");	trait_spades.textureLocation = instanceTEX;  trait_spades.register();
var trait_spiky = VanillaFactory.createItem("trait_spiky");	trait_spiky.textureLocation = instanceTEX;  trait_spiky.register();
var trait_splintering = VanillaFactory.createItem("trait_splintering");	trait_splintering.textureLocation = instanceTEX;  trait_splintering.register();
var trait_splinters = VanillaFactory.createItem("trait_splinters");	trait_splinters.textureLocation = instanceTEX;  trait_splinters.register();
var trait_squeaky = VanillaFactory.createItem("trait_squeaky");	trait_squeaky.textureLocation = instanceTEX;  trait_squeaky.register();
var trait_stalwart = VanillaFactory.createItem("trait_stalwart");	trait_stalwart.textureLocation = instanceTEX;  trait_stalwart.register();
var trait_starfishy = VanillaFactory.createItem("trait_starfishy");	trait_starfishy.textureLocation = instanceTEX;  trait_starfishy.register();
var trait_stiff = VanillaFactory.createItem("trait_stiff");	trait_stiff.textureLocation = instanceTEX;  trait_stiff.register();
var trait_stonebound = VanillaFactory.createItem("trait_stonebound");	trait_stonebound.textureLocation = instanceTEX;  trait_stonebound.register();
var trait_stop_being_selfish = VanillaFactory.createItem("trait_stop_being_selfish");	trait_stop_being_selfish.textureLocation = instanceTEX;  trait_stop_being_selfish.register();
var trait_superheat = VanillaFactory.createItem("trait_superheat");	trait_superheat.textureLocation = instanceTEX;  trait_superheat.register();
var trait_tasty = VanillaFactory.createItem("trait_tasty");	trait_tasty.textureLocation = instanceTEX;  trait_tasty.register();
var trait_terrafirma = VanillaFactory.createItem("trait_terrafirma");	trait_terrafirma.textureLocation = instanceTEX;  trait_terrafirma.register();
var trait_thaumic = VanillaFactory.createItem("trait_thaumic"); trait_thaumic.textureLocation = instanceTEX;  	trait_thaumic.register();
var trait_thermal_inversion = VanillaFactory.createItem("trait_thermal_inversion");	trait_thermal_inversion.textureLocation = instanceTEX;  trait_thermal_inversion.register();
var trait_toxic = VanillaFactory.createItem("trait_toxic");	trait_toxic.textureLocation = instanceTEX;  trait_toxic.register();
var trait_tweeting = VanillaFactory.createItem("trait_tweeting");	trait_tweeting.textureLocation = instanceTEX;  trait_tweeting.register();
var trait_twilit = VanillaFactory.createItem("trait_twilit");	trait_twilit.textureLocation = instanceTEX;  trait_twilit.register();
var trait_unholy_touch = VanillaFactory.createItem("trait_unholy_touch");	trait_unholy_touch.textureLocation = instanceTEX;  trait_unholy_touch.register();
var trait_unnatural = VanillaFactory.createItem("trait_unnatural");	trait_unnatural.textureLocation = instanceTEX;  trait_unnatural.register();
var trait_uplifting = VanillaFactory.createItem("trait_uplifting");	trait_uplifting.textureLocation = instanceTEX;  trait_uplifting.register();
var trait_vanishing = VanillaFactory.createItem("trait_vanishing"); trait_vanishing.textureLocation = instanceTEX;  	trait_vanishing.register();
var trait_vile = VanillaFactory.createItem("trait_vile");	trait_vile.textureLocation = instanceTEX;  trait_vile.register();
var trait_vindictive = VanillaFactory.createItem("trait_vindictive");	trait_vindictive.textureLocation = instanceTEX;  trait_vindictive.register();
var trait_weeee = VanillaFactory.createItem("trait_weeee");	trait_weeee.textureLocation = instanceTEX;  trait_weeee.register();
var trait_wellestablished = VanillaFactory.createItem("trait_wellestablished");	trait_wellestablished.textureLocation = instanceTEX;  trait_wellestablished.register();
var trait_whispering = VanillaFactory.createItem("trait_whispering");	trait_whispering.textureLocation = instanceTEX;  trait_whispering.register();
var trait_withering = VanillaFactory.createItem("trait_withering");	trait_withering.textureLocation = instanceTEX;  trait_withering.register();
var trait_writable = VanillaFactory.createItem("trait_writable");	trait_writable.textureLocation = instanceTEX;  trait_writable.register();
var trait_bloody_mary = VanillaFactory.createItem("trait_bloody_mary");	trait_bloody_mary.textureLocation = instanceTEX;  trait_bloody_mary.register();
var trait_synergy = VanillaFactory.createItem("trait_synergy");	trait_synergy.textureLocation = instanceTEX;  trait_synergy.register();
var trait_antigravity = VanillaFactory.createItem("trait_antigravity");	trait_antigravity.textureLocation = instanceTEX;  trait_antigravity.register();
var trait_ingarage = VanillaFactory.createItem("trait_ingarage");	trait_ingarage.textureLocation = instanceTEX;  trait_ingarage.register();
var trait_surfwaxmurica = VanillaFactory.createItem("trait_surfwaxmurica");	trait_surfwaxmurica.textureLocation = instanceTEX;  trait_surfwaxmurica.register();
var trait_undone = VanillaFactory.createItem("trait_undone");	trait_undone.textureLocation = instanceTEX;  trait_undone.register();
var trait_thunder = VanillaFactory.createItem("trait_thunder");	trait_thunder.textureLocation = instanceTEX;  trait_thunder.register();
var trait_necrotic = VanillaFactory.createItem("trait_necrotic"); trait_necrotic.textureLocation = instanceTEX;   trait_necrotic.register();
var trait_sentience = VanillaFactory.createItem("trait_sentience");	trait_sentience.textureLocation = instanceTEX;  trait_sentience.register();
var trait_steady = VanillaFactory.createItem("trait_steady");	trait_steady.textureLocation = instanceTEX;  trait_steady.register();

