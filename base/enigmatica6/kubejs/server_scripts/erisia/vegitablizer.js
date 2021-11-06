onEvent("item.entity_interact", (event) => {
  if (event.hand == MAIN_HAND && event.item.id == "minecraft:carrot_on_a_stick" && event.target.isPeacefulCreature()) {
    event.server.scheduleInTicks(1, event.server, function (callback) {
      event.player.tell(`Stopped AI for ${event.target}`)
      callback.server.runCommandSilent(
        `execute as ${event.target} run data merge entity @s {NoAI:1b}`
      );
    });
  }
});
