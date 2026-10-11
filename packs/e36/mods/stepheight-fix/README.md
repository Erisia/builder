# Step height fix (server-only)

Vanilla 1.12.2 sets a server-side player's `stepHeight` to 1.0 in the `EntityPlayerMP` constructor.
Chibi ships VanillaFix's `MixinEntityPlayerMP`, which sets it to 0.7 instead; the mixin config
(`mixins.vfix_bugfixes.json`) loads on dedicated servers only and has no config switch.

Astral Sorcery's Step Assist perk (`KeyStepAssist`) adds 0.5 on the server and `PktSyncStepAssist` sends the
client `server - 0.4`, which assumes the vanilla 1.0 base: 1.5 on the server, 1.1 on the client. With Chibi it is
1.2 and 0.8, and the player can't step up a block.

The perk adds its 0.5 only when it activates (login, respawn). It then refreshes its 20-tick cooldown every tick and
only keeps the server at 1.1 or above. Step gear sets a fixed value on both sides when taken off: 0.6 (Botania sashes,
Mystical Agriculture armour, Mekanism Free Runners, Blood Magic Boost) or 0.5 (Avaritia infinity boots, Quark's
jump-boost step assist). The perk then sits at 1.1 on the server and 0.7 on the client until relog, before Chibi too.

1. `KeyStepAssistMixin` (a late mixin, queued by `StepHeightMixinLoader` through Cleanroom's built-in MixinBooter)
   redirects both `stepHeight` writes in `KeyStepAssist.onPlayerTick` to set at least 1.5, the value the perk
   intends (client 1.1), whatever the base or the reset value. Higher values from worn gear are kept. The perk's
   timeout (-0.5) then leaves 1.0. Targets use runtime (SRG) names, so there is no refmap. The config is required
   and the redirect must match, so an Astral Sorcery change that breaks it fails loudly at startup.
2. On `EntityJoinWorldEvent` (right after a new player entity is constructed, before any perk tick) it sets
   `stepHeight` from exactly 0.7 back to vanilla's 1.0. Other values are left alone.

Build: `nix build .#stepheight-fix`. `src/stubs` holds compile-only stand-ins with SRG names
(`field_70138_W` = `stepHeight`, checked against Cleanroom's `deobf_data-1.12.2.tsrg`); they are not packaged.
