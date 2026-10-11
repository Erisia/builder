# Step height fix (server-only)

Vanilla 1.12.2 sets a server-side player's `stepHeight` to 1.0 in the `EntityPlayerMP` constructor.
Chibi ships VanillaFix's `MixinEntityPlayerMP`, which sets it to 0.7 instead; the mixin config
(`mixins.vfix_bugfixes.json`) loads on dedicated servers only and has no config switch.

Astral Sorcery's Step Assist perk (`KeyStepAssist`) adds 0.5 on the server and `PktSyncStepAssist` sends the
client `server - 0.4`, which assumes the vanilla 1.0 base: 1.5 on the server, 1.1 on the client. With Chibi it is
1.2 and 0.8, and the player can't step up a block.

Step Assist adds its 0.5 only when the perk activates (login, respawn). It then refreshes its 20-tick cooldown every
tick and only keeps the server at 1.1 or above. Step gear sets a fixed value on both sides when taken off: exactly 0.6
(Botania sashes, Cyclic's step apple, Mystical Agriculture armour, Mekanism, Blood Magic) or 0.5 (Avaritia's infinity
boots, Quark's jump-boost step assist). After that the perk sits at 1.1 on the server and 0.7 on the client until
relog. This happened before Chibi too. (Draconic Evolution resets only the client; AS resyncs the client every tick.)

This mod listens to `EntityJoinWorldEvent`, which fires right after a new player entity is constructed (login,
respawn) and before any perk tick, and sets `stepHeight` from exactly 0.7 back to 1.0. It also listens to
`LivingUpdateEvent` at lowest priority and sets a server player's `stepHeight` from exactly 1.1 (only Step Assist's
floor produces it) to the perk's intended 1.5, so the client gets 1.1 again. The perk's timeout subtracts 0.5,
leaving 1.0. Other values are left alone.

Build: `nix build .#stepheight-fix`. `src/stubs` holds compile-only stand-ins with SRG names
(`field_70138_W` = `stepHeight`, checked against Cleanroom's `deobf_data-1.12.2.tsrg`); they are not packaged.
