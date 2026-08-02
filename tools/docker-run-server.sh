#!/usr/bin/env bash
#
# docker-run-server.sh — build and BOOT-test an Erisia pack's dedicated server
# inside the running `erisia-build` Nix Docker container, without needing Nix
# (or the CurseForge key, for all-Modrinth packs) on the host.
#
# Why this exists / what it avoids:
#   * `nix build -f . packs.<pack>.server` FAILS in Docker: nixpkgs'
#     fetch-cargo-vendor sends no User-Agent when vendoring the Rust `control`
#     tool and crates.io 403s it. The `control` tool is only server-management
#     tooling (systemd/tmux/prometheus wrappers) and is NOT needed to run a
#     Minecraft server. So we build ONLY the content targets:
#         packs.<pack>.serverModsDir   -> the side-filtered server mod jars
#         packs.<pack>.launcherDir     -> the Forge/NeoForge server install
#     and assemble a runnable dir ourselves, minus the control tool.
#   * Forge reads stdin; launched with no stdin it hits EOF and shuts down
#     immediately ("Stopping server"). We feed it a kept-open FIFO so it stays
#     up after "Done". (`tmux`/`script`/`setsid` are absent from nixos/nix.)
#
# Scope: Forge / NeoForge packs (launcher dir has run.sh + libraries/.../unix_args.txt).
#        Fabric / vanilla packs use a different launcher layout and are rejected.
#
# Prereqs (see docs/local-server-testing-in-nix-docker.md for full setup):
#   * The `erisia-build` container running with the repo bind-mounted at /repo.
#   * manifest/<pack>.json already resolved (MMMM). If missing, this script
#     tells you and stops — run MMMM per the runbook (steps 2-4).
#
# Usage:
#   tools/docker-run-server.sh [command] [pack] [options]
#     command : up (default) | stop | status | logs | clean
#     pack    : pack name from builder.nix (default: military)
#
#   Options:
#     --world <dir|tar.gz>  boot on a copy of an existing world instead of a
#                           fresh one. Accepts an unpacked dir containing world/,
#                           a world/ dir itself, or a backup tarball from the
#                           mc-erisia backup runbook. Installed AFTER assembly.
#     --no-assemble         reuse the existing server dir instead of rebuilding
#                           and wiping it. Use this to reboot after swapping a
#                           world in, since a plain `up` discards it.
#
#   Testing a world-mutating operation against real data (full runbook in
#   mc-erisia/docs/world-ops-on-a-prod-clone.md):
#     tools/docker-run-server.sh up military --world /tmp/military-world.tar.gz
#     docker exec erisia-build bash -c 'echo "<cmd>" > /root/military-serve/stdin.fifo'
#     tools/docker-run-server.sh stop military
#     tools/docker-run-server.sh up military --no-assemble   # reboot, world intact
#
#   `up` is idempotent: it (re)builds the nix targets, assembles a fresh server
#   dir ONLY if no server is already running, boots it, and waits for "Done".
#
# Env overrides:
#   CONTAINER   docker container name           (default: erisia-build)
#   RAM         -Xmx for the boot test          (default: 4G)
#   JAVA_MAJOR  JRE major version               (default: auto from MC version;
#                                                17 for 1.16-1.20.4, 21 for
#                                                1.20.5/1.21+, 8 for 1.7/1.12)
#   BOOT_TIMEOUT  seconds to wait for "Done"    (default: 300)
#
set -euo pipefail

CONTAINER="${CONTAINER:-erisia-build}"
CMD="up"
PACK="${PACK:-military}"
WORLD_SRC=""
NO_ASSEMBLE=0
_positional=0
while [ $# -gt 0 ]; do
  case "$1" in
    --world)       WORLD_SRC="${2:?--world needs a path}"; shift 2;;
    --world=*)     WORLD_SRC="${1#*=}"; shift;;
    --no-assemble) NO_ASSEMBLE=1; shift;;
    -h|--help)     sed -n '2,50p' "$0"; exit 0;;
    --*)           echo "unknown option: $1" >&2; exit 2;;
    *)             _positional=$((_positional+1))
                   if [ $_positional -eq 1 ]; then CMD="$1"; else PACK="$1"; fi
                   shift;;
  esac
done
RAM="${RAM:-4G}"
JAVA_MAJOR="${JAVA_MAJOR:-auto}"
BOOT_TIMEOUT="${BOOT_TIMEOUT:-300}"

if ! docker inspect -f '{{.State.Running}}' "$CONTAINER" >/dev/null 2>&1; then
  echo "ERROR: container '$CONTAINER' is not running. Start it per the runbook." >&2
  exit 1
fi

# Run a bash program inside the container with our config exported as env vars.
# The heredoc is single-quoted so the HOST does not expand anything; the
# container-side program reads PACK/RAM/JAVA_MAJOR/SUBCMD/etc. from the env.
cexec() {
  docker exec -i \
    -e PACK="$PACK" -e RAM="$RAM" -e JAVA_MAJOR="$JAVA_MAJOR" \
    -e BOOT_TIMEOUT="$BOOT_TIMEOUT" -e SUBCMD="$1" \
    -e NO_ASSEMBLE="$NO_ASSEMBLE" -e WORLD_STAGED="$WORLD_STAGED" \
    "$CONTAINER" bash -s <<'CONTAINER_SCRIPT'
set -euo pipefail
export NIX_CONFIG="experimental-features = nix-command flakes"

SRV="/root/${PACK}-serve"        # working dir (NOT under /repo)
LOG="$SRV/boot.log"
PIDFILE="$SRV/server.pid"
FIFO="$SRV/stdin.fifo"
MODS_OUT="/tmp/${PACK}-srv"       # nix -o for serverModsDir  (result)
LAUNCH_OUT="/tmp/${PACK}-srv-1"   # nix -o for launcherDir    (result-1)

# --- is the server process alive (and not a zombie)? -----------------------
server_alive() {
  [ -f "$PIDFILE" ] || return 1
  local pid; pid="$(cat "$PIDFILE" 2>/dev/null || true)"
  [ -n "$pid" ] || return 1
  # NB: `kill -0` succeeds on ZOMBIES too. Under pid1=`sleep infinity` an
  # orphaned JVM that has exited lingers as a zombie until reaped, so we must
  # inspect the process state field of /proc/PID/stat and reject Z/X. (No awk
  # in nixos/nix, so parse in pure bash. comm (field 2) is parenthesised and
  # may contain spaces, so strip everything through the final ") ".)
  local line st
  line="$(cat "/proc/$pid/stat" 2>/dev/null || true)"
  [ -n "$line" ] || return 1
  st="${line#*) }"; st="${st%% *}"
  case "$st" in R|S|D|T|t) return 0;; *) return 1;; esac
}

status() {
  if server_alive; then
    echo "STATUS: $PACK server RUNNING (pid $(cat "$PIDFILE"))"
  else
    echo "STATUS: $PACK server not running"
  fi
  if [ -f "$LOG" ]; then
    echo "--- last Done/error marker ---"
    grep -aE 'Done \(|Failed to start|Crash report|Stopping server' "$LOG" | tail -3 || true
  fi
}

case "$SUBCMD" in
  status) status; exit 0;;
  logs)   [ -f "$LOG" ] && tail -n 60 "$LOG" || echo "no log at $LOG"; exit 0;;
  stop)
    if ! server_alive; then echo "not running"; status; exit 0; fi
    pid="$(cat "$PIDFILE")"
    echo "sending 'stop' to pid $pid ..."
    printf 'stop\n' > "$FIFO" || true
    for i in $(seq 1 60); do server_alive || break; sleep 2; done
    if server_alive; then
      echo "graceful stop timed out; killing $pid"; kill -9 "$pid" 2>/dev/null || true
    else
      echo "stopped cleanly"
    fi
    exit 0;;
  clean)
    echo "stopping (if running) and removing $SRV"
    if server_alive; then printf 'stop\n' > "$FIFO" || true;
      for i in $(seq 1 30); do server_alive || break; sleep 2; done
      server_alive && kill -9 "$(cat "$PIDFILE")" 2>/dev/null || true
    fi
    rm -rf "$SRV"; echo "removed $SRV"; exit 0;;
  up) : ;;  # fall through to the build+assemble+boot flow below
  *) echo "unknown command: $SUBCMD" >&2; exit 2;;
esac

# ---------------------------------------------------------------------------
# up: build + assemble + boot + wait-for-Done
# ---------------------------------------------------------------------------
if server_alive; then
  echo "$PACK server is already running (pid $(cat "$PIDFILE")); skipping boot."
  status; exit 0
fi

NO_ASSEMBLE="${NO_ASSEMBLE:-0}"
WORLD_STAGED="${WORLD_STAGED:-}"

if [ "$NO_ASSEMBLE" = "1" ]; then
  # Reboot the existing server dir as-is. This is the mode you want after
  # swapping in a world: a normal `up` would rm -rf the dir and discard it.
  [ -d "$SRV" ] || { echo "ERROR: --no-assemble but $SRV does not exist; run 'up' once first." >&2; exit 1; }
  echo "==> --no-assemble: reusing existing $SRV ($(ls "$SRV/mods" 2>/dev/null | wc -l) mods)"
else
MANIFEST="/repo/manifest/${PACK}.json"
if [ ! -f "$MANIFEST" ]; then
  echo "ERROR: $MANIFEST not found. Resolve it with MMMM first (runbook steps 2-4):" >&2
  echo "  /repo/modestly-modular-modpack-modifier-cli -o manifest manifest/${PACK}.yaml" >&2
  exit 1
fi

echo "==> building serverModsDir + launcherDir for '$PACK' (skips control tool)"
cd /repo
nix build -f . "packs.${PACK}.serverModsDir" "packs.${PACK}.launcherDir" -o "$MODS_OUT"
# -o writes $MODS_OUT (first target = mods) and $LAUNCH_OUT (second = launcher)
fi

# --- pick the JRE (Forge 1.20.1 needs Java 17; map by MC version) ----------
if [ "$JAVA_MAJOR" = "auto" ]; then
  MC="$(grep -A10 -E "^  ${PACK} = \{" /repo/builder.nix | grep -m1 -oE 'minecraft = "[^"]+"' | cut -d'"' -f2 || true)"
  case "$MC" in
    1.7.*|1.12.*)                 JAVA_MAJOR=8;;
    1.20.5|1.20.6|1.21*|1.22*)    JAVA_MAJOR=21;;
    *)                            JAVA_MAJOR=17;;   # 1.16-1.20.4 (incl. 1.20.1)
  esac
  echo "==> detected Minecraft '$MC' -> Java $JAVA_MAJOR"
fi
JRE="/tmp/jre-${JAVA_MAJOR}"
echo "==> ensuring Temurin JRE $JAVA_MAJOR"
nix build "nixpkgs#temurin-jre-bin-${JAVA_MAJOR}" -o "$JRE"

# --- assemble a fresh, writable server dir ---------------------------------
if [ "$NO_ASSEMBLE" = "1" ]; then
  echo "==> skipping assemble"
else
echo "==> assembling $SRV"
rm -rf "$SRV"; mkdir -p "$SRV/mods"
# 1) base config dirs, lowest precedence first so higher-precedence wins on
#    conflict (matches the nix symlinkJoin: military-server > server; the forge
#    launcher, copied last, always wins for run.sh/user_jvm_args/libraries).
for d in "base/server" "base/${PACK}-server" "base/${PACK}"; do
  [ -d "/repo/$d" ] && cp -rL "/repo/$d/." "$SRV/" 2>/dev/null || true
done
# 2) forge/neoforge launcher install (run.sh, user_jvm_args.txt, libraries/).
#    launcherDir wraps its content in a single subdir (forge/ | fabric/ | vanilla/).
LDIR="$(ls -d "$LAUNCH_OUT"/*/ 2>/dev/null | head -1)"
[ -n "$LDIR" ] && cp -rL "$LDIR". "$SRV/"
# 3) server-side mod jars.
for j in "$MODS_OUT"/*.jar; do cp -L "$j" "$SRV/mods/"; done
chmod -R u+w "$SRV"
echo "eula=true" > "$SRV/eula.txt"   # local test only; real deploy accepts EULA separately
echo "    mods: $(ls "$SRV/mods" | wc -l)"
fi   # end of assemble

# --- install a staged world (see mc-erisia/docs/world-ops-on-a-prod-clone.md) ---
# Done AFTER assembly, because assembly wipes $SRV.
if [ -n "$WORLD_STAGED" ] && [ -d "$WORLD_STAGED/world" ]; then
  echo "==> installing staged world into $SRV/world"
  rm -rf "$SRV/world"
  cp -a "$WORLD_STAGED/world" "$SRV/world"
  echo "    regions: $(ls "$SRV/world/region"/*.mca 2>/dev/null | wc -l)"
fi

# Locate the Forge/NeoForge arg file (loader-agnostic within forge-likes).
ARGS="$(cd "$SRV" && find -L libraries -name unix_args.txt 2>/dev/null | head -1)"
if [ -z "$ARGS" ]; then
  echo "ERROR: no libraries/.../unix_args.txt found — this script only supports" >&2
  echo "       Forge/NeoForge packs (fabric/vanilla use a different layout)." >&2
  exit 1
fi

# --- boot headless, keeping stdin open via a FIFO so Forge doesn't EOF-stop -
echo "==> booting (Xmx=$RAM, Java $JAVA_MAJOR)"
cd "$SRV"
rm -f "$FIFO"; mkfifo "$FIFO"
# Hold the FIFO open for writes for a long time so the server never sees EOF on
# stdin (else Forge reads EOF and immediately "Stopping server"). ALL of the
# holder's std streams are detached (stdin</dev/null, stderr>/dev/null, stdout
# is the FIFO write end) so it does NOT keep this `docker exec` pipe open — an
# undetached background process would hang the exec call until it exits. The
# holder is orphaned to pid1 and keeps running after this shell exits.
nohup sleep 86400 > "$FIFO" 2>/dev/null < /dev/null &
echo $! > "$SRV/fifo_holder.pid"
# Likewise the JVM: stdin from the FIFO, stdout+stderr to the log.
PATH="$JRE/bin:$PATH" nohup java "-Xmx${RAM}" @user_jvm_args.txt @"$ARGS" nogui \
  < "$FIFO" > "$LOG" 2>&1 &
echo $! > "$PIDFILE"
echo "    java pid $(cat "$PIDFILE"), log: $LOG"

# --- wait for Done (or failure) --------------------------------------------
echo "==> waiting up to ${BOOT_TIMEOUT}s for 'Done'"
deadline=$(( $(date +%s) + BOOT_TIMEOUT ))
while [ "$(date +%s)" -lt "$deadline" ]; do
  if grep -aqE 'Done \(' "$LOG"; then
    echo "SUCCESS:"; grep -aE 'Done \(' "$LOG" | tail -1
    server_alive && echo "server is UP and staying up (pid $(cat "$PIDFILE"))." \
                 || echo "WARNING: 'Done' seen but process not alive?"
    echo "Stop it with:  tools/docker-run-server.sh stop ${PACK}"
    exit 0
  fi
  if grep -aqE 'Failed to start|Crash report|Stopping server' "$LOG"; then
    echo "FAILURE: server did not reach Done. Tail:"; tail -25 "$LOG"; exit 1
  fi
  server_alive || { echo "FAILURE: process died before Done. Tail:"; tail -25 "$LOG"; exit 1; }
  sleep 3
done
echo "TIMEOUT after ${BOOT_TIMEOUT}s. Tail:"; tail -25 "$LOG"; exit 1
CONTAINER_SCRIPT
}

# --- stage a world into the container before running the container program ---
# Copying happens HOST-side because docker cp cannot run from inside the container.
WORLD_STAGED=""
if [ -n "$WORLD_SRC" ]; then
  [ -e "$WORLD_SRC" ] || { echo "ERROR: --world path not found: $WORLD_SRC" >&2; exit 1; }
  WORLD_STAGED="/tmp/${PACK}-world-staged"
  echo "==> staging world from $WORLD_SRC"
  docker exec "$CONTAINER" rm -rf "$WORLD_STAGED"
  docker exec "$CONTAINER" mkdir -p "$WORLD_STAGED"
  case "$WORLD_SRC" in
    *.tar.gz|*.tgz)
      docker cp "$WORLD_SRC" "$CONTAINER:$WORLD_STAGED/world.tar.gz"
      # tarballs from the backup runbook contain a top-level world/ dir
      docker exec "$CONTAINER" tar -xzf "$WORLD_STAGED/world.tar.gz" -C "$WORLD_STAGED"
      docker exec "$CONTAINER" rm -f "$WORLD_STAGED/world.tar.gz"
      ;;
    *)
      docker cp "$WORLD_SRC" "$CONTAINER:$WORLD_STAGED/world"
      ;;
  esac
  docker exec "$CONTAINER" sh -c "ls -d $WORLD_STAGED/world >/dev/null" \
    || { echo "ERROR: staged world has no world/ dir (tarball layout?)" >&2; exit 1; }
fi

cexec "$CMD"
