# Local test pack for `military` only, served at http://localhost:8000/.
# Skips the `server` derivation (control tool) so it builds without crates.io.
let
  pkgs = import <nixpkgs> {};
  lib = pkgs.callPackage ./lib/lib.nix {};
  builder = import ./builder.nix { inherit pkgs; };
in
  lib.buildServerPack {
    packs = { military = builtins.removeAttrs builder.packs.military [ "server" ]; };
    hostname = "localhost:8000";
    urlBase = "http://localhost:8000/";
  }
