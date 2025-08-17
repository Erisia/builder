# Erisia MCUpdater for NixOS

This flake provides a NixOS-friendly way to run MCUpdater for the Erisia Minecraft servers without needing `steam-run`.

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

This flake provides:
- Java 17 runtime
- All necessary graphics libraries for JavaFX
- Proper X11 integration for NixOS
- Audio support via ALSA
- Font rendering support
- Pre-configured MCUpdater bootstrap for Erisia servers

## Updating

The flake is automatically updated when Erisia deploys new server configurations. Simply update your flake inputs:

```bash
nix flake update
```

The bootstrap hash is automatically calculated during the build process, so no manual hash updates are needed.

## Troubleshooting

If you encounter issues:

1. **Java/Graphics Issues**: This flake includes all necessary graphics libraries. If you still have issues, ensure your NixOS has OpenGL support enabled.

2. **Network Issues**: Make sure you can access `https://madoka.brage.info` from your network.

3. **Hash Mismatch**: If you get a hash mismatch error, run `nix flake update` to get the latest version with the correct hash.

## Contributing

This flake is part of the Erisia server builder repository. Submit issues or pull requests there.