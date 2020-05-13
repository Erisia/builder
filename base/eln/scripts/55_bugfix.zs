import minetweaker.item.IItemStack;

// Fix the 2x rubber recipe thing.
val resin = <Eln:Eln.sharedItem:4096>;
val rubber = <Eln:Eln.sharedItem:4097>;

furnace.remove(rubber);
furnace.addRecipe(rubber*2, resin);

// Liquid coal
mods.thermalexpansion.Crucible.addRecipe(8000, <Eln:Eln.sharedItem:8>, <liquid:coal> * 100);

//Add dye tag to other coal items
val blackDye = [
  <Eln:Eln.sharedItem:8>,
  <Railcraft:dust:3>,
  <NuclearCraft:material:3>
] as IItemStack[];

for item in blackDye {
    <ore:dyeBlack>.add(item);
}
