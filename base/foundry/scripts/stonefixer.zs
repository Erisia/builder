

var furnaceBlock = <item:minecraft:furnace>;
var emptyItem = <item:minecraft:air>;

var stoneInputsArr = [
    <item:minecraft:diorite>,
    <item:minecraft:granite>,
    <item:minecraft:andesite>,
    <item:quark:jasper>,
    <item:quark:limestone>,
    <item:create:gabbro>,
    <item:create:scoria>
];


for input in stoneInputsArr  {
    //needed for addShaped method
    var furanceCraftingName = input.displayName + "_" + furnaceBlock.displayName;
    craftingTable.addShaped(furanceCraftingName, furnaceBlock, [
        [input, input, input],
        [input, emptyItem, input],
        [input, input, input]
    ]);
}



