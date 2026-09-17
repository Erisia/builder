# Erisia live inspector

A server-only, read-only diagnostic interface. Its purpose is to preserve evidence
and support administrator decisions without visiting the suspect area, loading a
chunk, serializing arbitrary mod inventories, or changing game state.

## Wish-list and implementation scope

These are the capabilities targeted by the first version, not a list of specific
Minecraft bugs to recognize:

1. **Discover the running world:** server/session identity, loaded dimensions,
   players, entity and tile-entity counts, and chunk residency.
2. **Find concentrations:** a census of resident entities and dropped item units
   by dimension and chunk, including disagreement between world and chunk lists.
3. **Inspect a location remotely:** coordinates/classes/UUIDs, item age and lifespan,
   stored versus actual chunk membership, nearby tile entities, unload queues,
   Forge ticket ownership, and missing neighbors relevant to entity updates.
4. **Observe behavior over a bounded interval:** actual entity/tile update call
   counts and elapsed timings, plus bounded entity-join records with call stacks.
   A join may be a chunk load or a spawn; evidence must distinguish these where
   possible and must not infer a machine owner from proximity.
5. **Compare observations:** preserve raw JSON and calculate growth, retained UUIDs,
   aging/non-aging items, and changed residency without teleporting or cleaning up.
6. **Make evidence trustworthy:** run reads on the server thread, expose limits,
   avoid load/generation APIs, keep captures local, constrain permissions, and test
   that inspection does not change residency or the objects being inspected.
7. **Support later ports:** version the JSON protocol and isolate Minecraft/Forge
   mappings and tick interception in a version adapter. Clients and diagnostic
   recipes should not depend on SRG names.

This is not a remote scripting console. There are no world-edit, inventory-edit,
teleport, entity-removal, chunk-loading, or arbitrary method-invocation commands.
Read-only still has CPU/memory overhead: scans and watches have explicit budgets.

## Built interface (protocol 1)

All commands require Minecraft command permission level 2. Use the local RCON
helper in `tools/skills/minecraft-tick-debug/scripts/evidence.py` to save the full
JSON response, including responses split across RCON packets. No client mod is
required. The mod is added only to E36's `extraServerDirs`, not its client pack.

| Console command | Readout |
| --- | --- |
| `erisia-inspect status` | Adapter/version/session, loaded dimensions, players and coordinates, resident chunks/entities, loaded and ticking tile counts |
| `erisia-inspect census [DIM]` | Resident entities grouped by dimension/chunk and class, item entities versus stack units, item age range, membership disagreements, unload queue and Forge ticket metadata |
| `erisia-inspect chunk DIM CX CZ [OFFSET]` | A resident-only chunk snapshot, up to 1,024 entity details, item ages/lifespans, membership, missing entity-update neighbors, and tile classes/positions in the resident 3×3 neighborhood |
| `erisia-inspect watch start SECONDS [DIM CX CZ]` | Start a 1–60 second observational watch over all loaded worlds or one chunk |
| `erisia-inspect watch status` | Current or last completed watch: observed update calls, total/max elapsed milliseconds per entity/tile, and bounded join-event stacks |

`CX`/`CZ` are **chunk coordinates**, including floor division for negative block
coordinates. No command accepts selectors, arbitrary paths, expressions, or Java
method names. Missing chunks and dimensions remain missing. Inspection does not
call chunk-provisioning APIs, get-block/get-tile world APIs, capability handlers,
entity update methods, or arbitrary mod NBT serialization. Tile readouts access the
already resident tile map; they do not instantiate missing tile entities.

Example capture (run from the builder; choose a new private output directory):

```sh
umask 077
mkdir /tmp/minecraft-inspection
python3 tools/skills/minecraft-tick-debug/scripts/evidence.py inspect 'status' --out /tmp/minecraft-inspection/status.json
python3 tools/skills/minecraft-tick-debug/scripts/evidence.py inspect 'census' --out /tmp/minecraft-inspection/census.json
python3 tools/skills/minecraft-tick-debug/scripts/evidence.py inspect 'chunk 0 100 -50' --out /tmp/minecraft-inspection/before.json
# Capture again after an observation interval, without visiting or loading that area.
python3 tools/skills/minecraft-tick-debug/scripts/evidence.py inspect 'chunk 0 100 -50' --out /tmp/minecraft-inspection/after.json
python3 tools/skills/minecraft-tick-debug/scripts/compare_inspections.py /tmp/minecraft-inspection/before.json /tmp/minecraft-inspection/after.json > /tmp/minecraft-inspection/comparison.json
```

For update timing/provenance, start a watch, wait for its duration, then save
`watch status`. Do not restart an active watch. It automatically stops observing;
results remain in memory until a new watch starts or the server restarts. Watches
hold at most 4,096 object records while active and release live object references
on expiration. At most 128 join events and 20 stack frames per event are retained.
There is one watch per server. A watch modifies only inspector-owned state.
Ticking objects without a mapped world (or non-TileEntity `ITickable` objects)
remain visible in a global watch with null location fields and an explanation.
Scoped watches exclude them and count `unlocated_scoped_observations`; never assign
such work to a guessed dimension. Observer failures include at most eight distinct
class/error samples, truncated to 256 characters, to make adapter gaps actionable.

## Reading the evidence

The JSON `schema` is the protocol version. `session` changes on server restart;
never compare entity identity/timing across sessions without explicitly accounting
for that restart. Snapshot timestamps are UTC epoch milliseconds; `server_tick`
provides a game-time interval independent of wall-clock slowdown.

`complete=false` means a scan reached its soft 50 ms/100,000-visit/4,096-chunk
budget. Scanned counts are then **lower bounds**, not a complete census; a partial empty
result does not clear a suspect. Narrow to a dimension or chunk. Scan time excludes
final JSON formatting/RCON transmission, and first-use JVM/class-loading overhead
can exceed the soft budget. `scan_ms` reports measured scan work. A chunk's entity
page has separate `details_complete`/`next_entity_offset` fields, while tiles,
tickets, player lists, and class categories expose their own truncation markers.
Pages taken on different ticks are not an atomic whole-world snapshot: preserve
page timestamps, deduplicate UUIDs and do not infer removal from a missing page.

Chunk queries scan resident slices first, so even a very large world list does not
prevent an early bounded sample of the target chunk. `chunk_slice_entities_total`
is an exact constant-time sum of resident slice sizes (including non-item entities),
even when the subsequent detail scan is partial. It does not include world-only
objects outside those slices.

Censuses union the world entity list with entity slices in currently resident
chunks. They deliberately exclude saved regions and Forge's dormant chunk cache.
A chunk-only entity is not necessarily on the world's entity-tick list; a
world-only entity may be awaiting membership changes. Targeted chunk queries scan
world entities whose *position* lies there plus entities in that chunk's slices,
so `world_only_entities` means absent from the inspected slice, not a claim that
no other resident chunk holds the object. For complete global membership use a
complete census. Dead entities are reported, not removed.

For the dropped-item failure mode, compare the same UUID's `age_ticks`,
`ticks_existed`, stack count, positions, residency, `update_blocked`, and neighbor
coverage while the server tick advances. Growing resident counts plus retained,
non-aging UUIDs identify a strong candidate without teleporting to it. A watch can
then show whether the entity update actually runs and whether nearby machines
continue updating. Join stacks can suggest the source of new objects.

Important distinctions:

- Forge 1.12.2 ordinarily requires resident chunks within ±32 blocks for entity
  updates (a 5×5 chunk area); a Forge-forced entity chunk reduces this check to
  itself. The report reads the resident map and ticket set without executing the
  `canEntityUpdate` event. Mods/mixins can override the gate, so neighbor coverage
  is a **structural prerequisite**, not proof of whether an update ran.
- Item `age_ticks=-32768` is the vanilla never-despawn sentinel. Lifespans may be
  mod-defined or extended; stack merging and custom item logic can reset ages.
  An age unchanged at two observations is evidence, not proof it never advanced.
- Missing UUIDs may have moved, merged, unloaded, despawned, or been picked up.
  New UUIDs may come from loads or spawns. Entity-join events may be cancelled
  after observation. The stack's origin hint is heuristic and explicitly labelled.
- Forge ticket mod IDs identify ticket ownership, not necessarily a player or
  emitting machine. Nearby tile classes suggest candidates, not guilt.
- Timings wrap the actual World→Entity onUpdate/updateRidden and World→ITickable
  update calls, including exceptions. With HammerLib 2.0.6.14, the optional
  `McHooks.tickTile` adapter observes actual updates after its tick-rate gate.
  They are inclusive elapsed time, not CPU or
  self time. Other schedulers, asynchronous mod work, and different call sites are
  outside coverage. Positions are first-observed positions. Check
  `hooks_observed_since_start`, `observer_errors`, and dropped observations before
  interpreting absence as inactivity. A false hook flag means unverified or
  unavailable coverage, not an inactive entity/tile. A true flag proves that path
  has run during this server session, not that every mod uses that path.
- Inspection uses standard getters/direct fields, avoiding arbitrary NBT and
  inventory callbacks. Other mods can alter those classes, so the integration
  contract must be revalidated after significant updates. There is no claim of
  zero overhead or compatibility with every coremod.

## Build, tests, and deployment

```sh
nix build .#live-inspector -o result-live-inspector
nix build .#checks.x86_64-linux.live-inspector -o result-live-inspector-test
```

The artifact is `result-live-inspector/mods/erisia-live-inspector-0.1.0.jar`.
The test-only JAR is never installed in `mods/`; it lives in a separate test
resource directory. The mod contains no Minecraft classes or bundled client
libraries. Tests start an isolated flat-world Cleanroom server on an ephemeral
loopback port with a 180-second timeout, never the live world. They exercise real
transformed game classes: no-load/no-unload inspection, frozen item ages, residency
disagreement, negative coordinates, growing item piles, actual update observations,
join capture, and observation expiration. Loading a missing neighbor ring is done
only by the test fixture, to prove the frozen item then ages normally.

For local iteration against the installed launcher without new downloads:

```sh
python3 mods/live-inspector/build.py --launcher ~/erisia/forge --java-home /path/to/jdk --output /tmp/inspector-build --with-tests
python3 mods/live-inspector/test.py --launcher ~/erisia/forge --java-home /path/to/jdk --build /tmp/inspector-build
```

E36's server build includes the mod. Deploy through the normal builder and restart
workflow; do not copy it into client manifests. A build alone does not load a mod
into an already-running JVM. Preserve incident evidence before a restart: a restart
changes the chunk/entity lifecycle and invalidates an in-memory watch.

Validated on E36 on 2026-09-17: the isolated test reproduces resident non-aging
items and growing counts over 25 server ticks, then verifies normal aging after
the test loads missing neighbors. Twelve Python tests cover evidence transport,
bounded commands, capture cleanup, and comparison semantics. The final live
five-second watch captured 187 entities and 171 tiles, including the Immersive
Engineering coke oven, with zero observer errors or dropped observations. A live
census completed in 6.2 ms; the empty server reported 20 TPS and 1.666 ms mean
overall tick time. These are smoke-test observations, not a mature-world benchmark.
Raw evidence and compatibility findings are retained privately in
`~/erisia/tick-debug/2026-09-17-inspector-validation/report.md`. A real client login
was not exercised; server-only packaging and permissive remote-mod requirements
were verified in the implementation.

## Porting

The first adapter targets Minecraft 1.12.2 / Cleanroom 0.6.12-alpha, built against
its bundled mappings, CleanMix, and MixinExtras. It is not a generic binary for
other Forge, NeoForge, or Fabric versions.

- `Minecraft112.java` owns resident-world reads, SRG names, chunk membership,
  tickets, item age semantics, and watch object identities.
- `mixin/WorldUpdates.java` owns the vanilla/Forge call sites;
  `mixin/HammerUpdates.java` supports HammerLib's replaced tile call site. Timing
  hooks are optional so a coremod replacing a call site does not prevent server
  startup. Status and watch reports expose which hooks have actually run. Validate
  coverage on the full pack as well as the isolated test server: required injection
  counts initially passed in isolation but prevented E36 startup because HammerLib
  had replaced World's tile call. Wrappers always call the original, preserving
  arguments, return behavior and exceptions.
- `Inspector.java` registers the command and dispatches on the server thread.
  The command/scheduler SRG names there and the Forge event listener in `Watch`
  are additional loader-specific integration points for a port.
- `Watch.java` owns bounded observation storage and report semantics. `Reflect`
  caches exact members and never exposes reflection to command users. Resolve
  world/position fields against their declaring Minecraft class: the deployed
  Immersive Engineering coke oven shadows the SRG position field with an integer,
  so a subclass-first lookup returns the wrong member.
- Python capture/comparison and the skill consume versioned JSON, not mappings.
  Preserve field meaning/units on ports. Use null/explicit unavailable fields for
  unsupported concepts; do not invent 1.12 ticket semantics on modern chunk levels.
  Change the schema version for incompatible meanings and reject unknown versions.

For each port, recreate the fringe-item test with that version's actual chunk
states, verify no-load behavior for every command, verify original update calls
and failure behavior remain unchanged, and test a client connection **without**
the diagnostic mod. Keep census membership, actual update observations, saved
world data, and source attribution as distinct forms of evidence.

Primary semantic references: [Forge 1.12 World patch](https://github.com/MinecraftForge/MinecraftForge/blob/1.12.x/patches/minecraft/net/minecraft/world/World.java.patch),
[EntityItem patch](https://github.com/MinecraftForge/MinecraftForge/blob/1.12.x/patches/minecraft/net/minecraft/entity/item/EntityItem.java.patch),
[ForgeChunkManager](https://github.com/MinecraftForge/MinecraftForge/blob/1.12.x/src/main/java/net/minecraftforge/common/ForgeChunkManager.java).
The actual deployed transformed classes and integration tests take precedence over
a moving upstream branch.
