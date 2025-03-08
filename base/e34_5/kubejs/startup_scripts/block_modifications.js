const speedModify = [
  {
    speed: 1,
    blocks: [
      "ftbstuff:white_barrel",
      "ftbstuff:green_barrel",
      "ftbstuff:blue_barrel",
      "ftbstuff:purple_barrel",
      "ftbstuff:red_barrel",
      "ftbstuff:black_barrel",
      "ftbstuff:golden_barrel",
      "ftbstuff:small_crate",
      "ftbstuff:crate",
      "ftbstuff:pulsating_crate",
    ],
  },
];

BlockEvents.modification((event) => {
  speedModify.forEach((blocks) => {
    blocks.blocks.forEach((block) => {
      event.modify(block, (modification) => {
        modification.destroySpeed = blocks.speed;
      });
    });
  });
});
