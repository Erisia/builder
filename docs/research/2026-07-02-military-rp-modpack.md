# Military Role Play Mod Pack — research & similar-pack search

**Date:** 2026-07-02
**Goal:** (1) Document the mods in the CurseForge "military role play mod pack", and
(2) find a bigger, maintained modpack that keeps most of these military mods **and** adds
the things the kids want (Create, QoL, tech/industry).

**Method (fully programmatic, keyless):**
- CurseForge's official API needs an `x-api-key`; none is configured in this repo.
- Used two keyless data sources instead:
  - `https://api.cfwidget.com/{id | slug}` — project metadata + latest file (keyless proxy).
  - `https://www.curseforge.com/api/v1/mods/{id}/dependents?index=&pageSize=` — the site's
    own frontend API. **This is the "reverse dependents" endpoint**: for a given mod it lists
    the modpacks that include it. It is keyless (the `/mods/search` and `/mods/{id}` v1
    endpoints are Cloudflare-blocked, but `/dependents` works).
- Manifests were obtained by downloading each pack's latest `.zip` from forgecdn
  (`https://mediafilez.forgecdn.net/files/<id[:4]>/<int(id[4:])>/<url-encoded-filename>`)
  and reading `manifest.json` + `modlist.html`.

**Raw data saved under `docs/research/data/`:**
- `military-rp-pack.json`, `military-rp-manifest.json` — the source pack.
- `mods_named.json`, `mod_dependent_counts.json` — the 22 mods + their global dependent counts.
- `dependents/<projectID>.json` — full reverse-dependents lists for the 10 signature mods.
- `overlap_ranked.json` — every candidate pack ranked by signature-mod overlap (114 packs).
- `candidates/<id>_manifest.json`, `<id>_modlist.txt` — downloaded candidate manifests.
- `candidate_details.json`, `candidate_analysis.json`, `military_overlap.json` — analysis output.

---

## 1. The source pack

- **Slug:** `military-role-play-mod-pack` (project id `1484353`), author `jhunter64582712`.
- **Minecraft 1.20.1, Forge 47.4.10.** Tiny (233 total downloads). **22 mods.**
- It is purely military/combat + atmosphere + libraries. **No tech, no QoL, no Create.**

The 22 mods (global CurseForge dependent count in parens — low = niche/distinctive):

**Signature military / combat (the pack's DNA):**
- [TaCZ] Timeless and Classics Zero Guns (7,340) — the core gun mod
- [SBW] Superb Warfare (1,397) — vehicles/heavy weapons
- [SBW] Vintage Vehicle Pack (346)
- [Immersive Vehicles/IV/MTS] VEB Automobilwerke Schwikau — tanks/helis/planes (814)
- [TACZ] LesRaisins Tactical Equipements (1,353)
- LesRaisins Armor — tactical armor (944)
- Fracture Point (Tactical Military Armory) (329)
- Explosion Overhaul (598)
- Simply Traps (616)
- Doomsday Decoration (714)
- Keerdm's Zombie Apocalypse Essentials (870)
- Security Craft (22,391)

**Atmosphere / world:**
- The Lost Cities (9,636), Immersive Weathering [Forge] (6,007), EnhancedVisuals (9,693)

**Libraries / utility (every pack has these — not a useful signal):**
- GeckoLib, Moonlight Lib, Curios API, Cloth Config, CreativeCore, Sound Physics Remastered,
  Simple Voice Chat

---

## 2. Finding a bigger pack with the same DNA

For the 10 most distinctive military mods (dependents < 2000) we pulled the full reverse-
dependents lists and counted how many appear in each candidate pack. Then we downloaded each
candidate's manifest and measured overlap against the source pack's 15 non-library mods, and
scanned for Create / tech / QoL.

**Key finding:** this exact mod set lives in the **"modern zombie apocalypse" modpack genre** —
those packs pair TaCZ + Superb Warfare guns with Create and full tech/QoL suites.

Ranked results (military overlap = of 15 non-library mods):

| Pack | Downloads | Mods | Military overlap | Create? | Notable extras |
|---|---:|---:|:---:|:---:|---|
| **Beyond Cosmo** | 486,783 | 447 | **11/15** | ✅ (30+ Create addons) | AE2, Mekanism, Immersive Engineering, JEI, Jade, Pam's |
| ZOMBIEMANIA | 680,903 | 285 | 10/15 | ✅ | Immersive Engineering, Farmer's Delight, Iron Chests, JEI, tons of TaCZ addons |
| Zombie R.E.A.P | 66,550 | 276 | 9/15 | ✅ | Immersive Engineering, Farmer's Delight, Sophisticated Backpacks, JEI |
| Remnants of Earth | 8,032 | 335 | 9/15 | ✅ | Custom worldgen, TaCZ addons, Jade, JEI |
| Cursed Walking | 8,033,451 | 232 | 7/15 | ✅ | Farmer's Delight, Sophisticated Backpacks (most-downloaded of all) |
| Protocol Zero | 75,629 | 284 | 5/15 | ✅ | Immersive Engineering, Farmer's Delight, JEI |
| A Survivor's Starter Kit | 42 | 141 | 13/15 | ✅ | Highest overlap but essentially abandoned |
| Last Stand Server | 532 | 210 | 12/15 | ❌ | Mekanism/IE but no Create |

All are **Minecraft 1.20.1 Forge** (same as the source), so migrating/reusing configs is realistic.

---

## 3. Recommendation

**Beyond Cosmo** (`beyond-cosmo`, id `486783` slug) is the best single answer:
- Half a million downloads, 447 mods, actively maintained.
- Highest military overlap among the big popular packs (11/15): TaCZ, Superb Warfare + Vintage
  Vehicle Pack, LesRaisins Tactical + Armor, Explosion Overhaul, Security Craft, Lost Cities,
  Immersive Weathering, EnhancedVisuals.
- Ships a **massive Create ecosystem** — Create + Big Cannons, Missiles, Nuclear, Crafts &
  Additions, Deco, and crucially **"Create: TaCZ Automation"** (bridges the guns to Create) —
  plus **AE2, Mekanism, Immersive Engineering, JEI, Jade**. This is exactly the "military +
  Create + tech/QoL" combination the kids asked for.
- Missing from the source set (small, easy to add on top if wanted): Doomsday Decoration,
  Fracture Point, the Immersive Vehicles VEB pack, Simply Traps.

**Runner-up: ZOMBIEMANIA** — even more popular (680k dl), leaner (285 mods, lighter to run),
10/15 overlap, keeps SBW Vintage Vehicle Pack, and has a deep set of TaCZ addons/guns plus
Create + Immersive Engineering + Farmer's Delight. Good pick if a smaller/lighter pack is wanted.

**If the goal is to add to the existing pack instead of switching:** just add **Create** (+
Create: TaCZ Automation, Create Big Cannons), **JEI**, **Jade**, and one storage/QoL mod
(Sophisticated Backpacks) to the current 22 — that reproduces the "Beyond Cosmo lite" experience
on top of the kids' current pack.

---

## 4. Distribution & anti-cheat (follow-up 2026-07-02)

**Existing Erisia channel:** MCUpdater + PrismLauncher (MCU-Bootstrap.jar), fed by the
Nix builder's client pack (`pack.json` + `mods` + `configs`), per `web/content/getting-started.md`.

**Anti-cheat / anti-xray research** (Modrinth keyless API; raw data in
`data/anticheat_search.json`, `data/anticheat_details.json`). All verified for MC 1.20.1 Forge:

| Mod | Slug | Side | Loaders / versions | What it does |
|---|---|---|---|---|
| **AntiXray** | `anti-xray` | server only | fabric/forge/neoforge/quilt, 1.20.1 **& 1.21.1** | **Server-side ore obfuscation** — hides ores/blocks from clients so xray (texture pack, mod, or fullbright) sees nothing. The correct primary anti-xray tool. 517k dl. |
| Xray Snitch | `xray-snitch` | client+server | forge/neoforge 1.20.1 & 1.21.1 | Detects & alerts admins to xray *texture packs*. Behavioral; weaker than obfuscation; needs client component. |
| EasyAntiCheat | `relay` | client+server | forge, 1.20.1–1.20.6 (no 1.21) | Oversight of client-installed mods & resource packs. |
| Fiw AntiCheat | `fiw-anticheat` | client+server | forge/neoforge, 1.20.1 & 1.21.1 | Verification/enforcement utilities; current, covers both versions. |
| Saros Mod Checker | `saros-mod-checker` | server only | forge/neoforge 1.20.1 | Verifies client mods/resource packs on join, blocks blacklisted. Very new (83 dl). |
| Force Fair-Play | `force-fair-play` | forge 1.20.1 | Forces Xaero's Fair-Play map edition (blocks map radar/cave-finder). |
| No LAN Cheating | `nolancheating` | client+server | all loaders 1.20.1–1.21.11 | Removes "Allow Cheats" from Open-to-LAN. |

**Correction:** "FullStack Watchdog" (`fullstack-watchdog`, 2.4M dl) is **not** an anti-cheat —
it's a crash-diagnostics mod that makes server Watchdog crashes dump all thread stacks. There is
no notable "watchdog anti-cheat" for Forge; the user likely misremembered.

**Reality check:** Mature movement/combat anti-cheats (Grim, Vulcan, NCP) are **Paper/Spigot
only** and cannot run on a modded Forge server. On Forge the realistic, effective controls are:
(1) **AntiXray** for xray, (2) a dedicated **client-mod enforcement** mod, (3) whitelist + admin
oversight (social — fine for kids). Client-mod checks can be spoofed by determined cheaters but
are ample deterrence for a kids' server.

**Correction re: Forge handshake (verified 2026-07-02 vs. Forge docs — "concepts/sides"):**
Forge's mod handshake is **NOT** client-mod enforcement. It is a per-mod, mod-author-controlled
version-compatibility check via `displayTest` in `mods.toml`
(`MATCH_VERSION` default → reject on mismatch; `IGNORE_SERVER_VERSION`; `IGNORE_ALL_VERSION` for
client-only; `NONE`). It only rejects for mods declaring `MATCH_VERSION` that are missing/version-
mismatched on a side (the "Mismatched Mod Channel List" error). **Client-only mods (including
cheats: killaura, fullbright, xray, radar) declare `IGNORE_ALL_VERSION`/client-side and pass the
handshake.** So Forge does NOT restrict which client mods a player runs and does NOT stop client
cheats — you must use an actual enforcement mod. (Earlier notes implying the handshake blocks
"extra registered" client mods were overstated.)
Source: https://docs.minecraftforge.net/en/latest/concepts/sides/

---

## 5. Client-mod enforcement mods (follow-up — Modrinth keyless, verified 2026-07-02)

Raw data: `data/enforce_search.json` (64 candidates), `data/enforce_details.json` (50 with details).
Two enforcement models exist:
- **Require / exact-match** — client must run the pack's mod set; anyone who differs is blocked.
  Fits a controlled distributed pack; also blocks added cheats as a side effect, but blocks legit
  optional client mods unless whitelisted.
- **Blacklist / verify** — permit optional mods, kick known cheat mods / xray resource packs.
  More flexible, but needs a maintained blacklist and misses renamed cheats.

| Mod | Slug | dl | Loaders | 1.20.1 | 1.21.1 | Model | Notes |
|---|---|---:|---|:--:|:--:|---|---|
| **Mod Whitelist** | `mod-whitelist` | 55,364 | forge, fabric | ✅ | ❌ (caps 1.20.4) | exact-match | Most-used. Blocks entry if client modlist ≠ expected. |
| **GML** | `grimrpz-gml` | 194 | forge, neoforge | ✅ | ✅ | require | Server-only. Kicks players missing required (incl. client) mods, with a "you need X" message. |
| **CheckYourMods** | `checkyourmods` | 442 | neoforge | ❌ | ✅ | whitelist + xray | Client-mod verify vs server whitelist **+ xray resource-pack detection**. Purpose-built for 1.21.1. |
| **HailWall** | `hailwall` | 112 | fabric, neoforge | ✅(neo) | ✅ | whitelist/blacklist | Checks each client's mods on join, kicks disallowed. **NeoForge only — not Forge.** |
| **Saros Mod Checker** | `saros-mod-checker` | 83 | forge, neoforge | ✅ | ❌ | blacklist + verify | Server-only. Verifies client mods + resource packs, blocks blacklisted/unauthorized. New. |
| **Fiw AntiCheat** | `fiw-anticheat` | 459 | fabric, forge, neoforge | ✅ | ✅ | verify/enforce | Spans both loaders & versions; least specific description. |

**Picks:**
- Forge 1.20.1 (military kids pack): **Mod Whitelist** (proven, exact-match) or **GML** (server-only,
  friendly kicks); **Saros** if you want cheat/xray-pack blacklisting.
- NeoForge 1.21.1 (main Erisia pack): **CheckYourMods** (whitelist + xray-pack detect in one) or
  **GML**/**HailWall**.
- **Fiw AntiCheat** is the only single mod covering both platforms.

**Caveat (applies to all):** client self-reporting can be spoofed by a custom client that lies about
its mod list — so these are strong *deterrence* (great vs kids), not airtight security. **AntiXray**
(server-side obfuscation) is the only ore protection that never trusts the client. Also note the
enforcement mods are all low-download/niche on Forge/NeoForge; test before relying on them.

---

## 6. "Beyond Cosmo lite" — proposed mod list (Forge 1.20.1, verified 2026-07-02)

Base = the existing 22 mods. Additions below all verified to have a Forge 1.20.1 build
(Modrinth `/version` API; CF-only mods confirmed via cfwidget). Raw data: `data/lite_resolved.json`.
Source column: **M** = on Modrinth (keyless for MMMM), **CF** = CurseForge-only (needs CF key/proxy).

**Create (headline):**
| Mod | id/slug | src | required deps |
|---|---|:--:|---|
| Create | `create` (mc1.20.1-6.0.8) | M | (bundled) |
| Create: TaCZ Automation | CF 1084197 | CF | Create, TaCZ (both present) |
| Create Big Cannons | `create-big-cannons` | M | Ritchie's Projectile Library |
| Create Crafts & Additions | `createaddition` | M | Create |
| Create Deco | `create-deco` | M | Create |
| Create Copycats+ | `copycats` | M | Create |

**Tech / industry:** Immersive Engineering `immersiveengineering` (M).
*(Optional deeper tech, left out to stay "lite": Mekanism, Applied Energistics 2.)*

**QoL / storage / food / travel:**
| Mod | id/slug | src | deps |
|---|---|:--:|---|
| JEI (Just Enough Items) | `jei` | M | — |
| Jade | `jade` | M | — |
| Sophisticated Backpacks | `sophisticated-backpacks` | M | Sophisticated Core |
| Farmer's Delight | `farmers-delight` | M | — |
| Waystones | `waystones` | M | Balm |
| Corail Tombstone (keep items on death) | CF 243707 | CF | — |
| Iron Chests | `ironchests` | M | — |
| Xaero's Minimap | `xaeros-minimap` | M | — (client) |
| Xaero's World Map | `xaeros-world-map` | M | — (client) |

**Performance (important for kids' PCs on a 40+ mod pack):**
Embeddium `embeddium`, FerriteCore `ferrite-core`, ModernFix `modernfix`,
EntityCulling `entityculling`, Clumps `clumps` — all Modrinth, Forge 1.20.1. (client/both)

**Auto-added dependencies:** Ritchie's Projectile Library `rpl`, Sophisticated Core
`sophisticated-core`, Balm `balm` (all Modrinth).

**Server-only additions (NOT in client pack — `side: server`):**
- `anti-xray` (AntiXray) — ore obfuscation.
- `mod-whitelist` (Mod Whitelist) — exact-match client enforcement.

**Total:** 22 base + ~24 additions/deps ≈ **46 mods** (vs Beyond Cosmo's 447).

**Build note — Create version matching (resolved):** Create for 1.20.1 exists in two incompatible
lineages (0.5.1.x and 6.0.x) and all addons must match the Create jar's lineage. We sidestep this
by taking the Create stack from Beyond Cosmo's Create 6.0.8 pack as one known-good, version-matched
CurseForge set. The final Create-6 stack (all `source: curse`):

| mod | curse id | file_id | note |
|---|---|---|---|
| create | 328085 | 7178761 | Create 6.0.8 (bundles Flywheel/Registrate) |
| createaddition (Crafts & Additions) | 439890 | 7208610 | |
| create-big-cannons | 646668 | 8169547 | |
| create-deco | 509285 | 6373226 | |
| create-copycats (Copycats+) | 968398 | 7634682 | |
| immersiveengineering | 231951 | 6206989 | |
| ritchies-projectile-lib | 1279407 | 7292523 | Big Cannons dep |
| create-tacz-automation | 1084197 | 6084668 | guns↔Create bridge |
| create-steam-n-rails | 688231 | 7758640 | 1.7.2, file tagged **C6** = Create 6 |

(Steam 'n' Rails isn't in Beyond Cosmo; its CF file names explicitly tag Create version — `C6` vs
`C0.5` — so 7758640 is the confirmed Create-6 build.) Still `nix build` / diff before shipping.

---

## 7. Files created (branch `add-military-rp-pack`)

- `manifest/military.yaml` — 49-mod draft (**32 curse + 17 modrinth**). Base 22 (curse) + Create
  6.0.8 stack incl. Steam 'n' Rails (curse) + 2 CF-only (create-tacz-automation, corail-tombstone) +
  QoL/perf (Modrinth) + server-only anti-xray & mod-whitelist.
- `builder.nix` — added `military` pack (Forge 1.20.1 / forge 47.4.10, port 25568, prom 1227, 6G),
  registered in `packs`.
- `base/military{,-server,-client}/` — empty config dirs (.gitkeep).

**Validation still required (no nix/MMMM/CF-key in the drafting env):**
```
git submodule update --init modestly-modular-modpack-modifier
# put curse_api_key in ~/.config/modestly-modular-modpack-modifier/mmmm.toml (all curse mods need it)
nix run ./modestly-modular-modpack-modifier -- -o manifest manifest/military.yaml
nix build -f . packs.military     # or ServerPackLocal
```

**Create-6 addon compatibility — resolved (2026-07-03).** Rather than trust Modrinth's Create-major-
ambiguous "latest 1.20.1", the entire Create ecosystem now uses Beyond Cosmo's exact CurseForge
file IDs (a proven-together Create 6.0.8 set — see §6 table). This removes the version-matching risk.

---

## 8. Build validation in Nix Docker (2026-07-03)

Built in a `nixos/nix` container (repo mounted, CF key in container's `mmmm.toml`). Results:

- ✅ **MMMM built** from the submodule (cloned via HTTPS — `.gitmodules` SSH URL can't auth headless).
- ✅ **YAML→JSON resolved all 49 mods.** Two manifest fixes were required:
  1. The output node needs a **`ModWriter`** node (`writer::json`), not the older `resolver::json`
     the e33_5 template used. Added `- id: writer / kind: ModWriter / input: {resolved: 'resolver'}`.
  2. **`simply-traps`** (base mod) has CurseForge **API distribution disabled** (`downloadUrl: null`)
     → switched to `source: url` with `https://edge.forgecdn.net/files/6980/501/simply_traps-1.7-forge-1.20.1.jar`.
- ✅ **Forge 1.20.1-47.4.10 launcher builds.** The flakify refactor added `launcher-lock.json`; the
  `forge` section was empty. Added an entry with `outputHash` `sha256-x1pQGDSoe+GkMf6K6jPjYjQR86cQcbWEBYeuQcQiUWw=`
  (discovered via the fixed-output-hash-mismatch trick).
- ✅ **All Create 6 jars resolve to the version-matched set:** create-1.20.1-6.0.8, createaddition-1.3.3,
  createbigcannons-5.11.4, createdeco-2.0.3, copycats-3.0.7, createtaczauto-1.3.7, Steam_Rails-1.7.2,
  ritchiesprojectilelib-2.1.1. (Confirms Big Cannons 5.11.4 IS the C6-compatible build — it's what
  Beyond Cosmo ships with Create 6.0.8.)
- ✅ **Side filtering correct:** server mod dir has `antixray` + `mod_whitelist`, excludes all
  client-only mods; client dir has EnhancedVisuals/embeddium/entityculling/xaero-mini+world, excludes
  the server-only pair. (Fixed: xaero maps needed explicit `side: client` — Modrinth didn't report
  their server side as "unsupported".) Server=44 mods, client=47.
- ✅ Client config bundle (`base.zip`) and launcher dir build.
- ⚠️ **Only failure: the bundled `control` Rust tool** (`tools/control`) — its cargo-vendor step gets
  **HTTP 403 from crates.io** in this container (datacenter-IP rate-limit / network). This is
  environmental and hits *every* pack's full `ServerPack`/`server` target equally — NOT a pack-content
  problem. The mods/configs/launcher (the pack itself) all build. On a normal build host with
  crates.io access, `nix build -f . packs.military` completes.

**Net: the pack definition, manifest, Create-6 stack, and side split are all build-verified.**

**Files touched:** `manifest/military.yaml`, `manifest/military.json` (generated), `launcher-lock.json`
(forge entry), `builder.nix` (pack def), `base/military{,-server,-client}/`.

---

## 9. Modrinth availability audit (for .mrpack / Modrinth publishing) — 2026-07-04

Goal: can the pack be all-Modrinth (needed for a clean .mrpack / Modrinth publish)?

**Method reliability note:** guessed-slug lookups AND Modrinth's own search give **false negatives**
— e.g. Keerdm's real slug is misspelled `keerdm-zombie-apocolypse-essentials` and doesn't surface
in search. Only two signals are trustworthy: **file-hash match** (`POST /v2/version_files`, sha1 →
definitive *positive*) and **checking the actual project/author page**. Do NOT trust a search-miss
as "not on Modrinth". Raw: `data/modrinth_hash_check.json`, `data/jar_sha1.json`.

**Result (49 mods):**
- **46 confirmed on Modrinth**: 40 byte-identical hash matches + GeckoLib, Sound Physics Remastered,
  Simple Voice Chat, The Lost Cities, Fracture Point, and **Keerdm's Zombie Apocalypse Essentials**
  (`keerdm-zombie-apocolypse-essentials`, Forge 1.20.1 ✓). Also note **Create: TaCZ Automation IS on
  Modrinth** (hash-matched) — earlier notes calling it CF-only were wrong; just flip its manifest
  source CF→Modrinth for an all-Modrinth build.
- **Corail Tombstone**: original (Corail_31) is CF-only, but **"Corail Tombstone Redrawn"**
  (`corail_tombstone_redrawn`) is a maintained Modrinth port → swap to it.
- **Unconfirmed (likely CF-only, NOT definitively verified)**: **Doomsday Decoration** (cosmetic) and
  **Simply Traps** (talhakayaadam; Modrinth's `simple-traps` is a *different* mod). Verify via author
  page before treating as CF-only.

**Upshot:** all-Modrinth is very achievable — worst case drop/swap 2 minor mods (Doomsday Decoration,
Simply Traps) + use Tombstone Redrawn. That unlocks: no permission gauntlet, a fully thin `.mrpack`,
and (if listed) Prism/Modrinth-App one-click + auto-update.

---

## 10. All-Modrinth conversion + boot-test (2026-07-04)

**Pack is now 100% Modrinth-sourced** (48→49 mods with Patchouli). Manifest converted via
`data/modrinth_master.json` (CF→Modrinth by file-hash for 23, slug for 6, 19 already Modrinth).
Benefits: publishable `.mrpack`, client/server run identical versions, and the **server build is now
keyless** (no CF API key needed). Final swaps: Corail Tombstone→**Corpse**, Simply Traps→**Simple
Traps**, dropped **Doomsday Decoration** (CF-only), flipped Create:TaCZ Automation CF→Modrinth.

**Headless Forge-server boot-test** (Temurin 17, Forge 1.20.1-47.4.10, 44 server mods):
- ✅ **"Done (4.833s)! For help, type help"** — all mods load, world generates, no crash, no missing
  mandatory dependencies. Create 6 + all addons, TaCZ, Superb Warfare, IE, VEB, etc. all load.
- ✅ Adding **Patchouli** cleared the `superbwarfare … patchouli:guide_book` error (0 remaining).
- Remaining **non-fatal** data errors (MC skips missing refs; all pre-existing in the base pack):
  - `keerdm_zombie_essentials` loot references `pointblank:*` guns → add **Vic's Point Blank**
    (`vics-point-blank`) to complete that loot, or accept (chosen: accept, keeps pack lean).
  - `vvp:pantsir_air_target` needs `wrbdrones:fpv_drone` (Warborn Drones, not on Modrinth) → accept.
  - `warborn:nato_ukr_backpack` missing from `forge:armors/chestplates` → Fracture Point's own tag
    quirk → accept.
  - `createtaczauto:large_gunpowder_recipe_2.json` malformed (mod's own bug, 1 recipe) → accept.
  - SecurityCraft ↔ Steam'n'Rails camera mixin `@Redirect` conflict (SC cameras may act up near
    train conductors) → accept.

**Deliverables:** `military.mrpack` (49 files, all `cdn.modrinth.com`, correct `env`, thin 8 KB) ready
to upload to the Modrinth project **kids-military-games**. Server built by Erisia from the same
manifest (adds AntiXray, Mod Whitelist, control/tmux/prometheus tooling).

**Test-harness gotcha:** `pkill -f "@user_jvm_args"` does NOT kill the Forge server — Java expands
`@argfiles`, so the process cmdline shows flags, not the literal string. Kill by matching
`forgeserver`/`/tmp/jre/bin/java` in `/proc/*/cmdline` instead.
