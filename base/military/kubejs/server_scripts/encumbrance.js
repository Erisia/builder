// priority: 100
// "Heavy Freight" rule: Bedrock Ore Chunks must never ride in a player's
// personal inventory — long-distance ore has to go by Create freight train.
//   1. canPickUp   - refuse to let a player pick a chunk up off the ground.
//   2. tick sweep  - eject any chunk that reaches a player inventory by any path
//                    (shift-click out of a chest, dispenser, etc.), dropping it
//                    at their feet with a chat notice.
// NOTE: in CREATIVE mode the client is authoritative over its own inventory and
// will revert the server-side removal, so the rule only fully applies in
// SURVIVAL (the actual play mode). That's expected — creative bypasses it.

function isBedrockChunk(stack) {
  if (!stack || stack.isEmpty()) return false;
  const id = stack.getId();
  return id.startsWith("kubejs:bedrock_") && id.endsWith("_ore_chunk");
}

// Layer 1: block ground pickup of the tagged chunks.
ItemEvents.canPickUp("#kubejs:bedrock_ore_chunks", (event) => {
  event.cancel();
});

// Layer 2: inventory sweep, every tick (cheap; only acts when a chunk is found).
PlayerEvents.tick((event) => {
  const player = event.player;
  if (!player || player.isFake()) return;
  if (player.level.isClientSide()) return; // server-authoritative side only

  const inv = player.inventory;
  const size = inv.getContainerSize();
  let ejected = 0;
  for (let i = 0; i < size; i++) {
    const stack = inv.getItem(i);
    if (isBedrockChunk(stack)) {
      const dropped = stack.copy();
      inv.setItem(i, Item.of("minecraft:air"));
      player.drop(dropped, false);
      ejected++;
    }
  }
  if (ejected > 0) {
    player.tell(Text.red("Cargo is too heavy to carry. Use a freight train!"));
  }
});
