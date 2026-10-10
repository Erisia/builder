# Step height fix (server-only)

Vanilla 1.12.2 sets a server-side player's `stepHeight` to 1.0 in the `EntityPlayerMP` constructor.
Chibi ships VanillaFix's `MixinEntityPlayerMP`, which sets it to 0.7 instead; the mixin config
(`mixins.vfix_bugfixes.json`) loads on dedicated servers only and has no config switch.

Astral Sorcery's Step Assist perk (`KeyStepAssist`) adds 0.5 on the server and `PktSyncStepAssist` sends the
client `server - 0.4`, which assumes the vanilla 1.0 base: 1.5 on the server, 1.1 on the client. With Chibi it is
1.2 and 0.8, and the player can't step up a block. Step items that set absolute values on both sides (Botania's
Sojourner's Sash, DE armour) are not affected.

This mod listens to `EntityJoinWorldEvent`, which fires right after a new player entity is constructed (login,
respawn) and before any perk tick, and sets `stepHeight` from exactly 0.7 back to 1.0. Other values are left alone.

Build: `nix build .#stepheight-fix`. `src/stubs` holds compile-only stand-ins with SRG names
(`field_70138_W` = `stepHeight`, checked against Cleanroom's `deobf_data-1.12.2.tsrg`); they are not packaged.
