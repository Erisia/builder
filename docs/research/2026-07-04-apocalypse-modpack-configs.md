# Apocalypse / Lost-Cities modpack config research (2026-07-04)

Goal: learn how popular curated Forge 1.20.1 zombie-apocalypse modpacks configure The Lost Cities
worldgen, so our military/zombie pack (Forge 1.20.1, The Lost Cities + Lost Worlds LC, planned
`level-type=lostworlds:lost_worlds`) can adopt proven config choices instead of guessing.

Method: pulled the actual CurseForge pack zips via cfwidget + forgecdn, extracted only
`overrides/config/lostcities/**`, `lostcities-server.toml`, `lostcities-autogen-common.toml`,
`explosionoverhaul/**`, `manifest.json`, `modlist.html`; deleted the zips. Values below are copied
verbatim from those files.

## IMPORTANT architectural finding (read first)

**None of the sampled popular packs actually ship the "Lost Worlds LC" mod.** The
`dimensionsWithProfiles = ["lostcities:lostcity=biosphere", "lostworlds:abyss=biosphere_caves"]`
line that appears in almost every pack is simply **The Lost Cities' own unchanged default value**
(confirmed: the string is baked into `lostcities.jar`). It is a red herring — its presence does
*not* mean Lost Worlds is installed. `bebebea_loste` (which I first mistook for the Lost Worlds
author) turned out to be the author of *Geophilic*, a biome mod.

Instead, the popular packs put Lost Cities into the **surface overworld** by one of three mechanisms:

1. **Lost Cities world-type / `dimensionsWithProfiles` = overworld** (Beyond Cosmo, Cursed Walking):
   map `minecraft:overworld=<profile>` directly, or create the world with the Lost Cities world type
   and a global `selectedProfile`.
2. **"The Lost Cities - Autogen" (by ChaosCraft_HD)** (Lee's, Remnants, APOC, R.E.A.P leftover):
   a companion mod whose `lostcities-autogen-common.toml` has a single key `selectedProfile`, and it
   applies that profile to the generated overworld. This is the de-facto community-standard bridge.
3. **Scattered-structure mods instead of full city worldgen** (ZOMBIEMANIA leans on Berezka's
   "The Lost City" + ChaosZPack Remastered Structures, using McJty Lost Cities only lightly).

Our pack's plan (`level-type=lostworlds:lost_worlds` + a Lost Cities profile) is a *fourth, cleaner*
route to the same "ruined cities across the whole surface" outcome. Lost Worlds is a real McJty
companion that adds surface world presets; it just isn't what these specific packs chose. The profile
values below transfer directly regardless of which mechanism injects the profile.

Two community "asset" mods provide the *ruined* look (damaged/mossy/rubble block palettes) via a
custom `worldStyle`:
- **Keerdm's Zombie Apocalypse Essentials** (keerdm) -> `worldStyle = "keerdm_zombie_essentials:testworld"` (Beyond Cosmo, Cursed Walking)
- **ChaosZPack [Lost Cities]** (ChaosCraft_HD) -> `worldStyle = "testworld"` (Lee's, Remnants, APOC)
- Built-in Lost Cities only ships `standard` and `standard_everywhere` worldstyles.

## Per-pack details

### Beyond Cosmo (id 1223874, ~488k dl, file 8366561, 1.20.1)  [reference set already extracted]
- Mechanism: `selectedProfile = "customized"` in `defaultconfigs/lostcities-server.toml`, with a full
  inline `selectedCustomJson` (based on `rarecities`, `icon_rarecities.png`, "Cities are rare").
- `dimensionsWithProfiles` left at default (`lostcities:lostcity=biosphere`, `lostworlds:abyss=biosphere_caves`).
- cities: `cityChance = 0.0003`, radius 100-128, cityThreshold 0.2.
- lostcity: `ruinChance = 0.0`, `buildingChance = 0.3`, buildingMinFloors 4, buildingMaxFloors 8,
  `worldStyle = "keerdm_zombie_essentials:testworld"`, `generateSpawners = true`, `generateLoot = true`,
  `generateLighting = false`, groundLevel 71, fountainChance 0.05, parkChance 0.2.
- explosions: `explosionChance = 0.002`, `explosionsInCitiesOnly = true`, miniExplosionChance 0.03,
  explosionMinRadius 15 / MaxRadius 35.
- server toml: `avoidVillages = true`, `avoidFlattening = true`,
  `avoidStructures = [minecraft:mansion, jungle_pyramid, desert_pyramid, igloo, swamp_huts, pillager_outpost]`,
  avoidStructuresAdjacent false, avoidVillagesAdjacent false, forceSaplingGrowth true.
- Ships full `config/explosionoverhaul/` (destroy/glass/source blacklists) + TaCZ + Superb Warfare (guns).

### Cursed Walking - A Modern Zombie Apocalypse (id 682001, **8.05M dl**, file 8325950, 1.20.1)
- Flagship of the genre. Mechanism: `dimensionsWithProfiles = ["minecraft:overworld=custom2"]`
  (cities generated straight into the vanilla overworld).
- Two custom profiles shipped (both read-only copies, worldStyle `keerdm_zombie_essentials:testworld`):
  - `custom.json`: cityChance 0.001, radius 50-128, buildingMaxFloors 8.
  - `custom2.json` (the active one): `cityChance = 0.001`, radius 75-140, `ruinChance = 0.0`,
    `buildingChance = 0.3`, buildingMinFloors 0, buildingMaxFloors 8.
- explosions: `explosionChance 0.002`, `explosionsInCitiesOnly true`, miniExplosionChance 0.03.
- LC family mods: only McJty **The Lost Cities** + **Keerdm's Zombie Apocalypse Essentials** (+ binoculars).
  No Autogen, no LC²H.

### ZOMBIEMANIA (id 1290222, ~686k dl, file 8367942, 1.20.1)
- `dimensionsWithProfiles = ["lostcities:lostcity=tallbuildings", "lostworlds:abyss=biosphere_caves"]`
  — maps the *dedicated* `lostcities:lostcity` dimension to `tallbuildings`; no overworld mapping and
  no Autogen. Its main-world city feel actually comes from **Berezka's "The Lost City"** +
  **Berezka TaCZ addon** + **ChaosZPack Remastered: Structures (Watchtowers)** rather than McJty
  surface worldgen.
- `tallbuildings` profile values: cityChance 0.01, radius 50-128, `ruinChance 0.01`, buildingChance 0.3,
  buildingMinFloors 4, buildingMaxFloors 19, worldStyle `standard`,
  `explosionChance 0.006` (higher than others), miniExplosionChance 0.09, explosionsInCitiesOnly true.
- explosionoverhaul: enableFallingBlocks true, enableGlassBreaking true, enableCraterDestruction true,
  enableExplosionClustering true, maxClusterPower 100, ambient explosions OFF by default.

### Zombie R.E.A.P (id 1397008, ~67k dl, file 8361961, 1.20.1)
- LC mods: McJty **The Lost Cities** + **"Lost City R.E.A.P Tweaks for Lost Cities" (Yulari)**.
- Ships a stray `lostcities-autogen-common.toml` (`selectedProfile = "default"`) but the Autogen mod
  itself is not in the modlist; a custom `yul.json` profile is shipped and applied by the R.E.A.P tweaks.
- `yul.json`: `cityChance = 0.01`, radius 50-128, `ruinChance = 0.5`, buildingChance 0.3,
  buildingMaxFloors 8, worldStyle `standard`, generateSpawners/Loot true, generateLighting false,
  explosionChance 0.002, explosionsInCitiesOnly true. Description: "Wasteland, no water, bare land".
- explosionoverhaul tuned lighter: enableFallingBlocks false, enableGlassBreaking false,
  maxClusterPower 20 (vs ZOMBIEMANIA's 100).
- QuantifiedAPI cache files (`lostcities_city_level/raw/highway_*`) present -> cities were generated
  in the main world during dev.

### Lee's Apocalypse - Fallen Earth (id 1379959, ~32k dl, file 8360209, 1.20.1)
- Mechanism: **The Lost Cities - Autogen** with `selectedProfile = "leesapocalypse_fixed"` (also set in
  `defaultconfigs/lostcities-server.toml`).
- `leesapocalypse_fixed.json`: **`cityChance = 1e-05`** (0.00001) but **cityRadius 1500-2000** ->
  a handful of *enormous sprawling* ruined metropolises rather than many small cities.
  `ruinChance = 0.95` (heavy decay), `buildingChance = 0.15`, buildingMinFloors 0, buildingMaxFloors 31,
  worldStyle `testworld`, generateSpawners/Loot true, generateLighting false, explosionChance 0.002,
  explosionsInCitiesOnly true. Description: "Fixed terrain integration (based on aaaaaaaaz15Flat)".
- LC family: The Lost Cities + Autogen + **ChaosZPack [Lost Cities]** + **ChaosZPack Remastered Structures**
  + **ChaosZProject: Bandits** + **Big Lost City (Flashh)** + **Lost Cities Vines Fix** +
  **LC²H [Lost Cities: Multithreaded] (Admany)** + Keerdm's Essentials.
- Perf/QoL: LC²H (multithreaded chunkgen), Better World Loading, Fast Async World Save, Cherished Worlds.
- Biome side: Geophilic (bebebea_loste).

### Remnants of Earth (id 1139521, ~8k dl, file 8354536, 1.20.1)  ["Custom Generation"]
- Mechanism: **The Lost Cities - Autogen** with `selectedProfile = "aCustomStructureGen"`.
- `aCustomStructureGen.json`: identical density school to Lee's — `cityChance = 1e-05`, radius 1500-2000,
  `ruinChance = 0.95`, `buildingChance = 0.15`, buildingMaxFloors 31, worldStyle `testworld`,
  explosionChance 0.002, explosionsInCitiesOnly true. Description: "Default generation, common cities, explosions".
- LC family: The Lost Cities + Autogen + ChaosZPack [Lost Cities] + ChaosZPack Remastered + ChaosZProject Bandits
  + Big Lost City + LC²H + **Berezka's "The Lost City" + Furniture Plugin for The Lost City + Berezka TaCZ addon**.
- Biome side: **William Wythers' Overhauled Overworld** + Geophilic; also WorldEdit + Fast Async World Save.

### APOC (id 1442551, ~5k dl, file 7607420, 1.20.1)
- Mechanism: **The Lost Cities - Autogen** with `selectedProfile = "default"` (i.e. LC's unmodified default).
- `default` profile: `cityChance = 0.01`, radius 50-128, `ruinChance = 0.05`, buildingChance 0.3,
  buildingMaxFloors 8, worldStyle `standard`, generateSpawners/Loot true, generateLighting false,
  explosionChance 0.002, explosionsInCitiesOnly true. Description: "Default generation, common cities, explosions".
- LC family: The Lost Cities + Autogen + ChaosZPack [Lost Cities] + ChaosZPack Remastered + ChaosZProject Bandits + LC²H.

## Cross-pack comparison

| Pack | dl | mechanism | profile | cityChance | city radius | ruinChance | buildingChance | worldStyle | explosionChance / inCitiesOnly |
|---|---|---|---|---|---|---|---|---|---|
| Cursed Walking | 8.0M | overworld=custom2 | custom2 | 0.001 | 75-140 | 0.0 | 0.3 | keerdm_zombie_essentials:testworld | 0.002 / true |
| ZOMBIEMANIA | 686k | LC dim + Berezka structs | tallbuildings | 0.01 | 50-128 | 0.01 | 0.3 | standard | 0.006 / true |
| Beyond Cosmo | 488k | selectedProfile=customized | customized(rarecities) | 0.0003 | 100-128 | 0.0 | 0.3 | keerdm_zombie_essentials:testworld | 0.002 / true |
| Zombie R.E.A.P | 67k | REAP tweaks / yul | yul | 0.01 | 50-128 | 0.5 | 0.3 | standard | 0.002 / true |
| Lee's Apocalypse | 32k | Autogen | leesapocalypse_fixed | 1e-05 | 1500-2000 | 0.95 | 0.15 | testworld | 0.002 / true |
| Remnants of Earth | 8k | Autogen | aCustomStructureGen | 1e-05 | 1500-2000 | 0.95 | 0.15 | testworld | 0.002 / true |
| APOC | 5k | Autogen | default | 0.01 | 50-128 | 0.05 | 0.3 | standard | 0.002 / true |

(For reference, LC's `biosphere` default has cityChance 0.8; the dedicated-dimension defaults are much denser than any surface pack uses.)

## Consensus / patterns

- **Universal, never varies:** `explosionsInCitiesOnly = true`, `generateSpawners = true`,
  `generateLoot = true`, `generateLighting = false` (dark buildings = flashlight/torch gameplay).
- **explosionChance ~0.002** everywhere (ZOMBIEMANIA's 0.006 is the outlier); miniExplosionChance 0.03.
  Explosions give the bomb-crater look but are gated to cities so the wilderness stays intact.
- **buildingChance 0.3** is the standard (Lee's/Remnants drop to 0.15 to spread out their giant cities).
- **Two density schools:**
  - *Many normal cities* — cityChance ~0.01, radius 50-128 (APOC, R.E.A.P, ZOMBIEMANIA). Most common, most "explorable".
  - *Few giant sprawling megacities* — cityChance 1e-05, radius 1500-2000 (Lee's, Remnants).
  - Plus moderate/rare middle: Cursed Walking 0.001, Beyond Cosmo 0.0003.
- **ruinChance is the biggest stylistic dial:** 0.0 (clean intact cities: Cursed Walking, Beyond Cosmo)
  -> 0.05 (default) -> 0.5 (R.E.A.P) -> 0.95 (heavy decay: Lee's, Remnants). Pick to taste.
- **The apocalyptic *look* comes from a custom `worldStyle` asset mod**, not from LC settings: every
  polished pack uses either Keerdm's Zombie Essentials (`keerdm_zombie_essentials:testworld`) or
  ChaosZPack [Lost Cities] (`testworld`). Packs on plain `standard` look like clean modern cities.
- **Performance/compat mod stack that "just works":** **LC²H [Lost Cities: Multithreaded]** appears in
  every ChaosZPack-based pack; **Lost Cities Vines Fix**; **Big Lost City** for extra hand-made
  apocalyptic structures. **Fast Async World Save** + **Better World Loading** to cope with heavy chunkgen.
- **Structure de-confliction:** Beyond Cosmo (and the LC default) set `avoidVillages = true` and
  `avoidStructures = [mansion, jungle_pyramid, desert_pyramid, igloo, swamp_huts, pillager_outpost]`.
  Packs that fill the *whole* surface with city (overworld mapping / Lost Worlds preset) mostly don't
  need to fight other structures because the surface is uniformly city.
- **Guns/apocalypse feel:** TaCZ (Timeless & Classics) is near-universal; ChaosZProject Bandits and
  Berezka TaCZ structure addons add armed enemies inside the ruins.

## Recommendations for OUR pack (Forge 1.20.1, level-type=lostworlds:lost_worlds + LC profile)

1. **Density — go "many normal cities":** `cityChance ≈ 0.008-0.01`, cityMinRadius 50 / cityMaxRadius 128.
   This is what APOC/R.E.A.P/ZOMBIEMANIA use and is the most explorable/lived-in for a kids military RP
   pack. Avoid the 1e-05 / radius-2000 megacity approach unless you specifically want one giant city.
2. **ruinChance — moderate 0.1-0.3** (between clean 0.0 and Lee's 0.95): decayed enough to read as
   apocalyptic, but buildings stay enterable and lootable. Keep `buildingChance = 0.3`,
   buildingMinFloors 0-4, buildingMaxFloors 6-8 (skip tall 19/31 towers — perf heavy, ZOMBIEMANIA even
   labels tallbuildings "performance heavy").
3. **Explosions — copy the consensus exactly:** `explosionsInCitiesOnly = true`, `explosionChance = 0.002`,
   `miniExplosionChance = 0.03`, explosionMinRadius 15 / MaxRadius 35.
4. **Generation flags — copy the consensus:** `generateSpawners = true`, `generateLoot = true`,
   `generateLighting = false`.
5. **worldStyle — this is what makes it look apocalyptic.** Plain `standard` looks like a clean modern
   city. To get the ruined/mossy/rubble palette, add **ChaosZPack [Lost Cities]** (`worldStyle="testworld"`)
   and/or **Keerdm's Zombie Apocalypse Essentials** (`worldStyle="keerdm_zombie_essentials:testworld"`) and
   point the profile at it. If we can't add those mods, at minimum set `rubbleLayer=true`,
   `randomLeafBlockChance≈0.1`, `vineChance≈0.009` (as the reference profiles do) on `standard`.
6. **Compat/perf add-ons:** add **LC²H [Lost Cities: Multithreaded]** (used by every ChaosZPack pack) to
   keep city chunkgen fast; consider **Lost Cities Vines Fix** and **Big Lost City** for variety. Keep the
   LC default `avoidVillages=true` + `avoidStructures` mansion/pyramids/igloo/huts/outpost. Because we use
   the Lost Worlds surface preset the overworld is uniformly city, so conflicts with vanilla structure
   spacing are minimal — but do audit any *biome* mod (Geophilic / William Wythers) for terrain clashes;
   the popular packs pair those with LC without special tuning.
7. **Optional:** if `level-type=lostworlds:lost_worlds` proves fiddly, the community-standard fallback is
   **The Lost Cities - Autogen** (`lostcities-autogen-common.toml` -> `selectedProfile=<ours>`), which is how
   4 of the 7 packs apply their profile to the surface. Not needed if the Lost Worlds preset works.

## Sources (cfwidget metadata + forgecdn file ids)

- cfwidget: `https://api.cfwidget.com/minecraft/modpacks/<slug>`
- Cursed Walking — slug `cursed-walking-a-modern-zombie-apocalypse`, id 682001, file 8325950
- ZOMBIEMANIA — slug `zombiemania`, id 1290222, file 8367942
- Beyond Cosmo — slug `beyond-cosmo`, id 1223874, file 8366561
- Zombie R.E.A.P — slug `reap`, id 1397008, file 8361961
- Lee's Apocalypse — slug `lees-apocalypse`, id 1379959, file 8360209
- Remnants of Earth — slug `apocalypse-remnants-of-earth`, id 1139521, file 8354536
- APOC — slug `apoc-a-modern-zombie-apocalypse-experience`, id 1442551, file 7607420
- forgecdn download pattern: `https://mediafilez.forgecdn.net/files/<first4>/<int(last3)>/<urlencoded name>`
- Extracted configs retained under scratchpad `packs/<pack>/overrides/config/lostcities/` for this session.
