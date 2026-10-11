# Dimension sync fix (server-only)

On a dimension change the server sends `SPacketRespawn` and the client builds a new player entity with default
attributes. Forge's `PlayerList.transferPlayerToDimension` (used by `EntityPlayerMP.changeDimension`, FTB Utilities'
/home and Astral Sorcery's Celestial Gateway) resends the watched attributes afterwards. NetherPortalFix
(`net.blay09.mods.netherportalfix.NetherPortalFix`) cancels Forge's travel for portals it has a stored pairing for and
teleports with its own copy of the old vanilla routine. That routine sends no `SPacketEntityProperties`, and it also
skips Universal Tweaks' "Dimension Change Player States" mixins. The client then shows base max health and reach
(Spice of Life: Carrot Edition hearts, Astral Sorcery perks) until relog, while the server keeps the real values.

Both routines fire `PlayerChangedDimensionEvent` last. This mod listens to it at lowest priority and sends:
- `SPacketEntityProperties` with the player's watched attributes;
- the player's abilities (`sendPlayerAbilities`);
- `setPlayerHealthUpdated`, so health and food are resent on the next tick.

On the Forge path these are harmless duplicates.

Build: `nix build .#dimsync-fix`. `src/stubs` holds compile-only stand-ins with SRG names (checked against Cleanroom's
`deobf_data-1.12.2.tsrg`): `field_71135_a` = `connection`, `func_147359_a` = `sendPacket`, `func_145782_y` =
`getEntityId`, `func_110140_aT` = `getAttributeMap`, `func_111160_c` = `getWatchedAttributes`, `func_71016_p` =
`sendPlayerAbilities`, `func_71118_n` = `setPlayerHealthUpdated`. They are not packaged.
