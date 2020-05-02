// Fix the 2x rubber recipe thing.
val resin = <Eln:Eln.sharedItem:4096>;
val rubber = <Eln:Eln.sharedItem:4097>;

furnace.remove(rubber);
furnace.addRecipe(rubber*2, resin);

// Liquid coal
mods.thermalexpansion.Crucible.addRecipe(8000, <Eln:Eln.sharedItem:8>, <liquid:coal> * 100);
