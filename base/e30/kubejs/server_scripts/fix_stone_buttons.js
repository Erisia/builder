onEvent('recipes', event => {
    event.remove({ id: 'extcaves:pebble_stone' });
    event.shapeless('9x extcaves:pebble_stone', 'minecraft:stone_button');
})