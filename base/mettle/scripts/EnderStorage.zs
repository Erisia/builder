# *======= Changes =======*
#Ender chest
recipes.remove(<enderstorage:ender_storage>);
recipes.addShaped(<enderstorage:ender_storage>, [
	[<thermalfoundation:material:166>, <minecraft:wool>, <thermalfoundation:material:166>],
	[<quark:biotite_block>, <minecraft:ender_chest>, <quark:biotite_block>],
	[<thermalfoundation:material:166>, <bloodmagic:component:17>, <thermalfoundation:material:166>]
]);

#Ender tank
recipes.remove(<enderstorage:ender_storage:1>);
recipes.addShaped(<enderstorage:ender_storage:1>, [
	[<thermalfoundation:material:166>, <minecraft:wool>, <thermalfoundation:material:166>],
	[<quark:biotite_block>, <minecraft:cauldron>, <quark:biotite_block>],
	[<thermalfoundation:material:166>, <bloodmagic:component:17>, <thermalfoundation:material:166>]
]);

#Ender Pouch
recipes.remove(<enderstorage:ender_pouch>);
recipes.addShaped(<enderstorage:ender_pouch>, [
	[<betterwithmods:material:38>, <ore:leather>, <betterwithmods:material:38>],
	[<ore:leather>, <bloodmagic:component:17>, <ore:leather>],
	[<betterwithmods:material:38>, <minecraft:wool>, <betterwithmods:material:38>]
]);
	