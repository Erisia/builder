# DankNull migrate (server-only)

DankNull 1.7.95+ stores a dank null's contents under `tag.DankNullCap`; 1.7.91 merged the same NBT into the
stack's root tag. 1.7.95+ ignores the root keys (upstream chose to drop old contents, see DankNull #275 and
commit 24d2f6d241) but never deletes them, so the data is still in the world.

This mod listens to `AttachCapabilitiesEvent<ItemStack>`, which Forge fires while building a stack from NBT,
after the tag is set and before DankNull's lazy first read. For a dank null whose root tag still has
`danknull-inventory` and whose `DankNullCap` has none, it:

- moves `danknull-inventory`, `OreDictModes`, `ExtractionModes`, `PlacementModes`, `selectedIndex`, `Locked`
  into `DankNullCap`;
- deletes them from the root (otherwise an emptied dank null would match again and refill: a dupe);
- adds an explicit `KEEP_ALL` extraction mode for stored items without one, since 1.7.97 changed the
  default from KEEP_ALL to KEEP_1 (pipes on docks would otherwise start draining);
- logs one `DankNullMigrate` line per stack, and totals at server stop.

If `DankNullCap` already holds items (it was used under 1.7.95+ without this mod) it logs a warning and
changes nothing. Docks are covered: the dock tile entity builds its stack from NBT the same way.
Dank nulls stored inside other items (backpacks, AE2 cells) migrate when they are next loaded as stacks,
so keep the mod installed. Ship it in the same restart as the DankNull update.

Build: `nix build .#danknull-migrate`. Minecraft classes are not on the compile classpath, so
`src/stubs` holds compile-only stand-ins with SRG names (checked against Cleanroom's
`deobf_data-1.12.2.tsrg`); they are not packaged.
