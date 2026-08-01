// priority: 50
// Phase E — track economy.
// FINDING: Create 6's base train-track recipe is already cheap — 1 wooden
// sleeper + 2 iron/zinc NUGGETS per track via sequenced assembly (~0.2 ingot/
// track), NOT the iron-grind the design doc assumed. So the base recipe is left
// UNTOUCHED.
// This only ADDS a thematic bulk recipe matching the design's "gated behind
// Coke Oven + Steel" intent: once a player has IE steel production, they get a
// fast bulk source of track. Non-exclusive; the cheap base path still works.
ServerEvents.recipes((event) => {
  event
    .shapeless(Item.of("create:track", 32), [
      "immersiveengineering:plate_steel",
      "6x immersiveengineering:slab_treated_wood_horizontal",
    ])
    .id("kubejs:track_from_steel");
});
