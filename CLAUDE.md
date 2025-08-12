# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is the Erisia server-builder repository, which contains build scripts for managing multiple Minecraft servers and modpacks using Nix.

## Key Commands

```bash
# Build and verify a pack
nix build -f . ServerPackLocal

# Build specific pack (e34_5 is currently active)
nix build -f . packs.e34_5

# Build and start a server
./update-and-start.sh

# Update manifest from YAML to JSON
nix run ./modestly-modular-modpack-modifier -- -o manifest manifest/e34_5.yaml

# Update all pack manifests
for yaml in manifest/*.yaml; do
  nix run ./modestly-modular-modpack-modifier -- -o manifest "$yaml"
done

# Clear cache for latest mod versions
nix run ./modestly-modular-modpack-modifier -- --clear-cache -o manifest manifest/e34_5.yaml

# Test client configuration locally
nix build -f . ServerPackLocal && cd result && python -m http.server

# Build and serve website
nix build -f . web && cd result && python -m http.server

# Website development server (with live reload)
cd web && ./serve.sh

# Using flake commands
nix build .#packages.x86_64-linux
```

## Architecture

### Core Structure
- `default.nix`: Main entry point defining all pack configurations
- `lib/lib.nix`: Core build functions and utilities for pack generation
- `flake.nix`: Nix flake definition for modern Nix workflows

### Pack Definitions
Each pack in `default.nix` contains:
- Basic metadata (name, description, tmuxName)
- Server configuration (port, RAM, prometheusPort)
- Minecraft/modloader versions (neoforge, forge, fabric, cleanroom)
- Directory paths for configs (extraDirs, extraServerDirs, extraClientDirs)
- Manifest reference

### Directory Structure
- `manifest/*.yaml`: Mod definitions with side filtering (edit these)
- `manifest/*.json`: Generated manifests (don't edit directly)
- `base/`: Configuration files organized by pack and side
  - `base/e34_5/`: Pack-specific configs
  - `base/e34_5-server/`: Server-only configs
  - `base/e34_5-client/`: Client-only configs
  - `base/client/`: Shared client configs
  - `base/server/`: Shared server configs
- `modestly-modular-modpack-modifier/`: Rust-based workflow processor for modpack building
- `tools/`: Helper utilities (control scripts, FTB unpacker, gallery bot)
- `web/`: Hugo-based website source

### Build System
The Nix build system creates several artifacts:
- `buildPack`: Extends pack definitions with derivations for server/client
- `ServerPack`/`ServerPackLocal`: Complete launcher packages
- Client/server mod filtering based on manifest side property
- Automatic config bundling and mod fetching

## Modpack Development Workflow

1. Edit YAML manifest in `manifest/` directory
2. Generate JSON: `nix run ./modestly-modular-modpack-modifier -- -o manifest manifest/packname.yaml`
3. Build and verify: `nix build -f . ServerPackLocal`
4. Test changes locally
5. Commit changes

For CurseForge mods, configure API access in `mmmm.toml` with either:
- `curse_api_key`: API key from console.curseforge.com
- `curse_proxy_url`: Proxy service URL

The tool creates the config file automatically at:
- Linux: `~/.config/modestly-modular-modpack-modifier/mmmm.toml`
- Windows: `%AppData%\maxwell-lt\modestly-modular-modpack-modifier\config\mmmm.toml`

## Testing Changes

When changing a manifest, verify builds with `nix build` before and after:
```bash
nix build -f . ServerPackLocal -o result-before-edit
# Do the edits
nix run ./modestly-modular-modpack-modifier -- -o manifest manifest/e34_5.yaml
nix build -f . ServerPackLocal -o result-after-edit
diff -ru result-before-edit result-after-edit
```

## Modestly Modular Modpack Modifier (MMMM)

The `modestly-modular-modpack-modifier` is a Rust-based DAG workflow processor that handles:
- Converting human-readable YAML manifests to builder-compatible JSON
- Resolving mods from CurseForge and Modrinth APIs
- Processing CurseForge pack imports
- File filtering and archive extraction
- Manifest merging and mod conflict resolution

### MMMM Workflow Nodes
- **Source nodes**: Text, List, or Mods data
- **Intermediate nodes**: ModResolver, ModWriter, FileFilter, DirectoryMerger, etc.
- **Output nodes**: Write Text or Files to filesystem

### Key MMMM Features
- Persistent caching for mod resolution performance
- Support for multiple modpack sources (Curse, Modrinth, direct URLs)
- Side-aware filtering (client/server/both)
- Conflict resolution with alphabetical precedence

## Active Packs
- `e34_5`: Current active pack (NeoForge 1.21.1)
- `e34`: Legacy pack (Minecraft 1.12.2, Cleanroom)
- `e33_5`: Previous pack (Forge 1.20.1)
- `e33`: Older pack (NeoForge 1.20.1)
