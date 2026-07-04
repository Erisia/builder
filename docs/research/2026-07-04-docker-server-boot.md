# Booting a pack's dedicated server inside the Nix Docker container (2026-07-04)

Goal: reach `Done (…s)!` for the `military` pack (Forge 1.20.1 / 47.4.10, 53 mods,
all Modrinth) **inside** the `erisia-build` `nixos/nix` container, so packs can be
boot-tested locally instead of on tsugumi. Durable deliverables:
- `tools/docker-run-server.sh` — one-shot build+boot+wait script (host-side driver).
- `docs/local-server-testing-in-nix-docker.md` — runbook section "Launching the server
  (not just building) in Docker".

## Result

**YES — reached Done, server stays up, clean `stop`.** Verified via the script:

```
$ tools/docker-run-server.sh up military
...
SUCCESS:
[18:38:41] [Server thread/INFO] [minecraft/DedicatedServer]: Done (13.579s)! For help, type "help"
server is UP and staying up (pid 3022).
$ tools/docker-run-server.sh stop military
sending 'stop' to pid 3022 ...
stopped cleanly
```

(An earlier manual run reached `Done (13.077s)!` identically.) 48 server-side jars
loaded (client-only mods filtered out of the 53). MC load time ~27s incl. Forge init.

## What worked (verified commands)

Inside the container (`docker exec -i erisia-build bash -s`), repo bind-mounted at `/repo`,
`export NIX_CONFIG="experimental-features = nix-command flakes"`:

1. Build content targets only (NO control tool):
   `nix build -f . packs.military.serverModsDir packs.military.launcherDir -o /tmp/military-srv`
   → `/tmp/military-srv` = `manifest-mods` (48 `.jar`s); `/tmp/military-srv-1` = `…-forge`
   containing `forge/{run.sh,user_jvm_args.txt,libraries/}`. Both build in ~1s (cached),
   keyless (all Modrinth).
2. JRE: `nix build nixpkgs#temurin-jre-bin-17 -o /tmp/jre-17` (Forge 1.20.1 needs Java 17).
3. Assemble `/root/military-serve`: copy `base/server` + `base/military-server` +
   `base/military` (in that order — later wins, matching the nix symlinkJoin precedence:
   `military-server` > `server`), then overlay the forge launcher (`run.sh`,
   `user_jvm_args.txt`, `libraries/`), then the mod jars into `mods/`; `chmod -R u+w`;
   `echo eula=true > eula.txt`.
4. Arg file: `find -L libraries -name unix_args.txt` →
   `libraries/net/minecraftforge/forge/1.20.1-47.4.10/unix_args.txt`.
5. Boot with FIFO-held stdin:
   ```
   mkfifo stdin.fifo
   nohup sleep 86400 > stdin.fifo 2>/dev/null < /dev/null &
   PATH=/tmp/jre-17/bin:$PATH nohup java -Xmx4G @user_jvm_args.txt @<unix_args> nogui \
     < stdin.fifo > boot.log 2>&1 &
   ```
6. Wait: poll `grep -aE 'Done \(|Failed to start|Crash report|Stopping server' boot.log`.
7. Stop: `printf 'stop\n' > stdin.fifo`.

## Trial-and-error / gotchas discovered

- **`packs.military.server` build fails (crates.io 403)** while vendoring the Rust
  `control` tool — known blocker, do not fight it. The control tool is only
  systemd/tmux/prometheus management and is unneeded to run the server. Build
  `serverModsDir`+`launcherDir` and assemble by hand.
- **stdin EOF → instant "Stopping server".** Plain `nohup java … &` gives Forge a closed
  stdin; it reads EOF and shuts down before you can use it. Fix: kept-open FIFO. No
  `tmux`/`script`/`setsid` in the minimal `nixos/nix` image (verified missing), so FIFO
  is the available option. (`bash`, `mkfifo`, `grep`, `find`, `date` present; `awk`,
  `sed`, `tmux`, `setsid`, `script` absent.)
- **Zombie liveness trap.** After a clean `stop`, the orphaned JVM becomes a **zombie**
  (`/proc/<pid>/stat` state `Z`, comm `(.java-wrapped)`) because container `pid1 =
  sleep infinity` never reaps it, and `kill -0 <pid>` *succeeds* on zombies. Liveness
  must read the stat state field and reject `Z`/`X`. Pure-bash parse (no awk):
  `line=$(cat /proc/$pid/stat); st=${line#*) }; st=${st%% *}`.
- **`docker exec` needs `-i`** to feed a script via `bash -s` on stdin — else bash reads
  an empty stdin and exits 0 with no output (silent no-op).
- **Detached bg jobs must not hold the exec pipe.** Redirect ALL of the FIFO holder's and
  the JVM's std streams; an undetached background child keeps `docker exec`'s stdout open
  and hangs the call (24h for the `sleep 86400` holder).

## Sources
- Repo: `lib/lib.nix` (`launcherDir`, `serverModsDir`, `server` symlinkJoin, `fetchForgeLike`),
  `builder.nix` (military pack: 1.20.1 / forge 47.4.10, extraServerDirs = military-server + server),
  `launcher-lock.json` (forge 1.20.1-47.4.10 outputHash), `military-local.nix`.
- Live verification in container `erisia-build` (Nix 2.34.7, Temurin-17.0.19).
