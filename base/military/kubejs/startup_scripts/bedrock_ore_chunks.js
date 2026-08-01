// priority: 100
// Registers the un-carriable "Bedrock <Ore> Ore Chunk" items the IE Excavator
// produces instead of raw ore. Every chunk is non-stackable: one chunk stands in
// for a full stack of ore once processed, and being un-stackable reinforces the
// "heavy freight" feel. Textures are borrowed from each metal's raw item / gem
// (placeholder art until custom textures are drawn).
StartupEvents.registry("item", (event) => {
  // [id suffix, display name, borrowed texture]
  global.BEDROCK_CHUNKS = [
    ["iron",     "Iron",     "minecraft:item/raw_iron"],
    ["copper",   "Copper",   "minecraft:item/raw_copper"],
    ["gold",     "Gold",     "minecraft:item/raw_gold"],
    ["bauxite",  "Bauxite",  "immersiveengineering:item/raw_aluminum"],
    ["lead",     "Lead",     "immersiveengineering:item/raw_lead"],
    ["silver",   "Silver",   "immersiveengineering:item/raw_silver"],
    ["nickel",   "Nickel",   "immersiveengineering:item/raw_nickel"],
    ["uranium",  "Uranium",  "immersiveengineering:item/raw_uranium"],
    ["tungsten", "Tungsten", "superbwarfare:item/scheelite"],
    ["zinc",     "Zinc",     "create:item/raw_zinc"],
    ["diamond",  "Diamond",  "minecraft:item/diamond"],
    ["lapis",    "Lapis",    "minecraft:item/lapis_lazuli"],
  ];

  global.BEDROCK_CHUNKS.forEach(([id, name, texture]) => {
    event
      .create(`kubejs:bedrock_${id}_ore_chunk`)
      .displayName(`Bedrock ${name} Ore Chunk`)
      .tooltip("§7Too heavy to carry — move by freight train.")
      .maxStackSize(1)
      .texture(texture)
      .tag("kubejs:bedrock_ore_chunks");
  });
});
