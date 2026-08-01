# Modpack Architecture: Heavy Industry & Freight Logistics

Status: design intent from user, 2026-07-07. Applies to the military RP pack (`manifest/military.yaml`, Forge 1.20.1). General idea is authoritative; implementation details below are hints/starting points, not fixed specs — the actual implementation plan may deviate where the hinted approach doesn't fit the real mod APIs/configs.

## 1. Core Pillars & Mechanics

### A. The Logistics Bottleneck (The Heavy Freight Rule)

Concept: Raw resources cannot be trivially bypassed or carried by hand. Long-distance freight is a strict gameplay requirement.

Implementation: Immersive Engineering (IE) Excavators are modified to mine an un-carriable item: Bedrock Ore Chunks (e.g., Bedrock Iron Ore Chunk, Bedrock Bauxite Chunk).

Player Constraint: If a player places a Bedrock Ore Chunk into their personal inventory, they are instantly given Slowness V and Blindness/Fatigue, or the item is immediately dropped at their feet with a system message: "Cargo is too heavy to carry. Use a freight train!"

The Waystone Solution: Player-craftable Waystones are entirely disabled, or configured to completely refuse teleportation if the player is carrying any high-tier industrial raw material, bypassing inventory-stuffing exploits.

### B. Geographical Scale & Scanning

Concept: Resource veins are rare structural milestones rather than ubiquitous world-gen features.

World-Gen Configuration: In the custom datapack (`data/immersiveengineering/ie_mineral_mix/`), the `fail_chance` of all base IE mineral mixes is increased to a severe range (0.85 to 0.90). High-tier ores (e.g., Uranium, Bauxite) are strictly locked to distant, extreme biomes (Deserts, Badlands, Deep Dark).

The Scanning Loop: Players utilize mid-game scanning gear (such as a modified Scannable ping or vehicle-mounted radar) to locate a "Bedrock Anomaly" within a 500–1,000 block search radius. Once within the region, they deploy the IE Core Sample Drill to physically verify and pinpoint the chunk containing the vein.

### C. Economic Balance (Track Yield vs. Distance)

Concept: Laying 2,000 blocks of track should feel like a major project, not an impossible iron-grinding chore.

Recipe Rebalance: Lower the raw iron cost of rail networks by gating tracks behind Immersive Engineering Infrastructure instead of pure vanilla resources.

KubeJS Recipe Output:
```
1x Steel Sheet + 6x Treated Wood Slabs ──► 32x Create Train Tracks
```
This maintains a clear technological requirement (Coke Oven + Steel production) while scaling the yield to match long-distance exploration needs.

## 2. Technological Progression Flowchart

To unlock full automation and infinite resources, the player must advance through three tightly integrated mod packages:

### Phase 1: Pure Mechanics & Rail Assembly (Create)

Objective: Establish infrastructure and survey territory.

Loop: Build early kinetic setups ──► Mass-produce Create Train Tracks using IE Treated Wood and Steel ──► Scan the horizon for rare remote anomalies ──► Lay physical tracks out to the destination mining site.

### Phase 2: Remote Mining Complexes (Immersive Engineering)

Objective: Claim the vein and automate extraction.

Loop: Assemble a remote extraction site centered around the IE Excavator ──► Power it locally (via biodiesel or localized setups) ──► Excavator mines Bedrock Ore Chunks ──► Chutes automatically dump the un-carriable blocks directly into Create Cargo Vaults on an automated freight train.

### Phase 3: Centralized Thermal Refining (Immersive Technology)

Objective: Bring the heavy cargo home and process it at maximum speed.

Loop: The Create train returns to the central base and unloads cargo ──► Bedrock Ore Chunks are fed into an IT Solar Melter or Modular Boiler system ──► Requires Heated Salt Slurry at 400°C+ (driven by a 24-mirror Solar Tower grid) to liquefy the rock into Molten Ore Slurry.

Refinement: The slurry is pumped into chemical washing lines fed with pure Distilled Water from an IT Distiller.

Logistics Handling: Due to the severe throughput of the loop, the player must use IT Advanced Fluid Valves and Pressurized Outputs to move the fluid at its native 1,000 mB/tick (20,000 mB/s) rate without bottlenecking.

## 3. Implementation Checklist for the AI Builder

When constructing this pack, prioritize writing files for the following target points:

- [ ] Datapack Overrides: Create `ie_mineral_mix` JSON overrides increasing `fail_chance` and adding strict biome requirements for major veins.
- [ ] KubeJS Server Script (Encumbrance): Write a player inventory tick checker that triggers when a custom `kubejs:bedrock_ore_chunk` item tag is found, applying the heavy movement penalties or inventory ejection code.
- [ ] KubeJS Recipe Modifications: Modify Create's Track Station, Train Controls, and Train Track recipes to require Immersive Engineering components (Steel Sheets, Mechanical Components, Treated Wood Slabs).
- [ ] Immersive Technology Custom Recipes: Register custom recipes for the IT Solar Melter and Distiller to handle the transition from Bedrock Ore Chunk ──► Molten Ore Slurry ──► Pure Cleaned Ingots.
- [ ] Waystone Configuration Changes: Access `waystones-server.toml` to completely restrict teleportation checks against industrial cargo tags.

Reference: the mod author detailed these exact systems in the Immersive Technology Minecraft 1.20.1 Overview Video, showcasing how the high-RPM steam turbines, modular boilers, and massive pressurized outputs handle the extreme fluid volume loops needed for a centralized processing factory.

---

## ADDENDUM 2026-07-08 — how IT actually works (verified from the jar) + refining options

Corrected understanding of Immersive Technology (MCT-ImmersiveTechnology 2.1.0, MC 1.20.1), extracted from the mod jar's `data/immersivetechnology/recipes/*`:

IT is fundamentally a **power-generation + fluid-processing** mod. It has NO built-in ore→ingot chain and NO molten-metal fluids of its own. Its machines and recipe types:
- **Mixer** (`immersiveengineering:mixer`): items + fluid → fluid. (e.g. gravel + water → gravel_slurry)
- **Solar Tower** (`immersivetechnology:solar_tower`): fluid → heated fluid, `requiredTemp: 400.0`. THE mirror/heat energy-gate the design references.
- **Solar Melter** (`immersivetechnology:melting`): heated fluid → molten fluid, high `requiredTemp` (1000).
- **Distiller** (`immersivetechnology:distiller`): fluid → fluid **+ `item_output` (chance-based item)**. The only fluid→item bridge.
- Plus boilers, steam/gas turbines, electrolytic crucible (614k-energy fluid electrolysis), cooling tower, heat exchanger, radiator — all power/fluid, no items in/out except mixer(in) & distiller(out).

**Implication:** IT cannot melt ore out of the box, BUT a faithful chunk→ingot chain can be built ON TOP of IT using **custom fluids** (KubeJS can register fluids) flowing through IT's real machines:
`chunk → Mixer(+water) → ore-slurry → Solar Tower (400°C gate) → heated slurry → Solar Melter → molten metal → Distiller → ingot`.
This keeps the endgame-IT + massive-energy + complex-multiblock gating the design wants. Cost: ~2 custom fluids/metal (~20 total) + ~3-4 recipes/metal (~30-40), untextured fluids, and multiblock operation can only be verified in-world (not by the bot harness — bots can only confirm recipes/fluids LOAD).

### Refining-direction options (pick one)
- **A. Full IT solar chain (faithful):** custom fluids through Mixer→Solar Tower→Solar Melter→Distiller. Realizes the vision; most content; least automated-verifiable.
- **B. IT power + IE Arc Furnace refines:** chunk → IE Crusher → IE Arc Furnace → ingot, IT supplies Flux. Simple, robust, fully verifiable — but refiner is IE (mid-game), not endgame IT. (User: not convinced.)
- **C. Slim IT chain:** fewer steps/fluids — chunk → IT Mixer (energy) → molten fluid → IT Distiller → ingot (solar tower optional as the heat gate). IT-native + energy-gated, ~half the content of A, more verifiable.
- **D. Energy-wall gate:** simple machine/recipe but with an enormous energy cost only IT-scale generation can sustain. The gate is the power number, not machine complexity.

Whichever is chosen, the un-carriable chunk rule (verified working) and the mineral-mix chunk outputs are independent and proceed regardless.

---

## IMPLEMENTED 2026-07-08 (autonomous pass) — final decisions

Refining path chosen (per user's "fast to run, endgame-IT gated, complex machines" steer): a **slim IT chain** —
`Bedrock <metal> Chunk + water --IT Mixer (energy)--> molten_<metal> (custom fluid) --IT Distiller (energy)--> 64 ingots + slag`.
IT-native, energy-gated (endgame IT power), fast per op (1 chunk → 1 stack of ingots). Solar Tower NOT inserted in the built version (documented as an optional heat step to add). Built for **all 10 metals**. Gems (diamond/lapis) use simple **Create Crushing** per the "gems are crushed not melted" call.

Balance model implemented:
- **Excavator 64× slower**: `machines.excavator.speed = 0.015625` (1/64) in the enforced `world/serverconfig/immersiveengineering-server.toml`. (NOT via fail_chance — that would spam 98% spoil.)
- **Faster vein depletion**: `machines.excavator.yield = 512` (from IE default 38400) — each output is now a chunk == a stack, so a vein gives ~512 chunks then depletes. Vein spawn `chance = 0.9` (IE default) already makes veins rare.
- **Yield**: 1 chunk → 64 ingots (1×). The ≥2× "grinder multiplier" you asked for is a one-number bump (`INGOTS_PER_CHUNK`) or output-to-raw-ore change — flagged as a tuning lever, left at 1× so it's not silently over-generous.

All recipes/fluids/config **verified to LOAD** on a full boot (0 KubeJS errors, 0 failed recipes, excavator config confirmed read). **NOT verified**: in-world multiblock operation (Mixer/Distiller actually running the fluid chain, excavator dig rate, ingot yield) — needs manual in-world testing. See `docs/research/2026-07-08-phaseA-spike-results.md` and `...-morning-report.md`.
