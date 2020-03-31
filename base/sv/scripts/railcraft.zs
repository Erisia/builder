// Add the vanilla track recipe back in.
recipes.addShaped("minecraft:rail", <minecraft:rail> * 16, [[<ore:ingotIron>, null, <ore:ingotIron>], [<ore:ingotIron>, <ore:stickWood>, <ore:ingotIron>], [<ore:ingotIron>, null, <ore:ingotIron>]]);

// Add recipes for various Railcraft items, using ImmEng machines.
val stickMold = <immersiveengineering:mold:2>;

// Tracks
recipes.remove(<railcraft:rail>);
mods.immersiveengineering.MetalPress.addRecipe(<railcraft:rail>*2, <ore:plateIron>, stickMold, 2000);
mods.immersiveengineering.MetalPress.addRecipe(<railcraft:rail:1>*2, <ore:plateGold>, stickMold, 2000);
recipes.remove(<railcraft:rail:3>);
recipes.addShapeless(<railcraft:rail:3>, [<railcraft:rail>, <minecraft:redstone>]);
recipes.remove(<railcraft:rail:4>);
mods.immersiveengineering.MetalPress.addRecipe(<railcraft:rail:4>*2, <ore:plateSteel>, stickMold, 8000);
// Rebar
recipes.addShapeless(<railcraft:rebar>, [<ore:stickSteel>, <ore:stickSteel>]);


// Boiler
recipes.addShaped(<railcraft:boiler_firebox_fluid>,
  [[<minecraft:netherbrick>, <minecraft:netherbrick>, <minecraft:netherbrick>],
   [<minecraft:netherbrick>, <minecraft:fire_charge>, <minecraft:netherbrick>],
   [<minecraft:netherbrick>, <railcraft:cart_tank>, <minecraft:netherbrick>]]);

recipes.addShaped(<railcraft:boiler_tank_pressure_high>,
  [[<ore:plateSteel>, <ore:plateSteel>, null],
   [<ore:plateSteel>, <ore:plateSteel>, null],
   [null, null, null]]);

recipes.addShaped(<railcraft:boiler_tank_pressure_high>,
  [[<ore:plateIron>, <ore:plateIron>, null],
   [<ore:plateIron>, <ore:plateIron>, null],
   [null, null, null]]);
