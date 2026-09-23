# Save threading fix (experimental)

Server-only mixins for **Minecraft 1.12.2 / Cleanroom 0.6.12-alpha**, built against
its bundled CleanMix 0.7.2 and MixinExtras 0.5.5. No client installation is needed.
This is an opt-in artifact; building it does not change E36 or the snapshot hook.

## Build and test

From the builder repository root:

```sh
nix-build builder.nix -A saveThreadingFix -o result-save-threading-fix
./result-save-threading-fix/bin/test-save-threading
```

The installable jar is `result-save-threading-fix/mods/erisia-save-threading-0.1.0.jar`.
The test command starts a fresh flat-world server on an ephemeral loopback port,
runs the tests, stops the server, and returns zero only on `PASS`. It prints the
temporary directory containing `console.log`, `test-result.txt`, region files,
and exported mixin classes. It never opens the live world. Each run has a
180-second process timeout and each test wait has a shorter deadline.

The Nix integration check runs the same test in the build sandbox:

```sh
nix-build builder.nix -A saveThreadingFix.tests.integration -o result-save-threading-test
```

Flake equivalents, once the new files are tracked, are `nix build .#save-threading-fix`
and `nix build .#checks.x86_64-linux.save-threading-fix`.

To build against an already installed launcher without downloading dependencies:

```sh
export JAVA_HOME=/path/to/jdk-25
python3 mods/save-threading-fix/build.py --launcher /path/to/server/forge --with-tests
python3 mods/save-threading-fix/test.py --launcher /path/to/server/forge
```

`--launcher` supplies only read-only jars/libraries. Use the directory containing
`cleanroom-0.6.12-alpha.jar` and `libraries/`. Python 3 and a JDK 25 are required.
The production jar contains no Minecraft classes, bundled libraries, or test hooks.
Compilation uses explicit production SRG names from Cleanroom's bundled
`deobf_data-1.12.2.tsrg`; this is intentionally not a general Forge/development-name build.
The mixin config is required, and each wrapper requires its target to match.

## What changes

`AnvilChunkLoader` uses one reentrant monitor per loader around all of:

- `writeNextIO` (`func_75814_c`), including the complete region-file write.
- `flush` (`func_75818_b`), including its drain loop and flushing flag.
- `addChunkToPending` (`func_75824_a`).

This prevents two consumers passing the nonempty check and then removing the same
last entry. Holding the lock through the write also prevents flush from returning
while another writer still owns dequeued data. Locking enqueue prevents vanilla's
`chunksBeingSaved.contains(pos)` check from silently dropping a newer save while
an older one is being written. Different loaders can still write independently.
An enqueue can now wait for a disk write, so slow storage can increase tick latency.

`DedicatedServer.handleRConCommand` (`func_71252_i`) schedules the **whole** original
method on `MinecraftServer.callFromMainThread` (`func_175586_a`) and waits for its
result. That includes clearing and reading the shared RCON response buffer.
Calls already on the server thread execute directly. Interrupted waits restore
the interrupt flag and fail; scheduler failures propagate instead of returning
a successful save response.

### `save-wait` (RCON only)

`save-all flush` makes the server thread compress and write every queued chunk itself,
which stalls the game for the whole drain. For snapshots, use this instead:

```
save-off
save-all          # server thread: consistent cut, chunks serialised and queued
save-wait [secs]  # RCON thread: wait until the File IO Thread has written them all
<snapshot>
save-on
```

`save-wait` is handled before the RCON command is moved to the server thread, so only the
calling RCON connection blocks; the game keeps ticking and other RCON commands still run.
It returns once every dimension's `AnvilChunkLoader` that was loaded at the start has no
queued or in-flight chunk and vanilla's `waitForFinish` counters match. It is lock-free:
chunk positions move from `chunksToSave` to `chunksBeingSaved` before the region write and
leave the latter only afterwards. While waiting it sets vanilla's `waitForFinish` flag, so
the writer skips its 10 ms sleep between chunks. A loader stranded by vanilla's
`queueIO`/remove race is re-queued from the server thread once per second.

Replies: success starts with `Save queue drained`; every failure starts with
`save-wait failed:` (timeout, default 300 s and 1–86400 accepted, File IO Thread missing
or dead, bad arguments, or a call from the server thread). **Hook scripts must check the
reply** and must not snapshot on failure. The result is also logged under `ErisiaSaveThreading`.

Like `save-all flush`, this only covers chunks. Player data, `level.dat` and map data
are already written synchronously by `save-all`. Mods writing their own files, or saving
chunks during `save-off`, are not covered. The RCON client's own read timeout must be
longer than the drain.

### Unchanged

The global IO queue and `waitForFinish` are left intact. In particular, no lock
is held around waiting for that worker, and worker exceptions are not swallowed.
Moving RCON alone is insufficient: even a server-thread flush can race with the
File IO Thread's chunk writer.

## Regression coverage and negative controls

Tests run against the actual transformed Cleanroom classes and actual region-file
IO. A separate test-only mixin inserts latch barriers at two points in
`writeNextIO`; no production save logic is replaced by a simulation.

| Case | Forced interleaving and assertion |
| --- | --- |
| `dequeue` | Pause after the nonempty check; a competing flush must wait. Without the fix, the writer throws the reported `NoSuchElementException`. |
| `write` | Pause after dequeue, before the disk write; flush must not return early. |
| `enqueue` | Pause an older write; enqueue newer NBT for the same position. After both finish and flush completes, read revision 2 from the region file. |
| `rcon` | Check server-thread execution and isolated replies for 32 concurrent calls, the already-on-server-thread path, and three `save-off` / `save-all flush` / `save-on` cycles. |
| `wait` | `save-all` then `save-wait`; then pause the real File IO Thread before a marker chunk's disk write. `save-wait` must still be blocked after 500 ms while the server keeps ticking and answers another RCON command, succeed after release, and the marker must be readable from the region file. Also checks timeout (`save-wait 1` fails in 1–5 s), recovery, bad arguments, and refusal on the server thread. |

The chunk tests also verify another loader can drain while the first is paused,
that `waitForFinish` completes, and that the File IO Thread remains alive.
RCON tests invoke its actual command entry point from background threads; they do
not test the unchanged RCON socket protocol.

Run a single case with `--case dequeue`, `write`, `enqueue`, `rcon`, or `wait`.
Remove only the production fix, keeping the same instrumentation, with:

```sh
./result-save-threading-fix/bin/test-save-threading --without-fix --case dequeue
./result-save-threading-fix/bin/test-save-threading --without-fix --case write
./result-save-threading-fix/bin/test-save-threading --without-fix --case enqueue
./result-save-threading-fix/bin/test-save-threading --without-fix --case rcon
./result-save-threading-fix/bin/test-save-threading --without-fix --case wait
```

These commands **must exit nonzero**. Check `test-result.txt` and `console.log`:
expected failures are `flush must wait for in-flight dequeue` (with the
`NoSuchElementException` stack), `flush must wait for in-flight write`,
`enqueue must wait for in-flight write`, and `RCON worker failure` with
`RCON executed off server thread`, and `save-wait refuses to block the server thread:
Unknown command`. Startup failure does not count as reproduction.

Validated on 2026-09-16: all fixed cases passed, each of the four unpatched controls
failed for its expected reason, and the Nix build/integration check passed.

## Staging and rollout

Install only `erisia-save-threading-0.1.0.jar` into a stopped staging server's
`mods/`, using a copy of the E36 pack and world. Never install the `-tests` jar on
a normal server: it runs tests and stops the server automatically.

On staging, exercise concurrent RCON commands, repeated `save-all flush`, and a
Compact Machines dimension load/unload. Confirm save messages originate on
`Server thread`, the File IO Thread survives, and a restarted copy of a snapshot
contains changes made before its flush. This full-pack/world validation remains
necessary; the automated suite uses Cleanroom plus the fix and test harness.

After staging, the built derivation can be added to E36's `extraServerDirs` as
`saveThreadingFix`, or the production jar can be installed manually. Restart to
apply or remove it. A process whose File IO Thread has already died also needs
a restart. In the snapshot hook, use `save-all` followed by `save-wait` (see above)
rather than `save-all flush`; keep the existing save-off/save-on recovery behavior.

This addresses the reproduced concurrency bugs, not arbitrary IO failures,
disk durability guarantees, or mods mutating NBT after handing it to the writer.
Vanilla still logs and catches disk-write errors; a successful command response
alone cannot certify an error-free backup.

## References

- Local incident report: `~/web/crash-analysis/e36/2026-09-15-174746.md`.
- [Pinned Cleanroom AnvilChunkLoader patch](https://github.com/CleanroomMC/Cleanroom/blob/0.6.12-alpha/patches/minecraft/net/minecraft/world/chunk/storage/AnvilChunkLoader.java.patch).
- [Pinned Cleanroom MinecraftServer patch](https://github.com/CleanroomMC/Cleanroom/blob/0.6.12-alpha/patches/minecraft/net/minecraft/server/MinecraftServer.java.patch).
- [Cleanroom early mixin registration](https://cleanroommc.com/wiki/forge-mod-development/mixin/environment/registration).
