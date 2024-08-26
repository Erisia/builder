import mods.modularmachinery.RecipeBuilder;

mods.extendedcrafting.TableCrafting.addShaped(<contenttweaker:master_rune_box>, 
[[<aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>], 
[<aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>], 
[<aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>], 
[<aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>], 
[<aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>], 
[<aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>], 
[<aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>], 
[<aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>], 
[<aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>, <aoa3:rune_box>]]);  


val tokengen1 = RecipeBuilder.newBuilder("tokengen1","token_totem",5);
tokengen1.addItemInput(<aoa3:nether_tokens>);
tokengen1.addEnergyPerTickOutput(60000);
tokengen1.build();

val tokengen2 = RecipeBuilder.newBuilder("tokengen2","token_totem",80);
tokengen2.addItemInput(<divinerpg:corrupted_stone>);
tokengen2.addEnergyPerTickOutput(40000);
tokengen2.build();

val tokengen3 = RecipeBuilder.newBuilder("tokengen3","token_totem",80);
tokengen3.addItemInput(<divinerpg:ender_stone>);
tokengen3.addEnergyPerTickOutput(40000);
tokengen3.build();

val tokengen4 = RecipeBuilder.newBuilder("tokengen4","token_totem",80);
tokengen4.addItemInput(<divinerpg:ice_stone>);
tokengen4.addEnergyPerTickOutput(40000);
tokengen4.build();

val tokengen5 = RecipeBuilder.newBuilder("tokengen5","token_totem",80);
tokengen5.addItemInput(<divinerpg:jungle_stone>);
tokengen5.addEnergyPerTickOutput(40000);
tokengen5.build();

val tokengen6 = RecipeBuilder.newBuilder("tokengen6","token_totem",80);
tokengen6.addItemInput(<divinerpg:molten_stone>);
tokengen6.addEnergyPerTickOutput(40000);
tokengen6.build();

val tokengen7 = RecipeBuilder.newBuilder("tokengen7","token_totem",80);
tokengen7.addItemInput(<divinerpg:shadow_stone>);
tokengen7.addEnergyPerTickOutput(40000);
tokengen7.build();

val tokengen8 = RecipeBuilder.newBuilder("tokengen8","token_totem",80);
tokengen8.addItemInput(<divinerpg:terran_stone>);
tokengen8.addEnergyPerTickOutput(40000);
tokengen8.build();

val tokengen9 = RecipeBuilder.newBuilder("tokengen9","token_totem",200);
tokengen9.addItemInput(<divinerpg:bluefire_stone>);
tokengen9.addEnergyPerTickOutput(40000);
tokengen9.build();

val tokengen10 = RecipeBuilder.newBuilder("tokengen10","token_totem",500);
tokengen10.addItemInput(<divinerpg:divine_stone>);
tokengen10.addEnergyPerTickOutput(60000);
tokengen10.build();

val tokengen11 = RecipeBuilder.newBuilder("tokengen11","token_totem",5);
tokengen11.addItemInput(<minecraft:nether_star>);
tokengen11.addEnergyPerTickOutput(20000);
tokengen11.build();

val tokengen12 = RecipeBuilder.newBuilder("tokengen12","token_totem",50);
tokengen12.addItemInput(<aoa3:abyss_tokens>);
tokengen12.addEnergyPerTickOutput(130000);
tokengen12.build();

val tokengen13 = RecipeBuilder.newBuilder("tokengen13","token_totem",50);
tokengen13.addItemInput(<aoa3:lelyetia_tokens>);
tokengen13.addEnergyPerTickOutput(130000);
tokengen13.build();

val tokengen14 = RecipeBuilder.newBuilder("tokengen14","token_totem",50);
tokengen14.addItemInput(<aoa3:precasian_tokens>);
tokengen14.addEnergyPerTickOutput(130000);
tokengen14.build();

val tokengen15 = RecipeBuilder.newBuilder("tokengen15","token_totem",50);
tokengen15.addItemInput(<aoa3:baron_tokens>);
tokengen15.addEnergyPerTickOutput(130000);
tokengen15.build();

val tokengen16 = RecipeBuilder.newBuilder("tokengen16","token_totem",50);
tokengen16.addItemInput(<aoa3:creeponia_tokens>);
tokengen16.addEnergyPerTickOutput(130000);
tokengen16.build();

val tokengen17 = RecipeBuilder.newBuilder("tokengen17","token_totem",50);
tokengen17.addItemInput(<aoa3:deeplands_tokens>);
tokengen17.addEnergyPerTickOutput(130000);
tokengen17.build();

val tokengen18 = RecipeBuilder.newBuilder("tokengen18","token_totem",200);
tokengen18.addItemInput(<aoa3:vox_ponds_tokens>);
tokengen18.addEnergyPerTickOutput(200000);
tokengen18.build();

val tokengen19 = RecipeBuilder.newBuilder("tokengen19","token_totem",50);
tokengen19.addItemInput(<aoa3:mysterium_tokens>);
tokengen19.addEnergyPerTickOutput(200000);
tokengen19.build();

val tokengen20 = RecipeBuilder.newBuilder("tokengen20","token_totem",50);
tokengen20.addItemInput(<aoa3:iromine_tokens>);
tokengen20.addEnergyPerTickOutput(200000);
tokengen20.build();

val tokengen21 = RecipeBuilder.newBuilder("tokengen21","token_totem",50);
tokengen21.addItemInput(<aoa3:haven_tokens>);
tokengen21.addEnergyPerTickOutput(200000);
tokengen21.build();

val tokengen22 = RecipeBuilder.newBuilder("tokengen22","token_totem",50);
tokengen22.addItemInput(<aoa3:candyland_tokens>);
tokengen22.addEnergyPerTickOutput(200000);
tokengen22.build();

val tokengen23 = RecipeBuilder.newBuilder("tokengen23","token_totem",50);
tokengen23.addItemInput(<aoa3:celeve_tokens>);
tokengen23.addEnergyPerTickOutput(200000);
tokengen23.build();

val tokengen24 = RecipeBuilder.newBuilder("tokengen24","token_totem",50);
tokengen24.addItemInput(<aoa3:gardencia_tokens>);
tokengen24.addEnergyPerTickOutput(200000);
tokengen24.build();

val tokengen25 = RecipeBuilder.newBuilder("tokengen25","token_totem",50);
tokengen25.addItemInput(<aoa3:crystevia_tokens>);
tokengen25.addEnergyPerTickOutput(200000);
tokengen25.build();

val tokengen26 = RecipeBuilder.newBuilder("tokengen26","token_totem",50);
tokengen26.addItemInput(<aoa3:lunar_tokens>);
tokengen26.addEnergyPerTickOutput(300000);
tokengen26.build();

val tokengen27 = RecipeBuilder.newBuilder("tokengen27","token_totem",50);
tokengen27.addItemInput(<aoa3:runandor_tokens>);
tokengen27.addEnergyPerTickOutput(300000);
tokengen27.build();

val tokengen28 = RecipeBuilder.newBuilder("tokengen28","token_totem",50);
tokengen28.addItemInput(<aoa3:borean_tokens>);
tokengen28.addEnergyPerTickOutput(300000);
tokengen28.build();

val tokengen31 = RecipeBuilder.newBuilder("tokengen31","token_totem",50);
tokengen31.addItemInput(<aoa3:greckon_tokens>);
tokengen31.addEnergyPerTickOutput(500000);
tokengen31.build();

val tokengen32 = RecipeBuilder.newBuilder("tokengen32","token_totem",50);
tokengen32.addItemInput(<aoa3:shyrelands_tokens>);
tokengen32.addEnergyPerTickOutput(1000000);
tokengen32.build();

val tokengen33 = RecipeBuilder.newBuilder("tokengen33","token_totem",50);
tokengen33.addItemInput(<aoa3:dustopia_tokens>);
tokengen33.addEnergyPerTickOutput(500000);
tokengen33.build();

val tokengen34 = RecipeBuilder.newBuilder("tokengen34","token_totem",200);
tokengen34.addItemInput(<divinerpg:eden_gem>);
tokengen34.addEnergyPerTickOutput(100000);
tokengen34.build();

val tokengen35 = RecipeBuilder.newBuilder("tokengen35","token_totem",200);
tokengen35.addItemInput(<divinerpg:wildwood_gem>);
tokengen35.addEnergyPerTickOutput(150000);
tokengen35.build();

val tokengen36 = RecipeBuilder.newBuilder("tokengen36","token_totem",200);
tokengen36.addItemInput(<divinerpg:apalachia_gem>);
tokengen36.addEnergyPerTickOutput(200000);
tokengen36.build();

val tokengen37 = RecipeBuilder.newBuilder("tokengen37","token_totem",200);
tokengen37.addItemInput(<divinerpg:mortum_gem>);
tokengen37.addEnergyPerTickOutput(350000);
tokengen37.build();

val tokengen38 = RecipeBuilder.newBuilder("tokengen38","token_totem",200);
tokengen38.addItemInput(<divinerpg:skythern_gem>);
tokengen38.addEnergyPerTickOutput(250000);
tokengen38.build();

val tokentiered1 = RecipeBuilder.newBuilder("tokentiered1","token_totem",800);
tokentiered1.addItemInput(<contenttweaker:tier1_token>);
tokentiered1.addEnergyPerTickOutput(10);
tokentiered1.build();

val tokentiered2 = RecipeBuilder.newBuilder("tokentiered2","token_totem",800);
tokentiered2.addItemInput(<contenttweaker:tier1_token>);
tokentiered2.addItemInput(<contenttweaker:tier2_token>);
tokentiered2.addEnergyPerTickOutput(100);
tokentiered2.build();

val tokentiered3 = RecipeBuilder.newBuilder("tokentiered3","token_totem",800);
tokentiered3.addItemInput(<contenttweaker:tier1_token>);
tokentiered3.addItemInput(<contenttweaker:tier2_token>);
tokentiered3.addItemInput(<contenttweaker:tier3_token>);
tokentiered3.addEnergyPerTickOutput(500);
tokentiered3.build();

val tokentiered4 = RecipeBuilder.newBuilder("tokentiered4","token_totem",800);
tokentiered4.addItemInput(<contenttweaker:tier1_token>);
tokentiered4.addItemInput(<contenttweaker:tier2_token>);
tokentiered4.addItemInput(<contenttweaker:tier3_token>);
tokentiered4.addItemInput(<contenttweaker:tier4_token>);
tokentiered4.addEnergyPerTickOutput(1000);
tokentiered4.build();

val tokentiered5 = RecipeBuilder.newBuilder("tokentiered5","token_totem",800);
tokentiered5.addItemInput(<contenttweaker:tier1_token>);
tokentiered5.addItemInput(<contenttweaker:tier2_token>);
tokentiered5.addItemInput(<contenttweaker:tier3_token>);
tokentiered5.addItemInput(<contenttweaker:tier4_token>);
tokentiered5.addItemInput(<contenttweaker:tier5_token>);
tokentiered5.addEnergyPerTickOutput(5000);
tokentiered5.build();

val tokentiered6 = RecipeBuilder.newBuilder("tokentiered6","token_totem",800);
tokentiered6.addItemInput(<contenttweaker:tier1_token>);
tokentiered6.addItemInput(<contenttweaker:tier2_token>);
tokentiered6.addItemInput(<contenttweaker:tier3_token>);
tokentiered6.addItemInput(<contenttweaker:tier4_token>);
tokentiered6.addItemInput(<contenttweaker:tier5_token>);
tokentiered6.addItemInput(<contenttweaker:tier6_token>);
tokentiered6.addEnergyPerTickOutput(10000);
tokentiered6.build();

val tokentiered7 = RecipeBuilder.newBuilder("tokentiered7","token_totem",800);
tokentiered7.addItemInput(<contenttweaker:tier1_token>);
tokentiered7.addItemInput(<contenttweaker:tier2_token>);
tokentiered7.addItemInput(<contenttweaker:tier3_token>);
tokentiered7.addItemInput(<contenttweaker:tier4_token>);
tokentiered7.addItemInput(<contenttweaker:tier5_token>);
tokentiered7.addItemInput(<contenttweaker:tier6_token>);
tokentiered7.addItemInput(<contenttweaker:tier7_token>);
tokentiered7.addEnergyPerTickOutput(20000);
tokentiered7.build();

val tokentiered8 = RecipeBuilder.newBuilder("tokentiered8","token_totem",800);
tokentiered8.addItemInput(<contenttweaker:tier1_token>);
tokentiered8.addItemInput(<contenttweaker:tier2_token>);
tokentiered8.addItemInput(<contenttweaker:tier3_token>);
tokentiered8.addItemInput(<contenttweaker:tier4_token>);
tokentiered8.addItemInput(<contenttweaker:tier5_token>);
tokentiered8.addItemInput(<contenttweaker:tier6_token>);
tokentiered8.addItemInput(<contenttweaker:tier7_token>);
tokentiered8.addItemInput(<contenttweaker:tier8_token>);
tokentiered8.addEnergyPerTickOutput(30000);
tokentiered8.build();

val tokentiered9 = RecipeBuilder.newBuilder("tokentiered9","token_totem",800);
tokentiered9.addItemInput(<contenttweaker:tier1_token>);
tokentiered9.addItemInput(<contenttweaker:tier2_token>);
tokentiered9.addItemInput(<contenttweaker:tier3_token>);
tokentiered9.addItemInput(<contenttweaker:tier4_token>);
tokentiered9.addItemInput(<contenttweaker:tier5_token>);
tokentiered9.addItemInput(<contenttweaker:tier6_token>);
tokentiered9.addItemInput(<contenttweaker:tier7_token>);
tokentiered9.addItemInput(<contenttweaker:tier8_token>);
tokentiered9.addItemInput(<contenttweaker:tier9_token>);
tokentiered9.addEnergyPerTickOutput(50000);
tokentiered9.build();

val tokentiered10 = RecipeBuilder.newBuilder("tokentiered10","token_totem",800);
tokentiered10.addItemInput(<contenttweaker:tier1_token>);
tokentiered10.addItemInput(<contenttweaker:tier2_token>);
tokentiered10.addItemInput(<contenttweaker:tier3_token>);
tokentiered10.addItemInput(<contenttweaker:tier4_token>);
tokentiered10.addItemInput(<contenttweaker:tier5_token>);
tokentiered10.addItemInput(<contenttweaker:tier6_token>);
tokentiered10.addItemInput(<contenttweaker:tier7_token>);
tokentiered10.addItemInput(<contenttweaker:tier8_token>);
tokentiered10.addItemInput(<contenttweaker:tier9_token>);
tokentiered10.addItemInput(<contenttweaker:tier10_token>);
tokentiered10.addEnergyPerTickOutput(100000);
tokentiered10.build();

val tokentiered11 = RecipeBuilder.newBuilder("tokentiered11","token_totem",800);
tokentiered11.addItemInput(<contenttweaker:tier1_token>);
tokentiered11.addItemInput(<contenttweaker:tier2_token>);
tokentiered11.addItemInput(<contenttweaker:tier3_token>);
tokentiered11.addItemInput(<contenttweaker:tier4_token>);
tokentiered11.addItemInput(<contenttweaker:tier5_token>);
tokentiered11.addItemInput(<contenttweaker:tier6_token>);
tokentiered11.addItemInput(<contenttweaker:tier7_token>);
tokentiered11.addItemInput(<contenttweaker:tier8_token>);
tokentiered11.addItemInput(<contenttweaker:tier9_token>);
tokentiered11.addItemInput(<contenttweaker:tier10_token>);
tokentiered11.addItemInput(<contenttweaker:tier11_token>);
tokentiered11.addEnergyPerTickOutput(200000);
tokentiered11.build();

val tokentiered12 = RecipeBuilder.newBuilder("tokentiered12","token_totem",800);
tokentiered12.addItemInput(<contenttweaker:tier1_token>);
tokentiered12.addItemInput(<contenttweaker:tier2_token>);
tokentiered12.addItemInput(<contenttweaker:tier3_token>);
tokentiered12.addItemInput(<contenttweaker:tier4_token>);
tokentiered12.addItemInput(<contenttweaker:tier5_token>);
tokentiered12.addItemInput(<contenttweaker:tier6_token>);
tokentiered12.addItemInput(<contenttweaker:tier7_token>);
tokentiered12.addItemInput(<contenttweaker:tier8_token>);
tokentiered12.addItemInput(<contenttweaker:tier9_token>);
tokentiered12.addItemInput(<contenttweaker:tier10_token>);
tokentiered12.addItemInput(<contenttweaker:tier11_token>);
tokentiered12.addItemInput(<contenttweaker:tier12_token>);
tokentiered12.addEnergyPerTickOutput(500000);
tokentiered12.build();

val tokentiered13 = RecipeBuilder.newBuilder("tokentiered13","token_totem",800);
tokentiered13.addItemInput(<contenttweaker:tier1_token>);
tokentiered13.addItemInput(<contenttweaker:tier2_token>);
tokentiered13.addItemInput(<contenttweaker:tier3_token>);
tokentiered13.addItemInput(<contenttweaker:tier4_token>);
tokentiered13.addItemInput(<contenttweaker:tier5_token>);
tokentiered13.addItemInput(<contenttweaker:tier6_token>);
tokentiered13.addItemInput(<contenttweaker:tier7_token>);
tokentiered13.addItemInput(<contenttweaker:tier8_token>);
tokentiered13.addItemInput(<contenttweaker:tier9_token>);
tokentiered13.addItemInput(<contenttweaker:tier10_token>);
tokentiered13.addItemInput(<contenttweaker:tier11_token>);
tokentiered13.addItemInput(<contenttweaker:tier12_token>);
tokentiered13.addItemInput(<contenttweaker:tier13_token>);
tokentiered13.addEnergyPerTickOutput(800000);
tokentiered13.build();

val tokentiered14 = RecipeBuilder.newBuilder("tokentiered14","token_totem",800);
tokentiered14.addItemInput(<contenttweaker:tier1_token>);
tokentiered14.addItemInput(<contenttweaker:tier2_token>);
tokentiered14.addItemInput(<contenttweaker:tier3_token>);
tokentiered14.addItemInput(<contenttweaker:tier4_token>);
tokentiered14.addItemInput(<contenttweaker:tier5_token>);
tokentiered14.addItemInput(<contenttweaker:tier6_token>);
tokentiered14.addItemInput(<contenttweaker:tier7_token>);
tokentiered14.addItemInput(<contenttweaker:tier8_token>);
tokentiered14.addItemInput(<contenttweaker:tier9_token>);
tokentiered14.addItemInput(<contenttweaker:tier10_token>);
tokentiered14.addItemInput(<contenttweaker:tier11_token>);
tokentiered14.addItemInput(<contenttweaker:tier12_token>);
tokentiered14.addItemInput(<contenttweaker:tier13_token>);
tokentiered14.addItemInput(<contenttweaker:tier14_token>);
tokentiered14.addEnergyPerTickOutput(900000);
tokentiered14.build();

val tokentiered15 = RecipeBuilder.newBuilder("tokentiered15","token_totem",800);
tokentiered15.addItemInput(<contenttweaker:tier1_token>);
tokentiered15.addItemInput(<contenttweaker:tier2_token>);
tokentiered15.addItemInput(<contenttweaker:tier3_token>);
tokentiered15.addItemInput(<contenttweaker:tier4_token>);
tokentiered15.addItemInput(<contenttweaker:tier5_token>);
tokentiered15.addItemInput(<contenttweaker:tier6_token>);
tokentiered15.addItemInput(<contenttweaker:tier7_token>);
tokentiered15.addItemInput(<contenttweaker:tier8_token>);
tokentiered15.addItemInput(<contenttweaker:tier9_token>);
tokentiered15.addItemInput(<contenttweaker:tier10_token>);
tokentiered15.addItemInput(<contenttweaker:tier11_token>);
tokentiered15.addItemInput(<contenttweaker:tier12_token>);
tokentiered15.addItemInput(<contenttweaker:tier13_token>);
tokentiered15.addItemInput(<contenttweaker:tier14_token>);
tokentiered15.addItemInput(<contenttweaker:tier15_token>);
tokentiered15.addEnergyPerTickOutput(1000000);
tokentiered15.build();

val tokentiered16 = RecipeBuilder.newBuilder("tokentiered16","token_totem",800);
tokentiered16.addItemInput(<contenttweaker:tier1_token>);
tokentiered16.addItemInput(<contenttweaker:tier2_token>);
tokentiered16.addItemInput(<contenttweaker:tier3_token>);
tokentiered16.addItemInput(<contenttweaker:tier4_token>);
tokentiered16.addItemInput(<contenttweaker:tier5_token>);
tokentiered16.addItemInput(<contenttweaker:tier6_token>);
tokentiered16.addItemInput(<contenttweaker:tier7_token>);
tokentiered16.addItemInput(<contenttweaker:tier8_token>);
tokentiered16.addItemInput(<contenttweaker:tier9_token>);
tokentiered16.addItemInput(<contenttweaker:tier10_token>);
tokentiered16.addItemInput(<contenttweaker:tier11_token>);
tokentiered16.addItemInput(<contenttweaker:tier12_token>);
tokentiered16.addItemInput(<contenttweaker:tier13_token>);
tokentiered16.addItemInput(<contenttweaker:tier14_token>);
tokentiered16.addItemInput(<contenttweaker:tier15_token>);
tokentiered16.addItemInput(<contenttweaker:tier16_token>);
tokentiered16.addEnergyPerTickOutput(1200000);
tokentiered16.build();

val tokentiered17 = RecipeBuilder.newBuilder("tokentiered17","token_totem",800);
tokentiered17.addItemInput(<contenttweaker:tier1_token>);
tokentiered17.addItemInput(<contenttweaker:tier2_token>);
tokentiered17.addItemInput(<contenttweaker:tier3_token>);
tokentiered17.addItemInput(<contenttweaker:tier4_token>);
tokentiered17.addItemInput(<contenttweaker:tier5_token>);
tokentiered17.addItemInput(<contenttweaker:tier6_token>);
tokentiered17.addItemInput(<contenttweaker:tier7_token>);
tokentiered17.addItemInput(<contenttweaker:tier8_token>);
tokentiered17.addItemInput(<contenttweaker:tier9_token>);
tokentiered17.addItemInput(<contenttweaker:tier10_token>);
tokentiered17.addItemInput(<contenttweaker:tier11_token>);
tokentiered17.addItemInput(<contenttweaker:tier12_token>);
tokentiered17.addItemInput(<contenttweaker:tier13_token>);
tokentiered17.addItemInput(<contenttweaker:tier14_token>);
tokentiered17.addItemInput(<contenttweaker:tier15_token>);
tokentiered17.addItemInput(<contenttweaker:tier16_token>);
tokentiered17.addItemInput(<contenttweaker:tier17_token>);
tokentiered17.addEnergyPerTickOutput(1400000);
tokentiered17.build();

val tokentiered18 = RecipeBuilder.newBuilder("tokentiered18","token_totem",800);
tokentiered18.addItemInput(<contenttweaker:tier1_token>);
tokentiered18.addItemInput(<contenttweaker:tier2_token>);
tokentiered18.addItemInput(<contenttweaker:tier3_token>);
tokentiered18.addItemInput(<contenttweaker:tier4_token>);
tokentiered18.addItemInput(<contenttweaker:tier5_token>);
tokentiered18.addItemInput(<contenttweaker:tier6_token>);
tokentiered18.addItemInput(<contenttweaker:tier7_token>);
tokentiered18.addItemInput(<contenttweaker:tier8_token>);
tokentiered18.addItemInput(<contenttweaker:tier9_token>);
tokentiered18.addItemInput(<contenttweaker:tier10_token>);
tokentiered18.addItemInput(<contenttweaker:tier11_token>);
tokentiered18.addItemInput(<contenttweaker:tier12_token>);
tokentiered18.addItemInput(<contenttweaker:tier13_token>);
tokentiered18.addItemInput(<contenttweaker:tier14_token>);
tokentiered18.addItemInput(<contenttweaker:tier15_token>);
tokentiered18.addItemInput(<contenttweaker:tier16_token>);
tokentiered18.addItemInput(<contenttweaker:tier17_token>);
tokentiered18.addItemInput(<contenttweaker:tier18_token>);
tokentiered18.addEnergyPerTickOutput(1600000);
tokentiered18.build();

val tokentiered19 = RecipeBuilder.newBuilder("tokentiered19","token_totem",800);
tokentiered19.addItemInput(<contenttweaker:tier1_token>);
tokentiered19.addItemInput(<contenttweaker:tier2_token>);
tokentiered19.addItemInput(<contenttweaker:tier3_token>);
tokentiered19.addItemInput(<contenttweaker:tier4_token>);
tokentiered19.addItemInput(<contenttweaker:tier5_token>);
tokentiered19.addItemInput(<contenttweaker:tier6_token>);
tokentiered19.addItemInput(<contenttweaker:tier7_token>);
tokentiered19.addItemInput(<contenttweaker:tier8_token>);
tokentiered19.addItemInput(<contenttweaker:tier9_token>);
tokentiered19.addItemInput(<contenttweaker:tier10_token>);
tokentiered19.addItemInput(<contenttweaker:tier11_token>);
tokentiered19.addItemInput(<contenttweaker:tier12_token>);
tokentiered19.addItemInput(<contenttweaker:tier13_token>);
tokentiered19.addItemInput(<contenttweaker:tier14_token>);
tokentiered19.addItemInput(<contenttweaker:tier15_token>);
tokentiered19.addItemInput(<contenttweaker:tier16_token>);
tokentiered19.addItemInput(<contenttweaker:tier17_token>);
tokentiered19.addItemInput(<contenttweaker:tier18_token>);
tokentiered19.addItemInput(<contenttweaker:tier19_token>);
tokentiered19.addEnergyPerTickOutput(1800000);
tokentiered19.build();

val tokentiered20 = RecipeBuilder.newBuilder("tokentiered20","token_totem",800);
tokentiered20.addItemInput(<contenttweaker:tier1_token>);
tokentiered20.addItemInput(<contenttweaker:tier2_token>);
tokentiered20.addItemInput(<contenttweaker:tier3_token>);
tokentiered20.addItemInput(<contenttweaker:tier4_token>);
tokentiered20.addItemInput(<contenttweaker:tier5_token>);
tokentiered20.addItemInput(<contenttweaker:tier6_token>);
tokentiered20.addItemInput(<contenttweaker:tier7_token>);
tokentiered20.addItemInput(<contenttweaker:tier8_token>);
tokentiered20.addItemInput(<contenttweaker:tier9_token>);
tokentiered20.addItemInput(<contenttweaker:tier10_token>);
tokentiered20.addItemInput(<contenttweaker:tier11_token>);
tokentiered20.addItemInput(<contenttweaker:tier12_token>);
tokentiered20.addItemInput(<contenttweaker:tier13_token>);
tokentiered20.addItemInput(<contenttweaker:tier14_token>);
tokentiered20.addItemInput(<contenttweaker:tier15_token>);
tokentiered20.addItemInput(<contenttweaker:tier16_token>);
tokentiered20.addItemInput(<contenttweaker:tier17_token>);
tokentiered20.addItemInput(<contenttweaker:tier18_token>);
tokentiered20.addItemInput(<contenttweaker:tier19_token>);
tokentiered20.addItemInput(<contenttweaker:tier20_token>);
tokentiered20.addEnergyPerTickOutput(2000000);
tokentiered20.build();

val tokentiered21 = RecipeBuilder.newBuilder("tokentiered21","token_totem",800);
tokentiered21.addItemInput(<contenttweaker:tier1_token>);
tokentiered21.addItemInput(<contenttweaker:tier2_token>);
tokentiered21.addItemInput(<contenttweaker:tier3_token>);
tokentiered21.addItemInput(<contenttweaker:tier4_token>);
tokentiered21.addItemInput(<contenttweaker:tier5_token>);
tokentiered21.addItemInput(<contenttweaker:tier6_token>);
tokentiered21.addItemInput(<contenttweaker:tier7_token>);
tokentiered21.addItemInput(<contenttweaker:tier8_token>);
tokentiered21.addItemInput(<contenttweaker:tier9_token>);
tokentiered21.addItemInput(<contenttweaker:tier10_token>);
tokentiered21.addItemInput(<contenttweaker:tier11_token>);
tokentiered21.addItemInput(<contenttweaker:tier12_token>);
tokentiered21.addItemInput(<contenttweaker:tier13_token>);
tokentiered21.addItemInput(<contenttweaker:tier14_token>);
tokentiered21.addItemInput(<contenttweaker:tier15_token>);
tokentiered21.addItemInput(<contenttweaker:tier16_token>);
tokentiered21.addItemInput(<contenttweaker:tier17_token>);
tokentiered21.addItemInput(<contenttweaker:tier18_token>);
tokentiered21.addItemInput(<contenttweaker:tier19_token>);
tokentiered21.addItemInput(<contenttweaker:tier20_token>);
tokentiered21.addItemInput(<contenttweaker:tier21_token>);
tokentiered21.addEnergyPerTickOutput(5000000);
tokentiered21.build();

val tokentiered22 = RecipeBuilder.newBuilder("tokentiered22","token_totem",800);
tokentiered22.addItemInput(<contenttweaker:tier1_token>);
tokentiered22.addItemInput(<contenttweaker:tier2_token>);
tokentiered22.addItemInput(<contenttweaker:tier3_token>);
tokentiered22.addItemInput(<contenttweaker:tier4_token>);
tokentiered22.addItemInput(<contenttweaker:tier5_token>);
tokentiered22.addItemInput(<contenttweaker:tier6_token>);
tokentiered22.addItemInput(<contenttweaker:tier7_token>);
tokentiered22.addItemInput(<contenttweaker:tier8_token>);
tokentiered22.addItemInput(<contenttweaker:tier9_token>);
tokentiered22.addItemInput(<contenttweaker:tier10_token>);
tokentiered22.addItemInput(<contenttweaker:tier11_token>);
tokentiered22.addItemInput(<contenttweaker:tier12_token>);
tokentiered22.addItemInput(<contenttweaker:tier13_token>);
tokentiered22.addItemInput(<contenttweaker:tier14_token>);
tokentiered22.addItemInput(<contenttweaker:tier15_token>);
tokentiered22.addItemInput(<contenttweaker:tier16_token>);
tokentiered22.addItemInput(<contenttweaker:tier17_token>);
tokentiered22.addItemInput(<contenttweaker:tier18_token>);
tokentiered22.addItemInput(<contenttweaker:tier19_token>);
tokentiered22.addItemInput(<contenttweaker:tier20_token>);
tokentiered22.addItemInput(<contenttweaker:tier21_token>);
tokentiered22.addItemInput(<contenttweaker:tier22_token>);
tokentiered22.addEnergyPerTickOutput(10000000);
tokentiered22.build();

val tokentiered23 = RecipeBuilder.newBuilder("tokentiered23","token_totem",800);
tokentiered23.addItemInput(<contenttweaker:tier1_token>);
tokentiered23.addItemInput(<contenttweaker:tier2_token>);
tokentiered23.addItemInput(<contenttweaker:tier3_token>);
tokentiered23.addItemInput(<contenttweaker:tier4_token>);
tokentiered23.addItemInput(<contenttweaker:tier5_token>);
tokentiered23.addItemInput(<contenttweaker:tier6_token>);
tokentiered23.addItemInput(<contenttweaker:tier7_token>);
tokentiered23.addItemInput(<contenttweaker:tier8_token>);
tokentiered23.addItemInput(<contenttweaker:tier9_token>);
tokentiered23.addItemInput(<contenttweaker:tier10_token>);
tokentiered23.addItemInput(<contenttweaker:tier11_token>);
tokentiered23.addItemInput(<contenttweaker:tier12_token>);
tokentiered23.addItemInput(<contenttweaker:tier13_token>);
tokentiered23.addItemInput(<contenttweaker:tier14_token>);
tokentiered23.addItemInput(<contenttweaker:tier15_token>);
tokentiered23.addItemInput(<contenttweaker:tier16_token>);
tokentiered23.addItemInput(<contenttweaker:tier17_token>);
tokentiered23.addItemInput(<contenttweaker:tier18_token>);
tokentiered23.addItemInput(<contenttweaker:tier19_token>);
tokentiered23.addItemInput(<contenttweaker:tier20_token>);
tokentiered23.addItemInput(<contenttweaker:tier21_token>);
tokentiered23.addItemInput(<contenttweaker:tier22_token>);
tokentiered23.addItemInput(<contenttweaker:tier23_token>);
tokentiered23.addEnergyPerTickOutput(20000000);
tokentiered23.build();

val tokentiered24 = RecipeBuilder.newBuilder("tokentiered24","token_totem",800);
tokentiered24.addItemInput(<contenttweaker:tier1_token>);
tokentiered24.addItemInput(<contenttweaker:tier2_token>);
tokentiered24.addItemInput(<contenttweaker:tier3_token>);
tokentiered24.addItemInput(<contenttweaker:tier4_token>);
tokentiered24.addItemInput(<contenttweaker:tier5_token>);
tokentiered24.addItemInput(<contenttweaker:tier6_token>);
tokentiered24.addItemInput(<contenttweaker:tier7_token>);
tokentiered24.addItemInput(<contenttweaker:tier8_token>);
tokentiered24.addItemInput(<contenttweaker:tier9_token>);
tokentiered24.addItemInput(<contenttweaker:tier10_token>);
tokentiered24.addItemInput(<contenttweaker:tier11_token>);
tokentiered24.addItemInput(<contenttweaker:tier12_token>);
tokentiered24.addItemInput(<contenttweaker:tier13_token>);
tokentiered24.addItemInput(<contenttweaker:tier14_token>);
tokentiered24.addItemInput(<contenttweaker:tier15_token>);
tokentiered24.addItemInput(<contenttweaker:tier16_token>);
tokentiered24.addItemInput(<contenttweaker:tier17_token>);
tokentiered24.addItemInput(<contenttweaker:tier18_token>);
tokentiered24.addItemInput(<contenttweaker:tier19_token>);
tokentiered24.addItemInput(<contenttweaker:tier20_token>);
tokentiered24.addItemInput(<contenttweaker:tier21_token>);
tokentiered24.addItemInput(<contenttweaker:tier22_token>);
tokentiered24.addItemInput(<contenttweaker:tier23_token>);
tokentiered24.addItemInput(<contenttweaker:tier24_token>);
tokentiered24.addEnergyPerTickOutput(30000000);
tokentiered24.build();

val tokentiered25 = RecipeBuilder.newBuilder("tokentiered25","token_totem",800);
tokentiered25.addItemInput(<contenttweaker:tier1_token>);
tokentiered25.addItemInput(<contenttweaker:tier2_token>);
tokentiered25.addItemInput(<contenttweaker:tier3_token>);
tokentiered25.addItemInput(<contenttweaker:tier4_token>);
tokentiered25.addItemInput(<contenttweaker:tier5_token>);
tokentiered25.addItemInput(<contenttweaker:tier6_token>);
tokentiered25.addItemInput(<contenttweaker:tier7_token>);
tokentiered25.addItemInput(<contenttweaker:tier8_token>);
tokentiered25.addItemInput(<contenttweaker:tier9_token>);
tokentiered25.addItemInput(<contenttweaker:tier10_token>);
tokentiered25.addItemInput(<contenttweaker:tier11_token>);
tokentiered25.addItemInput(<contenttweaker:tier12_token>);
tokentiered25.addItemInput(<contenttweaker:tier13_token>);
tokentiered25.addItemInput(<contenttweaker:tier14_token>);
tokentiered25.addItemInput(<contenttweaker:tier15_token>);
tokentiered25.addItemInput(<contenttweaker:tier16_token>);
tokentiered25.addItemInput(<contenttweaker:tier17_token>);
tokentiered25.addItemInput(<contenttweaker:tier18_token>);
tokentiered25.addItemInput(<contenttweaker:tier19_token>);
tokentiered25.addItemInput(<contenttweaker:tier20_token>);
tokentiered25.addItemInput(<contenttweaker:tier21_token>);
tokentiered25.addItemInput(<contenttweaker:tier22_token>);
tokentiered25.addItemInput(<contenttweaker:tier23_token>);
tokentiered25.addItemInput(<contenttweaker:tier24_token>);
tokentiered25.addItemInput(<contenttweaker:tier25_token>);
tokentiered25.addEnergyPerTickOutput(40000000);
tokentiered25.build();

val tokentiered26 = RecipeBuilder.newBuilder("tokentiered26","token_totem",800);
tokentiered26.addItemInput(<contenttweaker:tier1_token>);
tokentiered26.addItemInput(<contenttweaker:tier2_token>);
tokentiered26.addItemInput(<contenttweaker:tier3_token>);
tokentiered26.addItemInput(<contenttweaker:tier4_token>);
tokentiered26.addItemInput(<contenttweaker:tier5_token>);
tokentiered26.addItemInput(<contenttweaker:tier6_token>);
tokentiered26.addItemInput(<contenttweaker:tier7_token>);
tokentiered26.addItemInput(<contenttweaker:tier8_token>);
tokentiered26.addItemInput(<contenttweaker:tier9_token>);
tokentiered26.addItemInput(<contenttweaker:tier10_token>);
tokentiered26.addItemInput(<contenttweaker:tier11_token>);
tokentiered26.addItemInput(<contenttweaker:tier12_token>);
tokentiered26.addItemInput(<contenttweaker:tier13_token>);
tokentiered26.addItemInput(<contenttweaker:tier14_token>);
tokentiered26.addItemInput(<contenttweaker:tier15_token>);
tokentiered26.addItemInput(<contenttweaker:tier16_token>);
tokentiered26.addItemInput(<contenttweaker:tier17_token>);
tokentiered26.addItemInput(<contenttweaker:tier18_token>);
tokentiered26.addItemInput(<contenttweaker:tier19_token>);
tokentiered26.addItemInput(<contenttweaker:tier20_token>);
tokentiered26.addItemInput(<contenttweaker:tier21_token>);
tokentiered26.addItemInput(<contenttweaker:tier22_token>);
tokentiered26.addItemInput(<contenttweaker:tier23_token>);
tokentiered26.addItemInput(<contenttweaker:tier24_token>);
tokentiered26.addItemInput(<contenttweaker:tier25_token>);
tokentiered26.addItemInput(<contenttweaker:tier26_token>);
tokentiered26.addEnergyPerTickOutput(50000000);
tokentiered26.build();

val tokentiered27 = RecipeBuilder.newBuilder("tokentiered27","token_totem",800);
tokentiered27.addItemInput(<contenttweaker:tier1_token>);
tokentiered27.addItemInput(<contenttweaker:tier2_token>);
tokentiered27.addItemInput(<contenttweaker:tier3_token>);
tokentiered27.addItemInput(<contenttweaker:tier4_token>);
tokentiered27.addItemInput(<contenttweaker:tier5_token>);
tokentiered27.addItemInput(<contenttweaker:tier6_token>);
tokentiered27.addItemInput(<contenttweaker:tier7_token>);
tokentiered27.addItemInput(<contenttweaker:tier8_token>);
tokentiered27.addItemInput(<contenttweaker:tier9_token>);
tokentiered27.addItemInput(<contenttweaker:tier10_token>);
tokentiered27.addItemInput(<contenttweaker:tier11_token>);
tokentiered27.addItemInput(<contenttweaker:tier12_token>);
tokentiered27.addItemInput(<contenttweaker:tier13_token>);
tokentiered27.addItemInput(<contenttweaker:tier14_token>);
tokentiered27.addItemInput(<contenttweaker:tier15_token>);
tokentiered27.addItemInput(<contenttweaker:tier16_token>);
tokentiered27.addItemInput(<contenttweaker:tier17_token>);
tokentiered27.addItemInput(<contenttweaker:tier18_token>);
tokentiered27.addItemInput(<contenttweaker:tier19_token>);
tokentiered27.addItemInput(<contenttweaker:tier20_token>);
tokentiered27.addItemInput(<contenttweaker:tier21_token>);
tokentiered27.addItemInput(<contenttweaker:tier22_token>);
tokentiered27.addItemInput(<contenttweaker:tier23_token>);
tokentiered27.addItemInput(<contenttweaker:tier24_token>);
tokentiered27.addItemInput(<contenttweaker:tier25_token>);
tokentiered27.addItemInput(<contenttweaker:tier26_token>);
tokentiered27.addItemInput(<contenttweaker:tier27_token>);
tokentiered27.addEnergyPerTickOutput(60000000);
tokentiered27.build();

val tokentiered28 = RecipeBuilder.newBuilder("tokentiered28","token_totem",800);
tokentiered28.addItemInput(<contenttweaker:tier1_token>);
tokentiered28.addItemInput(<contenttweaker:tier2_token>);
tokentiered28.addItemInput(<contenttweaker:tier3_token>);
tokentiered28.addItemInput(<contenttweaker:tier4_token>);
tokentiered28.addItemInput(<contenttweaker:tier5_token>);
tokentiered28.addItemInput(<contenttweaker:tier6_token>);
tokentiered28.addItemInput(<contenttweaker:tier7_token>);
tokentiered28.addItemInput(<contenttweaker:tier8_token>);
tokentiered28.addItemInput(<contenttweaker:tier9_token>);
tokentiered28.addItemInput(<contenttweaker:tier10_token>);
tokentiered28.addItemInput(<contenttweaker:tier11_token>);
tokentiered28.addItemInput(<contenttweaker:tier12_token>);
tokentiered28.addItemInput(<contenttweaker:tier13_token>);
tokentiered28.addItemInput(<contenttweaker:tier14_token>);
tokentiered28.addItemInput(<contenttweaker:tier15_token>);
tokentiered28.addItemInput(<contenttweaker:tier16_token>);
tokentiered28.addItemInput(<contenttweaker:tier17_token>);
tokentiered28.addItemInput(<contenttweaker:tier18_token>);
tokentiered28.addItemInput(<contenttweaker:tier19_token>);
tokentiered28.addItemInput(<contenttweaker:tier20_token>);
tokentiered28.addItemInput(<contenttweaker:tier21_token>);
tokentiered28.addItemInput(<contenttweaker:tier22_token>);
tokentiered28.addItemInput(<contenttweaker:tier23_token>);
tokentiered28.addItemInput(<contenttweaker:tier24_token>);
tokentiered28.addItemInput(<contenttweaker:tier25_token>);
tokentiered28.addItemInput(<contenttweaker:tier26_token>);
tokentiered28.addItemInput(<contenttweaker:tier27_token>);
tokentiered28.addItemInput(<contenttweaker:tier28_token>);
tokentiered28.addEnergyPerTickOutput(80000000);
tokentiered28.build();

val tokentiered29 = RecipeBuilder.newBuilder("tokentiered29","token_totem",800);
tokentiered29.addItemInput(<contenttweaker:tier1_token>);
tokentiered29.addItemInput(<contenttweaker:tier2_token>);
tokentiered29.addItemInput(<contenttweaker:tier3_token>);
tokentiered29.addItemInput(<contenttweaker:tier4_token>);
tokentiered29.addItemInput(<contenttweaker:tier5_token>);
tokentiered29.addItemInput(<contenttweaker:tier6_token>);
tokentiered29.addItemInput(<contenttweaker:tier7_token>);
tokentiered29.addItemInput(<contenttweaker:tier8_token>);
tokentiered29.addItemInput(<contenttweaker:tier9_token>);
tokentiered29.addItemInput(<contenttweaker:tier10_token>);
tokentiered29.addItemInput(<contenttweaker:tier11_token>);
tokentiered29.addItemInput(<contenttweaker:tier12_token>);
tokentiered29.addItemInput(<contenttweaker:tier13_token>);
tokentiered29.addItemInput(<contenttweaker:tier14_token>);
tokentiered29.addItemInput(<contenttweaker:tier15_token>);
tokentiered29.addItemInput(<contenttweaker:tier16_token>);
tokentiered29.addItemInput(<contenttweaker:tier17_token>);
tokentiered29.addItemInput(<contenttweaker:tier18_token>);
tokentiered29.addItemInput(<contenttweaker:tier19_token>);
tokentiered29.addItemInput(<contenttweaker:tier20_token>);
tokentiered29.addItemInput(<contenttweaker:tier21_token>);
tokentiered29.addItemInput(<contenttweaker:tier22_token>);
tokentiered29.addItemInput(<contenttweaker:tier23_token>);
tokentiered29.addItemInput(<contenttweaker:tier24_token>);
tokentiered29.addItemInput(<contenttweaker:tier25_token>);
tokentiered29.addItemInput(<contenttweaker:tier26_token>);
tokentiered29.addItemInput(<contenttweaker:tier27_token>);
tokentiered29.addItemInput(<contenttweaker:tier28_token>);
tokentiered29.addItemInput(<contenttweaker:tier29_token>);
tokentiered29.addEnergyPerTickOutput(100000000);
tokentiered29.build();