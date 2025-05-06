# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is the Erisia server-builder repository, which contains build scripts for managing multiple Minecraft servers and modpacks using Nix.

## Key Commands

```bash
# Build and verify a pack
nix build -f . ServerPackLocal

# Build and start a server
./update-and-start.sh

# Update manifest from YAML to JSON
nix run ./modestly-modular-modpack-modifier -- -o manifest manifest/e34_5.yaml

# Clear cache for latest mod versions
nix run ./modestly-modular-modpack-modifier -- --clear-cache -o manifest manifest/e34_5.yaml

# Test client configuration locally
nix build -f . ServerPackLocal && cd result && python -m http.server
```

## Architecture

- `manifest/*.yaml`: Mod definitions (edit these)
- `manifest/*.json`: Generated manifests (don't edit directly)
- `default.nix`: Pack definitions
- `lib/lib.nix`: Build functions
- `base/`: Config files for servers/clients
- `modestly-modular-modpack-modifier/`: Tool for manifest conversion

Modpack update workflow:
1. Edit YAML manifest
2. Generate JSON
3. Build and verify
4. Commit changes

For CurseForge mods, configure API access in `mmmm.toml` with either:
- `curse_api_key`: API key from console.curseforge.com
- `curse_proxy_url`: Proxy service URL

When changing a manifest, verify builds with `nix build` before and after, comparing the outputs.
1. nix build -f . ServerPackLocal -o result-before-edit
2. Do the edits
3. nix build -f . ServerPackLocal -o result-after-edit
4. diff -ru before after
