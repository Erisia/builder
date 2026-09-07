//REMOVE RECIPES
recipes.remove(<teslacorelib:machine_case>);//MACHINE CASE
recipes.remove(<industrialforegoing:infinity_drill>);//INFINITY DRILL
recipes.remove(<industrialforegoing:ore_washer>);//ORE WASHER
recipes.remove(<industrialforegoing:laser_drill>);//LASER DRILL
recipes.remove(<industrialforegoing:laser_base>);//LASER BASE
recipes.remove(<industrialforegoing:wither_builder>);//
recipes.remove(<industrialforegoing:meat_feeder>);//
//ADD RECIPES
recipes.addShaped(<teslacorelib:machine_case>,[[<galacticraftcore:basic_item:11>,<minecraft:glass>,<galacticraftcore:basic_item:11>],
																[<minecraft:glass>,<ic2:resource:13>,<minecraft:glass>],
																[<galacticraftcore:basic_item:11>,<minecraft:glass>,<galacticraftcore:basic_item:11>]]);//MACHINE CASE

recipes.addShaped(<industrialforegoing:laser_base>,[[<industrialforegoing:plastic>,<environmentaltech:laser_core>,<industrialforegoing:plastic>],
																[<jaopca:item_gearcobalt>,<environmentaltech:laser_core>,<jaopca:item_gearcobalt>],
																[<jaopca:item_gearpalladium>,<teslacorelib:machine_case>,<jaopca:item_gearpalladium>]]);//LASER BASE
recipes.addShaped(<industrialforegoing:laser_drill>,[[<industrialforegoing:plastic>,<industrialforegoing:laser_lens>,<industrialforegoing:plastic>],
																[<thermalfoundation:glass:3>,<actuallyadditions:block_laser_relay_advanced>,<thermalfoundation:glass:3>],
																[<jaopca:item_gearmercury>,<teslacorelib:machine_case>,<jaopca:item_gearmercury>]]);//LASER DRILL
recipes.addShaped(<industrialforegoing:meat_feeder>,[[<industrialforegoing:plastic>,<ore:ingotSignalum>,<industrialforegoing:plastic>],
																[<extrautils2:drum:1>,<ore:ingotSignalum>,<extrautils2:drum:1>],
																[null,<ore:ingotSignalum>,null]]);//MEAT FEEDER

