# Local pack + server testing in a Nix Docker container

How to build **any** Erisia pack and **boot-test its server headless** on a machine that doesn't
have Nix installed (e.g. a WSL/dev box), using a `nixos/nix` container. Substitute `<pack>` with the
pack name from `builder.nix` (`e34_5`, `e35`, `military`, …) throughout.

> Booting the **dedicated server** is the practical headless smoke-test: if a mod is missing a
> dependency, has a mixin conflict, or crashes on load, the server won't reach `Done`. It exercises
> all server-side + `both` mods — just not the client-only rendering mods.

**Scope:** written for **Forge / NeoForge** packs (the launcher dir has `run.sh` + `unix_args.txt`).
Fabric and vanilla packs use a different launcher layout, so the boot command in step 6 differs.

## 0. Prerequisites

- Docker.
- (Only if the pack has `source: curse` mods) a CurseForge API key. An **all-Modrinth** pack builds
  keyless. (The `military` pack write-up in [`research/2026-07-02-military-rp-modpack.md`](research/2026-07-02-military-rp-modpack.md)
  is a worked example of this whole flow.)
- **A JRE matching the pack's Minecraft version** (step 6): Java **17** for MC 1.18–1.20.4,
  Java **21** for 1.20.5 / 1.21+, Java **8** for 1.12.2.

## 1. Start a persistent Nix container

Use one long-lived container so the `/nix` store persists across steps (a fresh `docker run` each
time re-downloads everything).

```bash
docker run -d --name erisia-build \
  -v /path/to/erisia-builder:/repo \
  -e NIX_CONFIG="experimental-features = nix-command flakes" \
  nixos/nix sleep infinity

docker exec erisia-build git config --global --add safe.directory /repo
```

## 2. Get MMMM (the manifest resolver)

The `.gitmodules` URL is **SSH** (`git@github.com:Maxwell-lt/...`) which can't auth headless.
Clone via **HTTPS** into the submodule path instead:

```bash
docker exec erisia-build sh -c '
  cd /repo && rm -rf modestly-modular-modpack-modifier
  git clone https://github.com/Maxwell-lt/modestly-modular-modpack-modifier.git modestly-modular-modpack-modifier
  git config --global --add safe.directory /repo/modestly-modular-modpack-modifier
  nix build ./modestly-modular-modpack-modifier -o /tmp/mmmm-result   # Rust build, slow first time
'
```

## 3. (curse packs only) Provide the CurseForge key

```bash
docker exec erisia-build mkdir -p /root/.config/modestly-modular-modpack-modifier
docker cp ~/.config/modestly-modular-modpack-modifier/mmmm.toml \
  erisia-build:/root/.config/modestly-modular-modpack-modifier/mmmm.toml
```

## 4. Resolve the manifest (YAML → JSON)

```bash
docker exec erisia-build sh -c 'cd /repo && \
  /tmp/mmmm-result/bin/modestly-modular-modpack-modifier-cli -o manifest manifest/<pack>.yaml'
```

Produces `manifest/<pack>.json`.

## 5. Build server mods + Forge launcher

Build the **content outputs directly** (these skip the `control` tool — see gotchas):

```bash
docker exec erisia-build sh -c 'cd /repo && \
  nix build -f . packs.<pack>.serverModsDir packs.<pack>.launcherDir -o /tmp/mil-srv'
# /tmp/mil-srv     -> server mods dir
# /tmp/mil-srv-1   -> forge/  (server install: run.sh, user_jvm_args.txt, libraries/, unix_args.txt)
```

## 6. Assemble a runnable server + boot it

```bash
docker exec erisia-build sh -c '
  nix build nixpkgs#temurin-jre-bin-17 -o /tmp/jre    # match the pack MC version: -17 (1.18–1.20.4), -21 (1.20.5/1.21+), -8 (1.12.2)
  rm -rf /tmp/srv && mkdir -p /tmp/srv/mods
  cp -rL /tmp/mil-srv-1/forge/. /tmp/srv/ && chmod -R u+w /tmp/srv   # forge install (writable)
  for j in /tmp/mil-srv/*.jar; do cp -L "$j" /tmp/srv/mods/; done
  # test props: offline + no whitelist so the boot doesn'"'"'t need auth/whitelist
  cp /repo/base/<pack>-server/server.properties /tmp/srv/server.properties 2>/dev/null
  sed -i -e "s/^online-mode=true/online-mode=false/" -e "s/^white-list=true/white-list=false/" /tmp/srv/server.properties
  echo "eula=true" > /tmp/srv/eula.txt      # local-test only; real deploy accepts EULA separately
  # apply any pack configs you want to test (defaultconfigs/, config/)
  cp -r /repo/base/<pack>/config/* /tmp/srv/config/ 2>/dev/null || true
  cp -r /repo/base/<pack>-server/defaultconfigs/* /tmp/srv/defaultconfigs/ 2>/dev/null || true
  cp -r /repo/base/<pack>/defaultconfigs/* /tmp/srv/defaultconfigs/ 2>/dev/null || true
  cd /tmp/srv && export PATH=/tmp/jre/bin:$PATH
  ARGS=$(find libraries -name unix_args.txt | head -1)
  nohup java -Xmx4G @user_jvm_args.txt @"$ARGS" nogui > /tmp/srv/boot.log 2>&1 &
'
```

Watch for success/failure:

```bash
# success: "Done (X.Xs)! For help, type help"
docker exec erisia-build sh -c 'grep -E "Done \(|Failed to start|Crash report" /tmp/srv/boot.log'
```

Stop the server (see gotcha — `pkill -f @user_jvm_args` does NOT work):

```bash
docker exec erisia-build sh -c '
  for p in /proc/[0-9]*/cmdline; do
    tr "\0" " " <"$p" 2>/dev/null | grep -aqE "forgeserver|/tmp/jre/bin/java" \
      && kill -9 $(basename $(dirname "$p")) 2>/dev/null
  done'
```

## Gotchas (hard-won)

| Problem | Cause / fix |
|---|---|
| **MMMM submodule won't clone** | `.gitmodules` uses an SSH URL → clone via **HTTPS** (step 2). |
| **MMMM: "Failed to obtain a channel for an output"** | Manifest needs a **`ModWriter`** node and output `source: 'writer::json'` — the stale `e33_5.yaml` template uses `resolver::json`. Copy `e34_5.yaml`'s tail. |
| **MMMM panics: `invalid type: null, expected a string`** | A curse mod has **API distribution disabled** (`downloadUrl: null`). Switch it to `source: url` with a forgecdn link: `https://edge.forgecdn.net/files/<id[:4]>/<int(id[4:])>/<filename>` (get filename+sha1 from CF API `/v1/mods/{id}/files/{fid}`). |
| **Build error: `attribute '"<mc>-<loader>"' missing` in launcher-lock** | `launcher-lock.json` (added by the flakify) needs an entry per loader version. Add the key with a placeholder `outputHash` (`sha256-AAAA…`), build the launcher, read the `got: sha256-…` mismatch, paste it back (fixed-output-derivation trick). |
| **`control` tool build fails: crates.io 403** | nixpkgs' `fetch-cargo-vendor` (Python `requests`) sends no User-Agent and **crates.io 403s that**. It's a latent repo issue on the pinned nixpkgs, not just the container. Workarounds: build the content targets directly (`.serverModsDir`/`.launcherDir`), build on a host where `control-0.1-vendor` is already **cached** (tsugumi, from other packs), or `nix flake update` to a nixpkgs whose fetcher sends a UA. A bare `wget` to crates.io **with** a UA works — proof it's UA, not an IP block. |
| **`pkill -f "@user_jvm_args"` doesn't kill the server** | Java **expands `@argfiles`**, so the process cmdline shows the flags, not the literal string. Match `forgeserver` / `/tmp/jre/bin/java` in `/proc/*/cmdline` instead. |
| **`bind failed: Address already in use` on re-boot** | A previous test server is still holding the port. Kill all forge procs and confirm none remain (scan `/proc/*/cmdline` for `forgeserver`) before re-booting — or check `/proc/net/tcp` for the port in uppercase hex (25566 = `63DE`). Don't delete the world out from under a running server. |
| **No `unzip`/`awk`/`pkill` in the container** | `nixos/nix` is minimal. Use `python3` (`nix run nixpkgs#python3` / zipfile), `grep`, and `/proc` parsing. |

## Verifying specific things

- **All mods load:** server reaches `Done`, no `Failed to start` / missing-dependency errors. Loot/tag
  "Couldn't parse" errors for missing items are **non-fatal** (MC skips them).
- **Side filtering:** `packs.<pack>.serverModsDir` must **exclude** client-only mods (e.g. minimap,
  rendering) and **include** server-only ones (e.g. anti-xray, mod-whitelist).
- **Custom world-type**, if the pack sets one via `server.properties` `level-type=…` + a
  `defaultconfigs/…-server.toml`: the boot log should show the generator loading and **no**
  "Unknown level type". (Example: the military pack uses `level-type=lostcities` +
  `lostcities-server.toml` `selectedProfile="customized"`.)
- **Config vs defaults:** boot once with no configs to generate `world/serverconfig/*` + `config/*`
  defaults, then diff your bundled configs against them to see what's actually customized.

## Cleanup

```bash
docker rm -f erisia-build            # container + its /nix store
# plus any large scratch downloads (pack zips, served dirs)
```
