val iron = <ore:ingotIron>;
val ironCable = <ore:craftingWireIron>;
val copperCable = <ore:craftingWireCopper>;
val tinCable = <ore:craftingWireTin>;
val quartz = <ore:craftingQuartz>;
val redstone = <minecraft:redstone>;

val basicChip = <Eln:Eln.sharedItem:7680>;
val mvCable = <Eln:Eln.SixNode:2056>;

// Remove the tree-tap.
recipes.remove(<Eln:Eln.SixNode:7424>);

// Add an early-game solar panel recipe.
val solarPanel = <Eln:Eln.TransparentNode:3073>;
recipes.remove(solarPanel);
recipes.addShaped(solarPanel,
  [[iron, iron, iron],
   [tinCable, <ore:plateSilicon>, tinCable],
   [iron, iron, iron]]);
recipes.addShaped(solarPanel,
  [[iron, iron, iron],
   [tinCable, <ore:craftingQuartz>, tinCable],
   [iron, iron, iron]]);

// And basic chip recipe.
recipes.addShaped(basicChip,
  [[redstone, redstone, redstone],
   [redstone, quartz, redstone],
   [redstone, redstone, redstone]]);

// Fix the 200V energy exporter recipe.
recipes.remove(<Eln:eln.EnergyConverterElnToOtherMVUBlock>);
recipes.addShaped(<Eln:eln.EnergyConverterElnToOtherMVUBlock>,
  [[iron, iron, iron],
   [mvCable, basicChip, <ore:ingotIron>],
   [iron, iron, iron]]);

// Alternate, non-tungsten alloy dust recipes.
val alloyDust = <Eln:Eln.sharedItem:9>;
recipes.remove(alloyDust);
recipes.addShapeless(alloyDust*2,
  [<ore:dustNickel>, <ore:dustIron>, <ore:dustCopper>, <ore:dustCopper>]);
recipes.addShapeless(<Eln:Eln.sharedItem:9>*4,
  [<ore:dustNickel>, <ore:dustIron>, <ore:dustCopper>, <ore:dustAluminium>]);

// Allow conversion from GT cables.
recipes.addShapeless(<Eln:Eln.SixNode:2048>, [ironCable]);
recipes.addShapeless(<Eln:Eln.SixNode:2052>, [tinCable]);
recipes.addShapeless(<Eln:Eln.SixNode:2056>, [copperCable]);
recipes.addShapeless(<Eln:Eln.SixNode:2060>, [copperCable, <ore:itemRubber>]);
recipes.addShapeless(<Eln:Eln.SixNode:2064>, [<ore:cableGt01Tungsten>]);

// Re-add bread, for CfB's sake.
furnace.addRecipe(<minecraft:bread>, <ore:foodDough>);

// Dimensional Doors recipes
recipes.remove(<dimdoors:Personal Dimensional Door Item>);
mods.botania.ElvenTrade.addRecipe(<dimdoors:Personal Dimensional Door Item>,
  [<dimdoors:Warp Door Item>]);
mods.botania.ManaInfusion.addAlchemy(<dimdoors:Stable Fabric Item>,
  <dimdoors:World Thread>*4, 50000);
mods.botania.ManaInfusion.addConjuration(<dimdoors:World Thread>*2,
  <dimdoors:World Thread>, 100000);
mods.botania.ManaInfusion.addInfusion(<dimdoors:Stabilized Rift Signature>,
  <dimdoors:Rift Signature>, 20000);
mods.botania.ElvenTrade.addRecipe(<dimdoors:Rift Signature>,
  [<dimdoors:World Thread>]);

// Plates.
mods.gregtech.PlateBender.addRecipe(<Eln:Eln.sharedItem:7691>, <Eln:Eln.sharedItem:519>, 600, 40);

//Allow conversion from Greg's Blue Topaz Blocks to AM2's Blue Topaz Blocks to fix some broken recipes and rituals.
recipes.addShapeless(<arsmagica2:vinteumOre:7>, [<gregtech:gt.blockgem1:4>]);

