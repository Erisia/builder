# Military pack — IE Excavator ore inventory (for Bedrock Ore Chunk selection)

Date: 2026-07-08
Method: extracted IE 10.2.0's shipped mineral mixes from the jar (`data/immersiveengineering/recipes/mineral/*.json` — note: in IE 1.20.1 these are **recipes of type `immersiveengineering:mineral_mix`**, NOT the old `ie_mineral_mix/` datapack path the design doc referenced). Cross-referenced every ore output tag against all 65 pack jars' `data/forge/tags/items/ores/*.json` declarations to determine which ores actually have a provider in THIS pack vs. which tags are empty (excavator would yield nothing for them).

## Ore providers actually present in the pack

| Ore | Source mod(s) | Notes |
|---|---|---|
| Copper | vanilla + IE (`ore_copper`) | |
| Gold, Iron, Coal, Redstone, Emerald | vanilla | |
| Aluminum (**Bauxite**) | Immersive Engineering | IE calls it Bauxite |
| Lead | Immersive Engineering, Superb Warfare | |
| Silver | Immersive Engineering, Superb Warfare | |
| Nickel | Immersive Engineering | |
| Uranium | Immersive Engineering | |
| Zinc | Create | (not in any IE mix, but exists) |
| Tungsten | Superb Warfare | |
| Scheelite | Superb Warfare | (tungsten ore variant; not in any IE mix) |
| Sulfur (dust) | Immersive Engineering | only non-ore forge tag that resolves |

## Ore tags referenced by IE mixes with NO provider in this pack (excavator yields nothing for these)

`tin`, `mercury`, `platinum`, `palladium` (spelled `paladium` in IE), `titanium`, `thorium`, `manganese`, `forge:dusts/phosphorus`, `forge:gems/aquamarine`. These slots in their mixes are dead — they'd just reduce effective yield.

## All 21 IE mineral mixes (weight, fail_chance, dimension) → resolved ores

Overworld mixes (what matters for the freight design):

| Mix | w | fail | Meaningful ores (provider) | Dead slots |
|---|---|---|---|---|
| auricupride | 30 | .10 | copper 75%, gold 25% | — |
| bituminous_coal | 25 | .05 | coal 80%, sulfur 20% (IE) | phosphorus |
| chalcopyrite | 20 | .05 | iron 35%, copper 35%, sulfur 30% | — |
| cassiterite | 20 | .05 | — | **tin 100% (all dead)** |
| igneous_rock | 25 | .05 | (vanilla stone blocks only) | — |
| laterite | 20 | .05 | **aluminum/bauxite 70% (IE)**, iron 20% | titanium |
| pentlandite | 25 | .05 | iron 35%, **nickel 35% (IE)**, sulfur 30% | — |
| galena | 15 | .05 | **lead 40%**, **silver 20%** (IE/SW), sulfur 40% | — |
| cinnabar | 15 | .10 | redstone 60%, sulfur 40% | mercury |
| uraninite | 10 | .15 | **uranium 70% (IE)**, lead 30% | thorium |
| beryl | 5 | .20 | emerald 30% | aquamarine |
| cooperite | 5 | .10 | **nickel 50% (IE)** | platinum, palladium |
| wolframite | 5 | .10 | **tungsten 50% (SW)**, iron 50% | manganese |
| silt | 25 | .05 | (clay/sand/gravel) | — |
| hardened_clay_pan | 15 | .05 | (terracotta/sand blocks) | — |
| ancient_seabed | 15 | .05 | (calcite/dripstone/bone) | — |
| amethyst_crevasse | 10 | .10 | (amethyst/calcite/basalt) | — |

Nether mixes: ancient_debris (netherite scrap), cooled_lava_tube, mephitic_quarzite (quartz+nether gold), nether_silt.

## Metal ores that are the real "industrial" targets for Bedrock Chunk treatment

The ores that (a) exist in the pack and (b) are metals worth an industrial refining chain:
**Iron, Copper, Gold, Aluminum(Bauxite), Lead, Silver, Nickel, Uranium, Zinc, Tungsten** (+ Coal/Redstone as bulk, + Sulfur as a byproduct).

Vanilla lapis/diamond are not in IE mixes at all (excavator can't produce them) — they'd stay hand-mined regardless.

## Why aren't lapis / diamond excavatable? (verified)

**Verified facts:**
- In our IE version (**1.20.1-10.2.0**), no mineral mix contains diamond or lapis — confirmed directly from the jar (all 21 mixes extracted and inspected above).
- This is not a bug or a missing-provider issue like the dead slots — it's a deliberate content choice. The mix list is hand-curated, and diamond/lapis were intentionally left out.
- **Confirmation that the omission was intentional-then-reconsidered:** later IE releases on the **newer branch (1.20.4+, 11.1.0)** *added* dedicated veins for both — **"Alluvial Sift"** (diamond, river biomes only) and **"Lazulitic Intrusion"** (lapis + gold). These do **not** exist in the 1.20.1 branch (verified: absent from the 1.20.1 `changelog.md`, absent from our 10.2.0 jar). So on 1.20.1 they remain non-excavatable, full stop.

**Reported but NOT verified:** a web-search summary attributed the original exclusion to "lapis is unused within IE, and diamond is used in vanilla + IE sawblades, so they were kept as hand-mined prestige resources." This rationale appeared only in a secondary summary; I could **not** confirm a verbatim developer (BluSunrize) statement in the primary GitHub issue (#330) — the fetched issue content contained only the user's question, not a dev reply. Treat the "sawblades/unused" reasoning as plausible-but-unconfirmed, not fact.

Sources: IE GitHub issue [#330](https://github.com/BluSunrize/ImmersiveEngineering/issues/330); IE [1.20.1 changelog](https://raw.githubusercontent.com/BluSunrize/ImmersiveEngineering/1.20.1/changelog.md) (no diamond/lapis veins); newer-version veins referenced on the IE [CurseForge 1.20.4-11.1.0](https://www.curseforge.com/minecraft/mc-mods/immersive-engineering) listing and [FTB Wiki: Mineral Deposits](https://ftb.fandom.com/wiki/Mineral_Deposits).

## Scoping decision (chunk set)

Bedrock Chunk items (excavator's metal outputs get replaced by these):
**Iron, Copper, Gold, Aluminum(Bauxite), Lead, Silver, Nickel, Uranium, Tungsten, Zinc** — **10 chunks**.
- 9 of these already appear in a 1.20.1 mineral mix (replace the existing output).
- **Zinc (added per user 2026-07-08)**: Create provides the ore but it's in NO IE mineral mix, so the excavator can't currently produce it. To include it, Phase D must **add a new zinc-bearing mineral mix** (real-world zinc ore mineral name = **sphalerite**) rather than just editing an existing mix. Zinc's normal Create worldgen ore can stay too, or be removed for consistency — TBD in Phase D.
- **Coal/Redstone kept as-is** per user (bulk resources, fine to hand-carry).
- Dead ore slots (tin/mercury/platinum/palladium/titanium/thorium/manganese/phosphorus/aquamarine) get cleaned out of their mixes (e.g. the 100%-tin cassiterite mix is removed or repurposed).
- This set is trivially adjustable later — it's a per-mix data edit.

## Backporting diamond + lapis veins from newer IE (user request 2026-07-08)

Newer IE (1.20.4-11.7.0) has two veins our 10.2.0 lacks: **alluvial_sift** (diamond, river biomes) and **lazulitic_intrusion** (lapis + gold). Extracted from the 11.7.0 jar. **But the recipe schema changed between 10.2.0 and 11.x** — a straight copy will fail to load. Required conversions for our 10.2.0 serializer:

| 11.x (1.20.4) | 10.2.0 (1.20.1, ours) |
|---|---|
| `"biome_predicates": [[...]]` (biome restriction) | **NOT SUPPORTED** — serializer only knows `dimensions`. Must drop it. |
| item output `{"Count":1,"id":"minecraft:sand"}` | `{"item":"minecraft:sand"}` |
| per-ore `"conditions": []` | not present — strip it |
| `{"tag":"..."}` outputs | same (compatible) |

**Verified from the jar:** `MineralMixSerializer.class` in 10.2.0 parses only `dimensions / fail_chance / ores / spoils / weight`. No `biome`/`biome_predicates` string exists in it, and none of the 21 shipped 10.2.0 mixes use biome predicates.

### CONSEQUENCE for the design's biome-locking requirement
The design doc wants high-tier ores (Uranium, Bauxite) locked to extreme biomes (deserts/badlands/deep dark). **This is not achievable via IE mineral-mix data on 10.2.0** — biome restriction is a newer-version feature. On 1.20.1 the only levers are `weight` (rarity), `fail_chance` (yield), and `dimensions` (overworld/nether/end). Updating IE to 11.x is not an option (it would move the pack off MC 1.20.1). So: **rarity is achieved via low weight + high fail_chance, not biome-locking.** Diamond's river-biome restriction is likewise lost — it becomes an overworld-wide (but low-weight) vein. Flag to user; acceptable degradation.

### Converted, ready-to-drop recipes (10.2.0 schema) — for Phase D
Place under `base/military/kubejs/data/immersiveengineering/recipes/mineral/`:

`alluvial_sift.json` (diamond; weight lowered to keep rare since biome-lock is gone — tune in Phase D):
```json
{"type":"immersiveengineering:mineral_mix","dimensions":["minecraft:overworld"],"fail_chance":0.2,"ores":[{"chance":0.2,"output":{"tag":"forge:gems/diamond"}},{"chance":0.4,"output":{"item":"minecraft:clay"}},{"chance":0.4,"output":{"item":"minecraft:sand"}}],"spoils":[{"chance":0.6,"output":{"item":"minecraft:gravel"}},{"chance":0.3,"output":{"item":"minecraft:cobblestone"}},{"chance":0.1,"output":{"item":"minecraft:coarse_dirt"}}],"weight":8}
```
`lazulitic_intrusion.json` (lapis + gold):
```json
{"type":"immersiveengineering:mineral_mix","dimensions":["minecraft:overworld"],"fail_chance":0.1,"ores":[{"chance":0.75,"output":{"tag":"forge:ores/lapis"}},{"chance":0.15,"output":{"tag":"forge:ores/gold"}},{"chance":0.1,"output":{"tag":"forge:dusts/sulfur"}}],"spoils":[{"chance":0.2,"output":{"item":"minecraft:gravel"}},{"chance":0.5,"output":{"item":"minecraft:cobblestone"}},{"chance":0.3,"output":{"item":"minecraft:cobbled_deepslate"}}],"weight":15}
```
**Verify in Phase D:** that `forge:ores/lapis` and `forge:gems/diamond` actually resolve to items in this pack (vanilla lapis/diamond should populate the forge tags, but confirm via a tag dump on the booted server).

**DECIDED (user 2026-07-08):** diamond DOES become a **Bedrock Diamond Ore Chunk** (keeps the freight rule), but with a **simple Crusher processing path** — you don't melt diamonds. So the chunk-processing model has two tracks:
- **Metal chunks** → IT Solar Melter → molten ore slurry → ingots (Phase F).
- **Gem chunks** (diamond; lapis treated the same unless user says otherwise) → **Create Crushing Wheels** (`create:crushing`, pack already has Create) → gems. Simple, one-step.

So the alluvial_sift/lazulitic mixes above should output the **Bedrock gem chunk item**, not the raw `forge:gems/diamond`/`forge:ores/lapis` tag, once the chunk items exist (Phase D wires the chunk output; the tag output shown is only IE's default before our override).

### Updated chunk set → 12 items
10 metals + **Bedrock Diamond Ore Chunk** + **Bedrock Lapis Ore Chunk** (lapis assumed same treatment as diamond; confirm). Metal chunks melt; gem chunks crush.

### Zinc mix to ADD (Phase D)
Zinc has no IE vein. Add a new `sphalerite.json` mix (sphalerite = zinc ore mineral) outputting `forge:ores/zinc` (Create provides it), so the excavator can produce the Bedrock Zinc Chunk.
