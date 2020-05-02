import minetweaker.item.IItemStack;
import mods.nei.NEI;

val hidden = [
// Decorative blocks without recipes:
  <CaveBiomes:CinderShroom>, // CinderShroom
  <CaveBiomes:DerangedGolem_spawner>, // tile.DerangedGolem_spawner.name
  <CaveBiomes:Mummy_spawner>, // tile.Mummy_spawner.name
  <CaveBiomes:Pharoh_spawner>, // tile.Pharoh_spawner.name
  <CaveBiomes:SkeletonKnight_spawner>, // tile.SkeletonKnight_spawner.name
  <CaveBiomes:SkeletonMage_spawner>, // tile.SkeletonMage_spawner.name
  <CaveBiomes:Witch_spawner>, // tile.Witch_spawner.name
  <CaveBiomes:cave_orchid>, // Cave Orchid
  <CaveBiomes:dripping_lava_stone>, // Lava Stone
  <CaveBiomes:dripping_water_dirt>, // Damp Dirt
  <CaveBiomes:dripping_water_stone>, // Damp Stone
  <CaveBiomes:foxfire>, // Foxfire
  <CaveBiomes:frozen_fence>, // Icy Fence
  <CaveBiomes:frozen_lit_redstone_column>, // Icy Redstone Column
  <CaveBiomes:frozen_lit_redstone_stalactite_base>, // Icy Redstone Stalactite
  <CaveBiomes:frozen_lit_redstone_stalactite_small>, // Icy Redstone Stalactite
  <CaveBiomes:frozen_lit_redstone_stalactite_tip>, // Icy Redstone Stalactite
  <CaveBiomes:frozen_lit_redstone_stalagmite_base>, // Icy Redstone Stalagmite
  <CaveBiomes:frozen_lit_redstone_stalagmite_small>, // Icy Redstone Stalagmite
  <CaveBiomes:frozen_lit_redstone_stalagmite_tip>, // Icy Redstone Stalagmite
  <CaveBiomes:frozen_rail>, // Icy Rail
  <CaveBiomes:frozen_redstone_column>, // Icy Redstone Column
  <CaveBiomes:frozen_redstone_stalactite_base>, // Icy Redstone Stalactite
  <CaveBiomes:frozen_redstone_stalactite_small>, // Icy Redstone Stalactite
  <CaveBiomes:frozen_redstone_stalactite_tip>, // Icy Redstone Stalactite
  <CaveBiomes:frozen_redstone_stalagmite_base>, // Icy Redstone Stalagmite
  <CaveBiomes:frozen_redstone_stalagmite_small>, // Icy Redstone Stalagmite
  <CaveBiomes:frozen_redstone_stalagmite_tip>, // Icy Redstone Stalagmite
  <CaveBiomes:frozen_roots>, // tile.frozen_roots.0.name
  <CaveBiomes:frozen_sandstone_column>, // Icy Sandstone Column
  <CaveBiomes:frozen_sandstone_stalactite_base>, // Icy Sandstone Stalactite
  <CaveBiomes:frozen_sandstone_stalactite_small>, // Icy Sandstone Stalactite
  <CaveBiomes:frozen_sandstone_stalactite_tip>, // Icy Sandstone Stalactite
  <CaveBiomes:frozen_sandstone_stalagmite_base>, // Icy Sandstone Stalagmite
  <CaveBiomes:frozen_sandstone_stalagmite_small>, // Icy Sandstone Stalagmite
  <CaveBiomes:frozen_sandstone_stalagmite_tip>, // Icy Sandstone Stalagmite
  <CaveBiomes:frozen_stone_column>, // tile.frozen_stone_column.0.name
  <CaveBiomes:frozen_stone_stalactite_base>, // Icy Stone Stalactite
  <CaveBiomes:frozen_stone_stalactite_small>, // Icy Stone Stalactite
  <CaveBiomes:frozen_stone_stalactite_tip>, // Icy Stone Stalactite
  <CaveBiomes:frozen_stone_stalagmite_base>, // Icy Stone Stalagmite
  <CaveBiomes:frozen_stone_stalagmite_small>, // Icy Stone Stalagmite
  <CaveBiomes:frozen_stone_stalagmite_tip>, // Icy Stone Stalagmite
  <CaveBiomes:glowstone_stalactite_small>, // Glowstone Stalactite
  <CaveBiomes:hanging_foxfire>, // Hanging Foxfire
  <CaveBiomes:ice_patch>, // Ice
  <CaveBiomes:icicle_base>, // Icicle
  <CaveBiomes:icicle_small>, // Icicle
  <CaveBiomes:icicle_tip>, // Icicle
  <CaveBiomes:lava_vine>, // Cave Vines
  <CaveBiomes:lit_redstone_column>, // Redstone Column
  <CaveBiomes:lit_redstone_stalactite_base>, // Redstone Stalactite
  <CaveBiomes:lit_redstone_stalactite_small>, // Redstone Stalactite
  <CaveBiomes:lit_redstone_stalactite_tip>, // Redstone Stalactite
  <CaveBiomes:lit_redstone_stalagmite_base>, // Redstone Stalagmite
  <CaveBiomes:lit_redstone_stalagmite_small>, // Redstone Stalagmite
  <CaveBiomes:lit_redstone_stalagmite_tip>, // Redstone Stalagmite
  <CaveBiomes:moss>, // Moss
  <CaveBiomes:mossy_dirt>, // Mossy Dirt
  <CaveBiomes:mossy_stone>, // Mossy Stone
  <CaveBiomes:mummy_boots>, // item.mummy_boots.name
  <CaveBiomes:mummy_chestplate>, // item.mummy_chestplate.name
  <CaveBiomes:mummy_helmet>, // item.mummy_helmet.name
  <CaveBiomes:mummy_leggings>, // item.mummy_leggings.name
  <CaveBiomes:pharaoh_boots>, // item.pharaoh_boots.name
  <CaveBiomes:pharaoh_chestplate>, // item.pharaoh_chestplate.name
  <CaveBiomes:pharaoh_helmet>, // item.pharaoh_helmet.name
  <CaveBiomes:pharaoh_leggings>, // item.pharaoh_leggings.name
  <CaveBiomes:raining_lava_stone>, // Lava Stone
  <CaveBiomes:raining_water_stone>, // Rainstone
  <CaveBiomes:redstone_column>, // Redstone Column
  <CaveBiomes:redstone_stalactite_base>, // Redstone Stalactite
  <CaveBiomes:redstone_stalactite_small>, // Redstone Stalactite
  <CaveBiomes:redstone_stalactite_tip>, // Redstone Stalactite
  <CaveBiomes:redstone_stalagmite_base>, // Redstone Stalagmite
  <CaveBiomes:redstone_stalagmite_small>, // Redstone Stalagmite
  <CaveBiomes:redstone_stalagmite_tip>, // Redstone Stalagmite
  <CaveBiomes:roots>, // Roots
  <CaveBiomes:sandstone_column>, // Sandstone Column
  <CaveBiomes:sandstone_stalactite_base>, // Sandstone Stalactite
  <CaveBiomes:sandstone_stalactite_small>, // Sandstone Stalactite
  <CaveBiomes:sandstone_stalactite_tip>, // Sandstone Stalactite
  <CaveBiomes:sandstone_stalagmite_base>, // Sandstone Stalagmite
  <CaveBiomes:sandstone_stalagmite_small>, // Sandstone Stalagmite
  <CaveBiomes:sandstone_stalagmite_tip>, // Sandstone Stalagmite
  <CaveBiomes:stone_column>, // Stone Column
  <CaveBiomes:stone_lavacrust>, // Stone Lava Crust
  <CaveBiomes:stone_stalactite_base>, // Stone Stalactite
  <CaveBiomes:stone_stalactite_small>, // Stone Stalactite
  <CaveBiomes:stone_stalactite_tip>, // Stone Stalactite
  <CaveBiomes:stone_stalagmite_base>, // Stone Stalagmite
  <CaveBiomes:stone_stalagmite_small>, // Stone Stalagmite
  <CaveBiomes:stone_stalagmite_tip>, // Stone Stalagmite

// Microblocks which are essentially duplicate
  <ExtraUtilities:microblocks>, // ERR
  <ForgeMicroblock:microblock>,
  <appliedenergistics2:item.ItemFacade>,

// Technical blocks
  <Eln:Eln.lightBlock>
] as IItemStack[];

for item in hidden {
  NEI.hide(item);
}

