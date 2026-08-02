// Immersive Petroleum reservoir retrogen.
//
// IP's reservoirs are placed by a worldgen Feature (FeatureReservoir ->
// ReservoirHandler.scanChunkForNewReservoirs) at the moment a chunk is FIRST
// generated. IP was added to this pack on 2026-08-02, long after the world was
// created (2026-07-04), so every pre-existing chunk has no reservoir data and
// the Seismic Survey Tool shows only cosmetic static there.
//
// This re-runs IP's own scan over already-generated chunks. Full source
// analysis: mc-erisia/docs/research/2026-08-02-ip-reservoir-generation.md
//
// Constraints that shape the code below (all from that analysis):
//   * NEVER call ReservoirRegionDataStorage.addIsland directly -- ReservoirIsland
//     overrides neither equals nor hashCode, so its dedupe is identity-based and
//     always false. All duplicate-safety lives in scanChunkForNewReservoirs's
//     existsAt guard.
//   * That guard does `return`, not `continue`, so AT MOST ONE island is created
//     per call, and a chunk touching an already-saved blob first creates nothing
//     for a second, unsaved blob. Hence repeated passes until a pass is dry.
//   * Exact reproduction of the original fluid type/volume is impossible: they
//     come from the triggering chunk's random, and chunk generation order was
//     player-driven and is recorded nowhere. We instead seed deterministically
//     from the chunk coords so OUR result is reproducible on a re-run.
//   * Nothing reaches disk until autosave/shutdown -- follow a sweep with /stop.
//   * ReservoirHandler.CACHE memoises null lookups and is only cleared on server
//     stop, so clearCache() after sweeping or old queries keep reporting empty.

var IP_PKG = 'flaxbeard.immersivepetroleum'

// Resolved lazily: if KubeJS's class filter blocks these, we want a clean error
// message in chat rather than a script that fails to load at all.
var _IP = null
function IP() {
  if (_IP !== null) return _IP
  _IP = {
    Handler: Java.loadClass(IP_PKG + '.api.reservoir.ReservoirHandler'),
    Storage: Java.loadClass(IP_PKG + '.common.ReservoirRegionDataStorage'),
    RegionPos: Java.loadClass(IP_PKG + '.common.ReservoirRegionDataStorage$RegionPos'),
    ChunkPos: Java.loadClass('net.minecraft.world.level.ChunkPos'),
    ColumnPos: Java.loadClass('net.minecraft.server.level.ColumnPos'),
    Legacy: Java.loadClass('net.minecraft.world.level.levelgen.LegacyRandomSource'),
  }
  return _IP
}

// Deterministic per-chunk RNG.
//
// Two deliberate choices:
//  * LegacyRandomSource rather than RandomSource.create(long) -- the latter is a
//    static INTERFACE method and Rhino resolves those unreliably.
//  * The seed is computed entirely in Java via ChunkPos.asLong. Rhino numbers are
//    IEEE doubles, so mixing a 64-bit world seed with JS arithmetic silently
//    loses precision above 2^53 and would NOT be reproducible. asLong packs both
//    chunk coords into one long exactly. The world seed is fixed for this world,
//    so omitting it costs nothing and keeps the derivation exact.
// The seed is scrambled through a throwaway generator before use. Seeding
// java.util.Random (which LegacyRandomSource wraps) with structured, nearly
// sequential values leaves the FIRST draw correlated across seeds -- and IP's
// very first draw is the one that picks the fluid type. A direct
// ChunkPos.asLong seeding measurably skewed the mix: 53 oil / 25 lava / 21
// aquifer against the recipes' 40/30/30 weights (chi-square ~7.8, p~0.02) over
// 99 islands. Burning one draw and re-seeding from nextLong() decorrelates it.
function rngFor(cx, cz) {
  var scramble = new (IP().Legacy)(IP().ChunkPos.asLong(cx, cz))
  scramble.nextLong()
  return new (IP().Legacy)(scramble.nextLong())
}

// Progress metric = reservoir COVERAGE, not island count.
//
// ReservoirRegionDataStorage.getRegionData is overloaded (BlockPos | RegionPos)
// and Rhino cannot disambiguate the call ("choice of Java method ... is
// ambiguous"), so an exact island count is awkward to get from a script.
// existsAt(ColumnPos) has no overloads and works cleanly -- and it measures the
// thing we actually care about: how much of the region now has reservoir data.
//
// Sampled on a 16-block grid (32x32 = 1024 probes per 512x512 region). The
// observed island is 65 blocks across, so a 16-block grid cannot miss one.
var COVERAGE_STEP = 16
function coverage(storage, rx, rz) {
  var hits = 0
  var baseX = rx * 512, baseZ = rz * 512
  for (var ox = 0; ox < 512; ox += COVERAGE_STEP) {
    for (var oz = 0; oz < 512; oz += COVERAGE_STEP) {
      if (storage.existsAt(new (IP().ColumnPos)(baseX + ox, baseZ + oz))) hits++
    }
  }
  return hits
}

// The console log is the authoritative output (we drive this from the server
// console via a FIFO, where chat feedback may not be available at all).
function say(src, msg) {
  console.info('[ip-retrogen] ' + msg)
  try {
    src.sendSystemMessage(Text.of('[ip-retrogen] ' + msg))
  } catch (ignored) { /* console-only source */ }
}

// NOTE ON `var`: this file deliberately uses `var` everywhere, never const/let.
// KubeJS's Rhino hoists function-local const/let into a scope shared by the whole
// script, so the same name declared in two functions dies with
// "redeclaration of var <name>". `var` redeclaration is legal and works.
//
// NOTE: the command bodies live in top-level functions, NOT inline in the
// .executes() closures. KubeJS's Rhino compiles sibling closures registered in
// one commandRegistry call into a shared scope, so a `const` of the same name in
// two of them dies with "redeclaration of var <name>". Real functions get real
// scopes and sidestep it entirely.

// Diagnostics: prove the classes resolve and the noise/storage agree, before any
// mutation. Safe to run anywhere.
function ipSmoke(src) {
  // Step-by-step: a Java Error (e.g. a linkage/NoSuchMethod failure from Rhino's
  // remapper) is NOT caught by a JS catch, so the only way to see where it dies
  // is to log before each call.
  try {
    say(src, 'step1 getLevel')
    var level = src.getLevel()
    say(src, 'step2 Storage.get')
    var storage = IP().Storage.get()
    say(src, 'step3 getSeed=' + level.getSeed())
    say(src, 'step4 rng nextInt=' + rngFor(0, 0).nextInt())
    say(src, 'step5 coverage(-2,0)=' + coverage(storage, -2, 0))
    say(src, 'step6 initGenerator')
    IP().Handler.initGenerator(level)
    say(src, 'step7 getValueOf(-851,-325)=' + IP().Handler.getValueOf(level, -851, -325))
    say(src, 'step8 getValueOf(-766,322)=' + IP().Handler.getValueOf(level, -766, 322))
    say(src, 'SMOKE OK')
  } catch (err) {
    say(src, 'SMOKE FAILED: ' + err)
  }
  return 1
}

// Sweep one 512x512 region (32x32 chunks), repeating until a pass creates
// nothing new. A no-op where data already exists.
function ipSweepRegion(src, rx, rz) {
  try {
    var level = src.getLevel()
    var storage = IP().Storage.get()
    IP().Handler.initGenerator(level)

    var before = coverage(storage, rx, rz)
    var pass = 0, total = 0
    // At most one island per call, so iterate; 6 passes is far more than the
    // observed blob density needs, and it exits early on the first dry pass.
    while (pass < 6) {
      pass++
      var start = coverage(storage, rx, rz)
      for (var cz = 0; cz < 32; cz++) {
        for (var cx = 0; cx < 32; cx++) {
          var chunkX = rx * 32 + cx
          var chunkZ = rz * 32 + cz
          IP().Handler.scanChunkForNewReservoirs(
            level,
            new (IP().ChunkPos)(chunkX, chunkZ),
            rngFor(chunkX, chunkZ)
          )
        }
      }
      var made = coverage(storage, rx, rz) - start
      total += made
      say(src, 'pass ' + pass + ': coverage +' + made)
      if (made === 0) break
    }
    IP().Handler.clearCache()
    say(src, 'region ' + rx + ',' + rz + ' done: coverage ' + before + ' -> ' +
      coverage(storage, rx, rz) + ' of 1024 probes (+' + total + '). ' +
      'Run /stop to flush to disk.')
  } catch (err) {
    say(src, 'SWEEP FAILED: ' + err)
  }
  return 1
}

ServerEvents.commandRegistry(event => {
  var { commands: Commands, arguments: Arguments } = event

  event.register(
    Commands.literal('ipretro')
      .requires(src => src.hasPermission(2))
      .then(Commands.literal('smoke')
        .executes(ctx => ipSmoke(ctx.source)))
      .then(Commands.literal('region')
        .then(Commands.argument('rx', Arguments.INTEGER.create(event))
          .then(Commands.argument('rz', Arguments.INTEGER.create(event))
            .executes(ctx => ipSweepRegion(
              ctx.source,
              Arguments.INTEGER.getResult(ctx, 'rx'),
              Arguments.INTEGER.getResult(ctx, 'rz')))))))
})
