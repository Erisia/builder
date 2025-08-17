# Erisia MCUpdater for NixOS

This flake provides a NixOS-friendly way to run MCUpdater for the Erisia Minecraft servers without needing `steam-run`.

## Quick Start

```bash
# Run MCUpdater directly
nix run github:path/to/this/flake

# Or if you have this flake locally
nix run .
```

## Installation

To install permanently:

```bash
# Clone this repository
git clone <this-repo-url>
cd mcupdater-nixos

# Install to your profile
nix profile install .

# Then run with
erisia-mcupdater
```

## Usage

The MCUpdater will start with the Erisia server pack already configured. Simply:

1. Run the command above
2. MCUpdater will open with the Erisia servers available
3. Select your preferred server pack (e.g., E34.5, E35)
4. Click install and launch

## What's Included

This flake provides:
- Java 17 runtime
- All necessary graphics libraries for JavaFX
- Proper X11 integration for NixOS
- Audio support via ALSA
- Font rendering support
- Pre-configured MCUpdater bootstrap for Erisia servers

## Updating

When the Erisia server updates their MCUpdater bootstrap, you'll need to update the hash in `flake.nix`:

```bash
nix-prefetch-url https://madoka.brage.info/pack/MCUpdater-Bootstrap.jar
```

Then replace the `sha256` value in the flake.

## Troubleshooting

If you encounter issues:

1. **Java/Graphics Issues**: This flake includes all necessary graphics libraries. If you still have issues, ensure your NixOS has OpenGL support enabled.

2. **Network Issues**: Make sure you can access `https://madoka.brage.info` from your network.

3. **Hash Mismatch**: If you get a hash mismatch error, the server's bootstrap has been updated. Use `nix-prefetch-url` as shown above to get the new hash.

## Contributing

This flake is part of the Erisia server builder repository. Submit issues or pull requests there.