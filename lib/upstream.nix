# A pack's upstream CurseForge modpack, fetched by hash, with the pack's overlay laid on top.
#
# Produces: one derivation with two outputs: `out`, the tree both sides get, and `client`, the
#   tree only clients get (the upstream directories in `clientOnly`, plus overlay/client).
#   lib/unpack_upstream.py does the work and documents the checks it makes.
# Inputs: the pack's `upstream` option (lib/pack-module.nix).
# Consumers: lib/pack.nix, which puts the outputs in front of `dirs.common` and `dirs.client`.
{ pkgs }:
{ name, upstream }:
let
  inherit (pkgs) lib;

  zip = pkgs.fetchurl {
    inherit (upstream) urls hash;
    # The CurseForge URL's last part is percent-encoded; give the store path a plain name.
    name = "${name}-upstream.zip";
  };

  # An empty overlay for packs that don't have one, so the script always gets a directory.
  overlayDir = if upstream.overlay == null then pkgs.emptyDirectory else upstream.overlay;
in
pkgs.runCommand "${name}-upstream"
  {
    outputs = [
      "out"
      "client"
    ];
    nativeBuildInputs = [ pkgs.python3 ];
  }
  ''
    python3 ${./unpack_upstream.py} \
      --zip ${zip} \
      --removed ${upstream.removed} \
      --overlay ${overlayDir} \
      ${
        lib.concatMapStringsSep " " (dir: "--client-only ${lib.escapeShellArg dir}") upstream.clientOnly
      } \
      ${
        lib.concatMapStringsSep " " (
          suffix: "--text-suffix ${lib.escapeShellArg suffix}"
        ) upstream.textSuffixes
      } \
      --common "$out" \
      --client "$client"
  ''
