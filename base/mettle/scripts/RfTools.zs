# *======= Import =======*
import mods.jei.JEI.removeAndHide as rh;

# *======= Changes =======*
#Resonating frame
recipes.remove(<deepresonance:machine_frame>);
recipes.addShaped(<deepresonance:machine_frame>, [
	[<thermalfoundation:material:160>, <thermalfoundation:material:162>, <thermalfoundation:material:160>],
	[<thermalfoundation:material:162>, <deepresonance:resonating_plate>, <thermalfoundation:material:162>],
	[<thermalfoundation:material:160>, <thermalfoundation:material:162>, <thermalfoundation:material:160>]
]);

#Machine frame
recipes.remove(<rftools:machine_frame>);
recipes.addShaped(<rftools:machine_frame>, [
	[<thermalfoundation:material:160>, <thermalfoundation:material:132>, <thermalfoundation:material:160>],
	[<thermalfoundation:material:132>, <techreborn:part:30>, <thermalfoundation:material:132>],
	[<thermalfoundation:material:160>, <thermalfoundation:material:132>, <thermalfoundation:material:160>]
]);

#Machine base
recipes.remove(<rftools:machine_base>);
recipes.addShaped(<rftools:machine_base>, [
	[<botania:quartz:4>, <thermalfoundation:material:512>, <botania:quartz:4>],
	[<thermalfoundation:material:160>, <thermalfoundation:material:132>, <thermalfoundation:material:160>]
]);

#Dimensional shard
recipes.remove(<rftools:dimensional_shard>);

#Redstone transmitter
recipes.remove(<rftools:redstone_transmitter_block>);
recipes.addShaped(<rftools:redstone_transmitter_block>, [
	[null, <redstonearsenal:material:160>],
	[null, <rftools:machine_base>]
]);

#Redstone receiver
recipes.remove(<rftools:redstone_receiver_block>);
recipes.addShaped(<rftools:redstone_receiver_block>, [
	[null, <thermalfoundation:material:166>],
	[null, <rftools:machine_base>]
]);

#Quarry card
recipes.remove(<rftools:shape_card:2>);
recipes.addShapeless(<rftools:shape_card:2>, [<rftools:shape_card>, <powersuits:powerarmorcomponent:15>, <minecraft:diamond_pickaxe>]);

#Simple powercell
recipes.remove(<rftools:powercell_simple>);
recipes.addShaped(<rftools:powercell_simple>, [
	[<thermalfoundation:material:160>, <techreborn:part:17>, <thermalfoundation:material:160>],
	[<thermalfoundation:material:167>, <techreborn:machine_frame:2>, <thermalfoundation:material:167>],
	[<thermalfoundation:material:160>, <techreborn:part:17>, <thermalfoundation:material:160>]
]);

#Charged porter
recipes.remove(<rftools:charged_porter>);
recipes.addShaped(<rftools:charged_porter>, [
	[<techreborn:ingot:17>, <thermalfoundation:material:166>, <techreborn:ingot:17>],
	[<thermalfoundation:material:166>, <rftools:infused_enderpearl>, <thermalfoundation:material:166>],
	[<techreborn:ingot:17>, <powersuits:powerarmorcomponent:20>, <techreborn:ingot:17>]
]);

#Matter transmitter
recipes.remove(<rftools:matter_transmitter>);
recipes.addShaped(<rftools:matter_transmitter>, [
	[<techreborn:ingot:17>, <rftools:infused_enderpearl>, <techreborn:ingot:17>],
	[<thermalfoundation:material:165>, <techreborn:machine_frame:2>, <thermalfoundation:material:165>],
	[<techreborn:ingot:17>, <powersuits:powerarmorcomponent:20>, <techreborn:ingot:17>]
]);

#Matter receiver
recipes.remove(<rftools:matter_receiver>);
recipes.addShaped(<rftools:matter_receiver>, [
	[<techreborn:ingot:17>, <rftools:infused_enderpearl>, <techreborn:ingot:17>],
	[<thermalfoundation:material:166>, <techreborn:machine_frame:2>, <thermalfoundation:material:166>],
	[<techreborn:ingot:17>, <powersuits:powerarmorcomponent:20>, <techreborn:ingot:17>]
]);

#Shield projector
recipes.remove(<rftools:shield_block1>);
recipes.addShaped(<rftools:shield_block1>, [
	[<thermalfoundation:material:326>, <powersuits:powerarmorcomponent:12>, <thermalfoundation:material:326>],
	[<techreborn:ingot:15>, <techreborn:machine_frame:2>, <techreborn:ingot:15>],
	[<techreborn:ingot:15>, <techreborn:plates:13>, <techreborn:ingot:15>]
]);

#Environmental controller
recipes.remove(<rftools:environmental_controller>);
recipes.addShaped(<rftools:environmental_controller>, [
	[<techreborn:ingot:17>, <powersuits:powerarmorcomponent:4>, <techreborn:ingot:17>],
	[<thermalfoundation:material:167>, <techreborn:machine_frame:2>, <thermalfoundation:material:167>],
	[<techreborn:ingot:17>, <powersuits:powerarmorcomponent:20>, <techreborn:ingot:17>]
]);
	