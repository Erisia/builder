# Legacy entry point, for `nix-build -f .`, `nix-build . -A …` and `nix-instantiate`.
#
# It evaluates builder.nix with the nixpkgs revision pinned in flake.lock, not `<nixpkgs>`. So
# `nix-build -A packs.e36.server` and `nix build .#e36-server` give the same store path.
#
# This must stay a plain attribute set, not a function: update-and-start.sh reads
# `(import "$GITDIR").packs` to offer its pack menu.
# flake.lock pins nixpkgs as a `github` input; this reads only that form.
let
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  inherit (lock.nodes.${lock.nodes.${lock.root}.inputs.nixpkgs}) locked;
  nixpkgs = fetchTarball {
    url = "https://github.com/${locked.owner}/${locked.repo}/archive/${locked.rev}.tar.gz";
    sha256 = locked.narHash;
  };
  # Same arguments as the flake's nixpkgs.legacyPackages: no user config, no overlays.
  pkgs = import nixpkgs {
    system = "x86_64-linux";
    config = { };
    overlays = [ ];
  };
in
import ./builder.nix { inherit pkgs; }
