// priority: 100
// Intermediates for the IT ore-refining pipeline: 10 'Crushed Bedrock <M> Ore'
// items + a slurry and a molten-slurry fluid per metal. Textures/tints are
// placeholders. See server_scripts/recipes/refining.js for the chain.
StartupEvents.registry('item', (event) => {
  event.create('kubejs:crushed_bedrock_iron_ore').displayName('Crushed Bedrock Iron Ore').texture('minecraft:item/raw_iron');
  event.create('kubejs:crushed_bedrock_copper_ore').displayName('Crushed Bedrock Copper Ore').texture('minecraft:item/raw_copper');
  event.create('kubejs:crushed_bedrock_gold_ore').displayName('Crushed Bedrock Gold Ore').texture('minecraft:item/raw_gold');
  event.create('kubejs:crushed_bedrock_bauxite_ore').displayName('Crushed Bedrock Aluminum Ore').texture('immersiveengineering:item/raw_aluminum');
  event.create('kubejs:crushed_bedrock_lead_ore').displayName('Crushed Bedrock Lead Ore').texture('immersiveengineering:item/raw_lead');
  event.create('kubejs:crushed_bedrock_silver_ore').displayName('Crushed Bedrock Silver Ore').texture('immersiveengineering:item/raw_silver');
  event.create('kubejs:crushed_bedrock_nickel_ore').displayName('Crushed Bedrock Nickel Ore').texture('immersiveengineering:item/raw_nickel');
  event.create('kubejs:crushed_bedrock_uranium_ore').displayName('Crushed Bedrock Uranium Ore').texture('immersiveengineering:item/raw_uranium');
  event.create('kubejs:crushed_bedrock_zinc_ore').displayName('Crushed Bedrock Zinc Ore').texture('create:item/raw_zinc');
  event.create('kubejs:crushed_bedrock_tungsten_ore').displayName('Crushed Bedrock Tungsten Ore').texture('superbwarfare:item/scheelite');
});
StartupEvents.registry('fluid', (event) => {
  event.create('kubejs:bedrock_iron_ore_slurry').displayName('Bedrock Iron Ore Slurry').thickTexture(0x8B6F5A).bucketColor(0x8B6F5A);
  event.create('kubejs:molten_iron_ore_slurry').displayName('Molten Iron Ore Slurry').thickTexture(0xE8935A).bucketColor(0xE8935A);
  event.create('kubejs:bedrock_copper_ore_slurry').displayName('Bedrock Copper Ore Slurry').thickTexture(0x8A4B32).bucketColor(0x8A4B32);
  event.create('kubejs:molten_copper_ore_slurry').displayName('Molten Copper Ore Slurry').thickTexture(0xE0794A).bucketColor(0xE0794A);
  event.create('kubejs:bedrock_gold_ore_slurry').displayName('Bedrock Gold Ore Slurry').thickTexture(0x8A7A2E).bucketColor(0x8A7A2E);
  event.create('kubejs:molten_gold_ore_slurry').displayName('Molten Gold Ore Slurry').thickTexture(0xF6D64B).bucketColor(0xF6D64B);
  event.create('kubejs:bedrock_bauxite_ore_slurry').displayName('Bedrock Aluminum Ore Slurry').thickTexture(0x7A6A5A).bucketColor(0x7A6A5A);
  event.create('kubejs:molten_bauxite_ore_slurry').displayName('Molten Aluminum Ore Slurry').thickTexture(0xD9DEE0).bucketColor(0xD9DEE0);
  event.create('kubejs:bedrock_lead_ore_slurry').displayName('Bedrock Lead Ore Slurry').thickTexture(0x4A4A5A).bucketColor(0x4A4A5A);
  event.create('kubejs:molten_lead_ore_slurry').displayName('Molten Lead Ore Slurry').thickTexture(0x8E8EA6).bucketColor(0x8E8EA6);
  event.create('kubejs:bedrock_silver_ore_slurry').displayName('Bedrock Silver Ore Slurry').thickTexture(0x6A7A82).bucketColor(0x6A7A82);
  event.create('kubejs:molten_silver_ore_slurry').displayName('Molten Silver Ore Slurry').thickTexture(0xC7D2DA).bucketColor(0xC7D2DA);
  event.create('kubejs:bedrock_nickel_ore_slurry').displayName('Bedrock Nickel Ore Slurry').thickTexture(0x7A7A5A).bucketColor(0x7A7A5A);
  event.create('kubejs:molten_nickel_ore_slurry').displayName('Molten Nickel Ore Slurry').thickTexture(0xC8C0A0).bucketColor(0xC8C0A0);
  event.create('kubejs:bedrock_uranium_ore_slurry').displayName('Bedrock Uranium Ore Slurry').thickTexture(0x3A5A2E).bucketColor(0x3A5A2E);
  event.create('kubejs:molten_uranium_ore_slurry').displayName('Molten Uranium Ore Slurry').thickTexture(0x4ED24E).bucketColor(0x4ED24E);
  event.create('kubejs:bedrock_zinc_ore_slurry').displayName('Bedrock Zinc Ore Slurry').thickTexture(0x6A7A6A).bucketColor(0x6A7A6A);
  event.create('kubejs:molten_zinc_ore_slurry').displayName('Molten Zinc Ore Slurry').thickTexture(0xC8CDB6).bucketColor(0xC8CDB6);
  event.create('kubejs:bedrock_tungsten_ore_slurry').displayName('Bedrock Tungsten Ore Slurry').thickTexture(0x2A2A30).bucketColor(0x2A2A30);
  event.create('kubejs:molten_tungsten_ore_slurry').displayName('Molten Tungsten Ore Slurry').thickTexture(0x5A5A60).bucketColor(0x5A5A60);
});
