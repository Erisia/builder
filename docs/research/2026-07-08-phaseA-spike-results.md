# Phase A verification spike — results (2026-07-08)

Spike for the Heavy Industry & Freight Logistics feature (see `docs/design/2026-07-07-heavy-industry-freight-logistics.md` and the plan). Goal: de-risk the encumbrance mechanic and stand up a bot-driven test loop before the full build.

## RESULT: Encumbrance gate = PASS (KubeJS-only, no custom mod needed)

Verified on the **actual pack build**: Forge 1.20.1 / KubeJS `2001.6.5-build.26` / Rhino `2001.2.3-build.10` / Architectury `9.2.14`.

- Added KubeJS + Rhino + Architectury to `manifest/military.yaml` → resolves + builds + boots to `Done` with **0 script errors**.
- `base/military/kubejs/startup_scripts/bedrock_ore_chunks.js` registers **12 non-stackable** `kubejs:bedrock_*_ore_chunk` items and tags them `kubejs:bedrock_ore_chunks` (`added 12 objects` confirmed in the item-tag log). `event.create().displayName().maxStackSize(1).tag()` all work.
- `base/military/kubejs/server_scripts/encumbrance.js` (canPickUp + tick-eject) loads clean.
- **Runtime, driven by an MCC bot** (see harness notes): `/give FreightBot kubejs:bedrock_iron_ore_chunk 1` →
  - Chat shows **"Cargo is too heavy to carry. Use a freight train!"** (the `player.tell` fired — tick-eject ran, no runtime error).
  - Watched 10 s → **exactly 1** eject message. If `canPickUp` cancellation were broken (KubeJS issue #419), the item dropped at the bot's feet would be re-picked and re-ejected every 0.5 s → ~20 messages. One message ⇒ **`canPickUp` correctly blocks re-pickup on this build.** Issue #419 does NOT affect KubeJS 2001.6.5.
  - `/give …gold_ore_chunk 64` → non-stackable items all ejected in one sweep (one message).

**Conclusion:** the "chunk can never ride in a player's inventory" rule is fully enforceable in KubeJS on this build — non-stackable item + `canPickUp` block (ground) + `PlayerEvents.tick` eject backstop (any other insertion path). No custom mod / mod-spec handoff required. Machine transfer (hopper/chute into a train) is unaffected by `canPickUp`, which is exactly what the freight design wants.

Verified-working KubeJS 1.20.1 APIs (for later phases): `StartupEvents.registry('item')`, ItemBuilder `.displayName/.maxStackSize/.tag`, `ItemEvents.canPickUp('#tag', e=>e.cancel())`, `PlayerEvents.tick`, `player.age`, `player.isFake()`, `player.inventory.getContainerSize/getItem/setItem`, `Item.of('minecraft:air')`, `player.drop(stack, false)`, `player.tell(Text.red(...))`.

## Test-harness findings (important for Phase H / the reusable harness)

The bot-driven loop works, but with hard constraints discovered here:

1. **MCC cannot join the FULL 68-mod pack.** MCC (Minecraft Console Client, v26.2/build 478) does the FML handshake for simple modded servers, but against the full pack it stalls at "Logging in..." and drops during FML registry/login negotiation (server never logs a join). **It joins a reduced mod set fine.** → Automated bot tests must run against a **minimal server** (Forge + only the mods under test + their deps), not the full pack. The full pack is still boot-tested via `tools/docker-run-server.sh` (reaches `Done`); bots test behavior on a stripped server.
   - The encumbrance mechanic is pure KubeJS, so a minimal server (Forge + KubeJS + Rhino + Architectury + the scripts) is a *sound* place to test it — the other 60 mods are irrelevant to it.
2. **Two whitelists gate a test bot**, both must be off for the throwaway test server:
   - Mod-whitelist anti-cheat: `config/mod_whitelist-config.json` `USE_WHITELIST_ONLY:true` + `CLIENT_MOD_NECESSARY:["mod_whitelist"]` → silently kicks any client without the mod fingerprint.
   - Vanilla `white-list=true` in `server.properties` → "You are not white-listed on this server!".
3. **MCC binary can't run inside the `nixos/nix` container** (no `/lib64/ld-linux-x86-64.so.2`). Run MCC **on the host** against the container IP (`docker inspect` → `172.17.0.x`), server port **25566** (military's `server-port`). Host↔container bridge networking works on this WSL2 box.
4. Server must be **offline-mode** for cracked MCC bots (`online-mode=false`).
5. `/inventory` MCC command needs a subcommand (`/inventory player list`); bare `/inventory` prints help.

All the above patches were applied only to the container's throwaway `/root/military-*` copies — **repo source configs are untouched** (production still `white-list=true`, `online-mode=true`, `USE_WHITELIST_ONLY:true`).

## Follow-up actions this surfaced (fold into the build)

- **`base/military-server/config/mod_whitelist-config.json` must add `kubejs`, `rhino`, `architectury`** (and, when added, `immersivetechnology`/`immersive_convergence`/`immersive_fixes`) to `CLIENT_MOD_WHITELIST`, or the anti-cheat will kick real clients once these ship. (Same class of gotcha as the `chat_heads`/`nemos_inventory_sorting` modid issues in the pack's history — verify each modid from the jar's `mods.toml`.)
- Immersive Technology brings **2 extra deps** (Immersive Fixes + Immersive Convergence) — defer to the Phase F build; the encumbrance/world-gen phases don't need it.
- Reusable harness (Phase H): package the host-side MCC driver + the "strip to a minimal mod set" + "patch offline/whitelists" steps. Its home (mc-erisia vs mc-projects) still open per the plan.

## Still to spike (Phase A remainder)
- #2 IE `ie_mineral_mix` → **note: path/schema changed in 1.20.1** — mixes are recipes at `data/immersiveengineering/recipes/mineral/*.json`, serializer supports only `dimensions/fail_chance/ores/spoils/weight` (no biome predicates). See `2026-07-08-military-excavator-ore-inventory.md`. Override-loads-correctly still to be confirmed on a booted server.
- #3 Immersive Technology KubeJS recipe surface — unverified until IT is added.
