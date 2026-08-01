# What mods get paired with Immersive Engineering + Create

Date: 2026-07-07
Method: **Direct API queries**, not web search — Modrinth API (`/v2/search`, `/v2/project/{id}/dependencies`) and CurseForge API (`/v1/mods/search`, `/v1/mods/{id}/files`, manifest.json extraction, `/v1/mods` batch lookup). Raw JSON responses cached in scratchpad during the session for reuse.

## Methodology

1. **Modrinth**: Pulled the top ~700 modpacks (by downloads, by follows, plus text-search candidates for "immersive engineering" / "create immersive" / "gregtech create") — deduped to ~700 unique modpack projects. For each, called `GET /v2/project/{id}/dependencies`, which returns the full resolved mod list a modpack declares as dependencies. Intersected each pack's dependency project-ID set against Immersive Engineering (`tIm2nV03`) and Create (`LNytGWDc`).
   - Result: **21 real modpacks** on Modrinth depend on both mods (out of ~700 checked — this combo is a small niche, not a dominant pattern).
2. **CurseForge**: Searched `classId=4471` (modpacks) for `immersive engineering`, filtered results whose summary also mentions "create" → 29 candidate packs. For the top 6 by download count, downloaded the actual pack `.zip`, extracted `manifest.json` (the authoritative mod list CurseForge doesn't expose via search API), and batch-resolved all 776 unique mod IDs to names via `POST /v1/mods`.

Raw data (candidate lists, dependency dumps, resolved manifests) lives in this session's scratchpad; the aggregated results are below and in `data/` tables inline in this file for reuse.

## Modrinth: packs depending on both IE + Create (ranked by downloads)

- Technical Electrical (109965 dl, 368 mods) — https://modrinth.com/modpack/technical-electrical
- Seven Zero Meow Team's Zombie apocalypse (23919 dl, 197 mods) — https://modrinth.com/modpack/seven-zero-meow-teams-zombie-apocalypse
- Keralis Create Pack (23313 dl, 182 mods) — https://modrinth.com/modpack/keralis-create-pack
- Create Ultimate Selection 2 - Create Aeronautics (22064 dl, 279 mods) — https://modrinth.com/modpack/create-ultimate-selection-2
- Industrium (2664 dl, 500 mods) — https://modrinth.com/modpack/industriummc
- IE Aether & Create (2247 dl, 105 mods) — https://modrinth.com/modpack/aetherial-forge-tales-of-ember-and-steel
- Planes Trains and Cobblemon (1959 dl, 428 mods) — https://modrinth.com/modpack/planes-trains-cobblemon
- Create: Vanilla+ & Technology (1805 dl, 320 mods) — https://modrinth.com/modpack/create-vanilla+-technology
- RuneForge (1555 dl, 261 mods) — https://modrinth.com/modpack/runeforge
- Nenuu's Zombie Pack (888 dl, 156 mods) — https://modrinth.com/modpack/nenuus-zombie-pack
- Create Love and War (549 dl, 109 mods) — https://modrinth.com/modpack/create-love-and-war
- Immersive TFC (Frozen) (489 dl, 76 mods) — https://modrinth.com/modpack/immersive-tfc
- Project Vulkan (370 dl, 183 mods) — https://modrinth.com/modpack/project_vulkan
- TFC Terra Incognita (266 dl, 184 mods) — https://modrinth.com/modpack/tfc-terra-incognita
- a sunny creative day. (197 dl, 87 mods) — https://modrinth.com/modpack/a-sunny-creative-day.
- immersive creation (182 dl, 149 mods) — https://modrinth.com/modpack/immersive-creation
- Derfic's techno modpack (172 dl, 39 mods) — https://modrinth.com/modpack/derfics-techno-modpack
- Tellus: Real Earth Survival (94 dl, 98 mods) — https://modrinth.com/modpack/tellus-real-earth-survival
- FWG: Megapack (36 dl, 277 mods) — https://modrinth.com/modpack/fwgmp
- Vanilla Twist (24 dl, 246 mods) — https://modrinth.com/modpack/vanilla-twist-+
- Modded Chaos by did 5 (17 dl, 63 mods) — https://modrinth.com/modpack/modded-chaos-by-did-5

### Deep/technical-progression mod co-occurrence (21 packs)

| Mod | Packs | % |
|---|---|---|
| Mekanism (+Generators/Tools/Additions) | 8 | 38% |
| Applied Energistics 2 (+addons) | 6 | 29% |
| Ad Astra (space progression) | 6 | 29% |
| Tinkers' Construct | 4 | 19% |
| Mystical Agriculture | 3 | 14% |
| Refined Storage | 3 | 14% |
| Botania | 3 | 14% |
| Thermal series (Expansion/Foundation/Dynamics/etc.) | 2 | 10% |
| Modern Industrialization | 2 | 10% |
| PneumaticCraft: Repressurized | 2 | 10% |
| Ars Nouveau | 2 | 10% |
| Ender IO | 2 | 10% |
| Industrial Foregoing | 1 | 5% |

(Full mod list per pack is in the scratchpad `ie_create_packs.json` dump if needed later.)

## CurseForge: top packs by download count mentioning both mods

From `classId=4471` search filtered on "immersive engineering" + summary containing "create":

- TerraFirma: Rebirth — 117,841 dl
- Terrafirma Engineering (KR) — 35,399 dl
- WT Endless Sky Adventures - Skyblock Edition — 33,706 dl
- MineColonies - Cobblemon Conquest — 25,886 dl
- Create + Ribbits and MORE — 4,368 dl
- Create Evo - From Aeronautics to Space — 3,270 dl
- Tech and Trains with Guns — 2,969 dl
- Modularity: Industrial Progress — 2,053 dl
- Gundustry (expert progression pack) — 1,298 dl
- Re-Create — 1,069 dl

For the top 6 of these, actual `manifest.json` was extracted from the pack zip (authoritative mod list, not just search-summary text) and all mod IDs resolved to names.

### Deep/technical mod co-occurrence (6 CF packs, real manifests)

| Mod | Packs | Note |
|---|---|---|
| Mekanism (+Generators/Tools) | 5/6 | dominant, same as Modrinth data |
| Just Enough Immersive Multiblocks | 5/6 | IE-specific JEI addon (expected, not a distinct "pairing") |
| FTB Quests/Library/Teams | 5/6 | questline-driven progression scaffolding is the norm |
| Refined Storage | 3/6 | alt/competing storage system to AE2 |
| Flux Networks | 3/6 | wireless power distribution, complements IE cabling |
| Pipez | 3/6 | universal item/fluid/energy pipe, complements Create's limited logistics |
| Applied Energistics 2 | 2/6 | |
| KubeJS + KubeJS Create | 3/6 | custom recipe/progression scripting glue |
| CraftTweaker | 3/6 | same purpose |

## Synthesis: what actually pairs with IE + Create for *deep* progression

Across both datasets (27 real packs total), a consistent pattern emerges — packs don't just throw IE and Create together, they build a **storage/logistics layer + a power-generation layer + a progression/quest layer** on top:

1. **Mekanism** is the single most common third pillar (48% combined) — its own multiblock/tiered progression (basic → advanced → elite → ultimate) meshes with IE's tiered generators and Create's kinetic power, and Mekanism's energy (Joules) bridges via addons to both.
2. **AE2 or Refined Storage** (not usually both) for automated storage — necessary once IE+Create production chains outgrow chests. AE2 appears more with "expert/progression" packs; Refined Storage more with logistics-flexible ones.
3. **Pipez / Flux Networks** — IE and Create both have clunky/limited native logistics (IE has almost none, Create has belts/tubes but no long-distance or wireless), so packs add a universal pipe or wireless power mod to bridge the gap.
4. **Progression scaffolding**: FTB Quests (CurseForge-side) or KubeJS/CraftTweaker custom recipes (both platforms) — the "deep technical" packs almost never rely on vanilla progression; they gate IE/Create/Mekanism tiers behind a questline or custom recipe chain.
5. **Secondary/thematic layers** vary by pack identity: Ad Astra (space, common in "expert progression" packs), Tinkers' Construct (tool/weapon crafting depth), Mystical Agriculture/Botania/Ars Nouveau (when packs want a parallel magic progression track, not purely tech).

Notably **absent or rare**: GregTech (0 hits in either dataset — GT:NH-style packs are a separate ecosystem that doesn't typically also run Create), Industrial Foregoing (only 1 hit — largely superseded by Mekanism's own machines).

## Relevance to e34_5 (NeoForge 1.21.1)

Checked `manifest/e34_5.yaml` directly. It already has:
- Immersive Engineering ✅
- Mekanism (+ Tools) ✅
- Applied Energistics 2 (+ WTLib, MEGA Things, AE2CT, JEI integration) ✅
- PneumaticCraft: Repressurized ✅
- Flux Networks ✅
- FTB Quests ✅

...but **no Create**. This is notable: e34_5's existing stack (IE + Mekanism + AE2 + PneumaticCraft + Flux Networks + FTB Quests) is almost exactly the "deep progression" combo pattern found above — it's just missing the Create half of the IE+Create pairing this research was about. Given the pack already has every complementary mod that real packs pair with this combo, adding Create would slot in naturally rather than requiring a new logistics/storage layer.

Also absent and worth considering if the goal is closer to the surveyed packs: **Pipez** (universal pipe, shows up in 3/6 top CF packs alongside Flux Networks — the two are typically used together, one for power, one for items/fluids) and **Refined Storage** (only if an AE2 alternative/competitor is wanted, not both).

Not recommended based on this data: GregTech-family mods (no real-world precedent pairing with this exact combo) and Industrial Foregoing (largely redundant with Mekanism's machines).

## Addendum 2026-07-07: mods (not modpacks) that depend on Immersive Engineering

Follow-up question: what content addons exist that extend IE itself, for adding "more Immersive content" rather than a different tech pillar.

**Method**: on Modrinth, searched `project_type:mod` for IE-related query terms across NeoForge 1.21.1, then verified each candidate's own `/dependencies` actually lists IE (`tIm2nV03`) — text mentions alone are not proof of a real dependency, several hits were compat-tweaks that only mention IE in prose. On CurseForge, searched `classId=6` for "immersive engineering" (95 results across 2 pages), then for each candidate pulled its file list and checked the file's `relations.requiredDependencies` for IE's mod ID (`231951`) — this confirms an actual declared dependency, not just a name match — and split results by whether they support NeoForge + 1.21.1.

### Confirmed real addons — Modrinth (17, dependency-verified)

- Just Enough Immersive Multiblocks (295,130 dl) — JEI support for IE multiblocks — https://modrinth.com/mod/jei-multiblocks
- Immersive Railroading (117,793 dl) — life-size rail transport, optional IE integration — https://modrinth.com/mod/immersive-railroading
- TFC + IE Crossover (84,987 dl) — https://modrinth.com/mod/tfc-ie-crossover
- Immersive Energistics (79,867 dl) — ME-capable wires for IE — https://modrinth.com/mod/immersive-energistics
- More Immersive Wires (63,181 dl) — extra wire types for other mods' cables — https://modrinth.com/mod/more-immersive-wires
- Immersive Petroleum (56,454 dl) — oil/petroleum processing chain for IE — https://modrinth.com/mod/immersivepetroleum
- Engineered Compatibility (41,370 dl) — cross-mod compat datapack — https://modrinth.com/mod/engineered-compatibility
- Engineered Schematics (39,054 dl) — easier multiblock creation UX — https://modrinth.com/mod/engineered-schematics
- Immersive Posts (34,733 dl) — more wire-post block variants — https://modrinth.com/mod/immersiveposts
- Engineers Delight (27,621 dl) — Farmer's Delight integration — https://modrinth.com/mod/engineers-delight
- AU: Immersive Engineering (19,473 dl) — Almost Unified support — https://modrinth.com/mod/almost-unified-ie
- Mystical Garden Cloches (18,073 dl) — automate Mystical Agriculture via IE cloche — https://modrinth.com/mod/mystical-garden-cloches
- Tomtaru's Cobblemon & IE Tweaks (6,669 dl) — https://modrinth.com/mod/tomtarus-cobblemon-immersive-engineering-tweaks
- Immersive Aircraft x IE (2,994 dl) — https://modrinth.com/mod/immersive-aircraft-x-immersive-engineering
- Immersive Cooking & Farming (1,872 dl) — https://modrinth.com/mod/immersive-cooking-adoon
- Tomtaru's Stellaris & IE Tweaks (852 dl) — https://modrinth.com/mod/tomtarus-stellaris-immersive-engineering-tweaks
- Immersive Bonsai (185 dl) — https://modrinth.com/mod/immersive-bonsai

### Confirmed real addons — CurseForge, support NeoForge 1.21.1 (dependency-verified via file manifest)

- Immersive Petroleum (57.0M dl overall) — https://www.curseforge.com/minecraft/mc-mods/immersive-petroleum
- Just Enough Immersive Multiblocks (17.6M dl) — https://www.curseforge.com/minecraft/mc-mods/just-enough-immersive-multiblocks
- Immersive Energistics (8.1M dl) — https://www.curseforge.com/minecraft/mc-mods/immersive-energistics
- More Immersive Wires (6.4M dl) — https://www.curseforge.com/minecraft/mc-mods/more-immersive-wires
- Engineers Delight (4.0M dl) — https://www.curseforge.com/minecraft/mc-mods/engineers-delight
- AU: Immersive Engineering (2.0M dl) — https://www.curseforge.com/minecraft/mc-mods/almost-unified-ie
- Engineered Compatibility (1.3M dl) — https://www.curseforge.com/minecraft/mc-mods/engineered-compatibility
- Tomtaru's Cobblemon & IE Tweaks (339,580 dl)
- Quark Engineering (95,280 dl) — Quark recipe compat — https://www.curseforge.com/minecraft/mc-mods/quark-engineering
- Immersive Aircraft x IE (29,559 dl)
- Mystical Engineering (28,569 dl) — Mystical Agriculture ↔ IE Garden Cloche — https://www.curseforge.com/minecraft/mc-mods/mystical-engineering
- Immersive Cooking & Farming (9,413 dl)
- More Railgun Projectiles (956 dl) — extra railgun ammo types — https://www.curseforge.com/minecraft/mc-mods/more-railgun-projectiles
- Alternating Flux NeoForge (753 dl) — long-distance low-loss power wire tier — https://www.curseforge.com/minecraft/mc-mods/alternating-flux-neoforge
- Create Diesel Generator (unofficial fork) (748 dl) — bridges Create diesel gens with Immersive Petroleum — https://www.curseforge.com/minecraft/mc-mods/create-diesel-generator-unofficial-fork-for
- Immersive Ascension (655 dl) — decorative slabs/stairs — https://www.curseforge.com/minecraft/mc-mods/immersive-ascension
- Immersive Mechanical (302 dl) — a few extra multiblocks — https://www.curseforge.com/minecraft/mc-mods/immersive-mechanical
- Immersive Trims (269 dl) — armor trims from IE metals — https://www.curseforge.com/minecraft/mc-mods/immersive-trims
- Immersive Deposit Scanner (66 dl) — JourneyMap waypoints for IE/Petroleum deposits — https://www.curseforge.com/minecraft/mc-mods/immersive-deposit-scanner

### Notable addons that exist but are NOT ported to 1.21.1/NeoForge (checked actual file game-version tags, so don't recommend or expect them)

- Immersive Intelligence (huge content addon: electronics/logistics/warfare) — stuck on 1.12.2 Forge
- Immersive Technology (power-gen focused) — stuck on 1.20.1 Forge at newest
- Industrial Wires, Immersive Energy, Alternating Flux (original), Engineer's Doors — all stuck on 1.12.2 Forge
- KubeJS Immersive Engineering — stuck on 1.19.2 Forge

### Cross-checked against `manifest/e34_5.yaml`

Already present: More Immersive Wires, AU: Immersive Engineering (Almost Unified), Engineered Compatibility.

Not present, and confirmed available for NeoForge 1.21.1 — candidates worth evaluating, roughly by how much *new content* (vs. pure compat glue) they add:
- **Immersive Petroleum** — full oil/petroleum processing multiblock chain, the biggest legitimate content addon still maintained for current versions.
- **Just Enough Immersive Multiblocks** — pure QoL (JEI multiblock previews), near-zero downside to adding.
- **Immersive Energistics** — ME-capable wires, useful since the pack already runs AE2.
- **Mystical Engineering / Mystical Garden Cloches** — only relevant if Mystical Agriculture is (or will be) in the pack; otherwise skip.
- **Engineered Schematics** — multiblock-building UX improvement.
- **Alternating Flux NeoForge** — long-distance power wire tier, complements the pack's existing Flux Networks.
- Everything else in the CF/Modrinth "confirmed" lists below ~1M downloads is a small tweak/compat mod — check individually against what's already installed before adding.

**Correction**: the above e34_5 cross-check was against the wrong pack for this session's actual working branch (`add-military-rp-pack`). e34_5 is NeoForge 1.21.1; the military RP pack (`manifest/military.yaml`) is **Forge 1.20.1** and is the pack actually being worked on. See the addendum below for the corrected, version-appropriate analysis.

## Addendum 2026-07-07 (2): re-filtered for the military RP pack — Forge 1.20.1

`manifest/military.yaml` already includes: Create (+ Create Big Cannons, Create Deco, Create Copycats, Create Steam 'n' Rails, Create TACZ Automation), Immersive Engineering, Immersive Weathering, Pipez, and `veb-aws` (a Soviet-era vehicle-parts addon for the separate "Immersive Vehicles"/MTS mod family — not related to Immersive Engineering despite the name).

Re-ran the same dependency-verified query (cached CF file data + fresh Modrinth search) filtered for `1.20.1` + `Forge` instead of `1.21.1` + `NeoForge`. Many more real IE content addons exist on 1.20.1 that never got ported forward:

### Confirmed IE-dependent addons, Forge 1.20.1 (CurseForge, 23 results) + Modrinth (18 results, deduped)

- **Immersive Petroleum** (57.0M dl) — oil/petroleum processing chain — https://www.curseforge.com/minecraft/mc-mods/immersive-petroleum
- **Just Enough Immersive Multiblocks** (17.6M dl) — JEI multiblock previews, pure QoL
- **Immersive Fixes** (2.7M dl CF / 270,568 dl Modrinth) — backports critical IE bugfixes to 1.20.1 — worth having for stability alone — https://modrinth.com/mod/immersive-fixes
- **Immersive Technology** (5.5M dl) — energy-generation-focused content addon, last ported to 1.20.1 — https://www.curseforge.com/minecraft/mc-mods/immersive-technology
- **Immersive Industry** (982K dl) — more processing machines/multiblocks
- **Immersive Geology** (238K dl CF / 22,295 Modrinth) — ore-processing multiblocks, new ore types — https://modrinth.com/mod/immersive-geology
- **Compressed Engineering** (123K dl, CF only) — tweaks/fixes/additions — https://www.curseforge.com/minecraft/mc-mods/compressed-engineering
- **Engineered Schematics** (39K dl) — easier multiblock-building UX
- **Create Immersive Unnecessary Shaft** (6,483 dl) — bridges Create's rotational Stress Units directly into IE's rotational machines — https://modrinth.com/mod/create-immersive-unnecessary-shaft — thematically the single most relevant find, since the pack runs both Create and IE as separate power systems today.
- **CreosotePatch** (1,613 dl) — alternate Create fluid-filling recipe using IE creosote — small but free cross-mod flavor
- **Create: Immersive Armorer Integration** (4,234 dl) — only relevant if "Immersive Armorer" (a separate armor mod) is also added; not currently in the pack, skip unless wanted.
- Long tail of low-download compat/tweak mods (Quark Engineering, Immersive Cooking & Farming, Immersive Trims, Umbra Poor Ores IE Addon, etc.) — niche, evaluate individually.

### Notable: still not available even on 1.20.1

Immersive Intelligence, Industrial Wires, Immersive Energy, Engineer's Doors, original Alternating Flux — all stuck on 1.12.2 and never updated, confirmed via checked game-version tags on their files.

### Recommendation for military.yaml specifically

Given the pack already runs both Create and IE as parallel systems:
1. **Create Immersive Unnecessary Shaft** — directly ties the two power systems together, fits the "deep technical progression" goal better than any standalone content addon.
2. **Immersive Fixes** — bugfix backport, low-risk, recommended for any 1.20.1 IE install.
3. **Immersive Petroleum** — biggest legitimate content expansion, adds a real processing chain (oil → refining → fuel), fits a military/industrial theme well.
4. **Immersive Technology** or **Immersive Industry** — pick one, not both (overlapping "more machines" content); Technology leans power-gen, Industry leans general processing.
5. Just Enough Immersive Multiblocks — free QoL, no reason not to add.
