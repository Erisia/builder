# Modrinth API research — QoL + Refined Storage (Forge 1.20.1)

Date: 2026-07-05
Target loader/version: **Forge 1.20.1**, sourced 100% from Modrinth.

Query pattern used:
- Project: `https://api.modrinth.com/v2/project/{slug}`
- Versions: `https://api.modrinth.com/v2/project/{slug}/version?loaders=["forge"]&game_versions=["1.20.1"]`

For each mod the "version id" (the `id` field of the version object) is the **file_id** to paste into a manifest. All version ids below were confirmed to belong to a version object whose `loaders` includes `forge` and whose `game_versions` includes `1.20.1`.

---

## Candidate QoL mods

### AppleSkin
- project id: `EsAfCjCV` — slug: `appleskin`
- Forge 1.20.1: **YES**
- latest version id (file_id): `XdXDExVF` — version_number: `2.5.1+mc1.20.1` — file: `appleskin-forge-mc1.20.1-2.5.1.jar`
- dependencies: none
- internal modid: `appleskin`
- client_side: `optional` / server_side: `optional` (works on both; commonly installed both sides so tooltips sync)
- Source: https://api.modrinth.com/v2/project/appleskin , https://api.modrinth.com/v2/project/appleskin/version?loaders=["forge"]&game_versions=["1.20.1"]

### Mouse Tweaks
- project id: `aC3cM3Vq` — slug: `mouse-tweaks`
- Forge 1.20.1: **YES**
- latest version id (file_id): `7JVXOe3K` — version_number: `1.20.1-2.25.1-forge` — file: `MouseTweaks-forge-mc1.20.1-2.25.1.jar`
- dependencies: none
- internal modid: `mousetweaks`
- client_side: `required` / server_side: `unsupported` (CLIENT ONLY)
- Source: https://api.modrinth.com/v2/project/mouse-tweaks , .../version?loaders=["forge"]&game_versions=["1.20.1"]

### Controlling
- project id: `xv94TkTM` — slug: `controlling`
- Forge 1.20.1: **YES**
- latest version id (file_id): `LH6Bi6Am` — version_number: `12.0.2` — file: `Controlling-forge-1.20.1-12.0.2.jar`
- dependencies: **REQUIRED** → Searchables (project id `fuuu3xnx`, slug `searchables`) — on Modrinth for Forge 1.20.1: YES
- internal modid: `controlling`
- client_side: `required` / server_side: `unsupported` (CLIENT ONLY)
- Source: https://api.modrinth.com/v2/project/controlling , .../version?...

### Just Zoom
- project id: `iAiqcykM` — slug: `just-zoom`
- Forge 1.20.1: **YES**
- latest version id (file_id): `HrSzoCLd` — version_number: `2.1.1-1.20.1-forge` — file: `justzoom_forge_2.1.1_MC_1.20.1.jar`
- dependencies: **REQUIRED** → Konkrete (project id `J81TRJWm`, slug `konkrete`) — on Modrinth for Forge 1.20.1: YES
- internal modid: `justzoom`
- client_side: `required` / server_side: `unsupported` (CLIENT ONLY)
- Source: https://api.modrinth.com/v2/project/just-zoom , .../version?...

### Chat Heads
- project id: `Wb5oqrBJ` — slug: `chat-heads`
- Forge 1.20.1: **YES**
- latest version id (file_id): `raixMXoT` — version_number: `0.15.2` — file: `chat_heads-0.15.2-forge-1.20.jar` (game_versions 1.20, 1.20.1)
- dependencies: OPTIONAL only → Cloth Config (`9s6osm5g`). No required deps.
- internal modid: `chatheads`
- client_side: `required` / server_side: `unsupported` (CLIENT ONLY)
- Source: https://api.modrinth.com/v2/project/chat-heads , .../version?...

### BetterF3
- project id: `8shC1gFX` — slug: `betterf3`
- Forge 1.20.1: **YES**
- latest version id (file_id): `xo6HmgWj` — version_number: `7.0.2` — file: `BetterF3-7.0.2-Forge-1.20.1.jar` (game_versions 1.20, 1.20.1)
- dependencies: **REQUIRED** → Cloth Config API (project id `9s6osm5g`, slug `cloth-config`) — ALREADY IN PACK per context
- internal modid: `betterf3`
- client_side: `required` / server_side: `unsupported` (CLIENT ONLY)
- Source: https://api.modrinth.com/v2/project/betterf3 , .../version?...

### Better Advancements
- project id: `Q2OqKxDG` — slug: `better-advancements`
- Forge 1.20.1: **YES**
- latest version id (file_id): `EKwDaD23` — version_number: `0.4.2.60` — file: `BetterAdvancements-Forge-1.20.1-0.4.2.60.jar`
- dependencies: none
- internal modid: `betteradvancements`
- client_side: `required` / server_side: `unsupported` (listed CLIENT ONLY on Modrinth; it renders the advancements screen)
- Source: https://api.modrinth.com/v2/project/better-advancements , .../version?...

### Legendary Tooltips
- project id: `atHH8NyV` — slug: `legendary-tooltips`
- Forge 1.20.1: **YES**
- latest version id (file_id): `JhxD2e6J` — version_number: `1.4.5` — file: `LegendaryTooltips-1.20.1-forge-1.4.5.jar` (game_versions 1.20, 1.20.1)
- dependencies:
  - **REQUIRED** → Iceberg (project id `5faXoLqX`, slug `iceberg`) — Modrinth Forge 1.20.1: YES
  - **REQUIRED** → Prism (project id `1OE8wbN0`, slug `prism-lib`) — Modrinth Forge 1.20.1: YES
  - OPTIONAL → project `CYSUVOdj` (ignore)
- internal modid: `legendarytooltips`
- client_side: `required` / server_side: `unsupported` (CLIENT ONLY)
- Source: https://api.modrinth.com/v2/project/legendary-tooltips , .../version?...

### Jade Addons
- project id: `xuDOzCLy` — slug: `jade-addons-forge` (note: the Forge project slug is `jade-addons-forge`, not `jade-addons`)
- Forge 1.20.1: **YES**
- latest version id (file_id): `l9IrZYLt` — version_number: `5.5.1+forge` — file: `JadeAddons-1.20.1-Forge-5.5.1.jar` (loaders forge+neoforge, game_versions 1.20, 1.20.1)
- dependencies: **REQUIRED** → Jade (project id `nvQzSEkH`, slug `jade`) — ALREADY IN PACK per context
- internal modid: `jadeaddons`
- client_side: `optional` / server_side: `optional`
- Source: https://api.modrinth.com/v2/project/jade-addons-forge , .../version?...

---

## Storage feature mod

### Refined Storage
- project id: `KDvYkUg3` — slug: `refined-storage`
- Forge 1.20.1: **YES**
- latest version id (file_id): `ZITLFjjf` — version_number: `1.12.4` — file: `refinedstorage-1.12.4.jar` (loaders forge+neoforge, game_versions 1.20.1)
- dependencies: **NONE required** (empty dependencies array for the 1.20.1 Forge build). Refined Storage 1.12.x for 1.20.1 is self-contained; no Cloth/library dep on Modrinth.
- internal modid: `refinedstorage`
- client_side: `required` / server_side: `required` (MUST be on BOTH sides)
- Source: https://api.modrinth.com/v2/project/refined-storage , .../version?...

---

## Required dependency library mods (resolved)

| dep | project id | slug | latest Forge 1.20.1 version id | version_number | file | client/server | modid |
|-----|-----------|------|-------------------------------|----------------|------|---------------|-------|
| Searchables (Controlling) | `fuuu3xnx` | `searchables` | `PM9yAW1G` | `1.0.3` | Searchables-forge-1.20.1-1.0.3.jar | required/unsupported | `searchables` |
| Konkrete (Just Zoom) | `J81TRJWm` | `konkrete` | `skYziQQL` | `1.8.0-1.20-1.20.1-forge` | konkrete_forge_1.8.0_MC_1.20-1.20.1.jar | optional/optional | `konkrete` |
| Cloth Config (BetterF3, opt. Chat Heads) | `9s6osm5g` | `cloth-config` | already in pack | — | — | optional/optional | `cloth_config` |
| Iceberg (Legendary Tooltips) | `5faXoLqX` | `iceberg` | `BQ8rJPXV` | `1.1.25` | Iceberg-1.20.1-forge-1.1.25.jar | required/required | `iceberg` |
| Prism (Legendary Tooltips) | `1OE8wbN0` | `prism-lib` | `FFyss87M` | `1.0.5` | Prism-1.20.1-forge-1.0.5.jar | required/unsupported | `prism` |
| Jade (Jade Addons) | `nvQzSEkH` | `jade` | already in pack | — | — | — | `jade` |

Source URLs for deps:
- https://api.modrinth.com/v2/project/searchables/version?loaders=["forge"]&game_versions=["1.20.1"]
- https://api.modrinth.com/v2/project/konkrete/version?loaders=["forge"]&game_versions=["1.20.1"]
- https://api.modrinth.com/v2/project/iceberg/version?loaders=["forge"]&game_versions=["1.20.1"]
- https://api.modrinth.com/v2/project/prism-lib/version?loaders=["forge"]&game_versions=["1.20.1"]

---

## Conflict / duplicate notes vs existing pack
Existing pack: JEI, Jade, Embeddium, FerriteCore, ModernFix, EntityCulling, Clumps, Xaero's minimap/worldmap, Curios, Cloth Config, Sophisticated Backpacks/Core, Iron Chests.

- **Cloth Config** — BetterF3 requires it; already present. Do NOT re-add (dedupe).
- **Jade** — Jade Addons requires it; already present. Do NOT re-add.
- No functional conflicts detected among the candidates. Just Zoom vs Xaero's: Xaero minimap has its own zoom for the map, but Just Zoom is a world/FOV spyglass-style zoom — not a duplicate.
- Iceberg, Prism, Searchables, Konkrete are NEW libraries that must be added to satisfy required deps.

## Notes / caveats
- All version ids above were verified against a version object whose `loaders` array contains `forge` and `game_versions` contains `1.20.1`.
- Internal modids for AppleSkin, Mouse Tweaks, Controlling, Just Zoom, BetterF3, Refined Storage, Searchables, Konkrete, Iceberg are confirmed by general knowledge/filenames. `chatheads`, `betteradvancements`, `legendarytooltips`, `jadeaddons`, `prism` are high-confidence from general knowledge but were not read out of the jar's mods.toml — flag if exactness matters.
- "latest" = first element returned by the filtered version endpoint (Modrinth returns newest first).
