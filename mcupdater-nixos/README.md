# Erisia MCUpdater for NixOS

This flake provides a NixOS-friendly way to run MCUpdater for the Erisia Minecraft servers using an FHS environment that allows MCUpdater to download and run Minecraft properly.

## Quick Start

```bash
# Run MCUpdater directly from Erisia's server
nix run git+https://madoka.brage.info/mcupdater-nixos

# Or clone and run locally
git clone https://madoka.brage.info/mcupdater-nixos
cd mcupdater-nixos
nix run .
```

## Installation

### Add to your system flake

Add this to your `flake.nix` inputs:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    erisia-mcupdater = {
      url = "git+https://madoka.brage.info/mcupdater-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, erisia-mcupdater }: {
    # Add to your system packages or home-manager
    nixosConfigurations.yourhost = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
          environment.systemPackages = [
            erisia-mcupdater.packages.x86_64-linux.mcupdater
          ];
        }
      ];
    };
  };
}
```

### Or install to your profile

```bash
nix profile install git+https://madoka.brage.info/mcupdater-nixos
```

Then run with `erisia-mcupdater`.

## Usage

The MCUpdater will start with the Erisia server pack already configured. Simply:

1. Run the command above
2. MCUpdater will open with the Erisia servers available
3. Select your preferred server pack (e.g., E34.5, E35)
4. Click install and launch

## What's Included

This flake provides an FHS (Filesystem Hierarchy Standard) environment with:
- Java 17 runtime
- All necessary graphics libraries for JavaFX and OpenGL
- Proper X11 and Wayland integration for NixOS
- Audio support via ALSA and PulseAudio
- Font rendering support
- Network tools (curl, wget) for downloading mods and Minecraft
- Archive tools (zip, unzip) for mod processing
- 32-bit library support for Minecraft compatibility
- Pre-configured MCUpdater bootstrap for Erisia servers
- Writable data directory for MCUpdater and Minecraft files

## Updating

The flake is automatically updated when Erisia deploys new server configurations. Simply update your flake inputs:

```bash
nix flake update
```

The bootstrap hash is automatically calculated during the build process, so no manual hash updates are needed.

## Troubleshooting

If you encounter issues:

1. **Java/Graphics Issues**: This flake uses an FHS environment with all necessary graphics libraries. If you still have issues, ensure your NixOS has OpenGL support enabled and your user is in the appropriate groups for graphics access.

2. **Network Issues**: Make sure you can access `https://madoka.brage.info` from your network. The FHS environment includes network tools for downloading Minecraft and mods.

3. **Hash Mismatch**: If you get a hash mismatch error, run `nix flake update` to get the latest version with the correct hash.

4. **File Permission Issues**: MCUpdater will create files in `~/.local/share/mcupdater` by default. Ensure this directory is writable.

5. **Minecraft Download Issues**: The FHS environment should provide all necessary tools and libraries for Minecraft downloads, but ensure you have a stable internet connection.

## Contributing

This flake is part of the Erisia server builder repository. Submit issues or pull requests there.