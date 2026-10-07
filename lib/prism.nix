# A pack's Prism-native output: a packwiz index plus a small Prism instance that syncs to it.
#
# Produces: a directory with `pack/` (pack.toml, index.toml, mods/*.pw.toml and the client's config
#   files) and `<name>.zip`, the instance players import. lib/make_packwiz.py does the work and
#   documents the format choices.
# Inputs: the pack's client mods and client tree (lib/pack.nix), the URL the directory is served
#   from, and packwizInstaller (vendor/packwiz-installer), which goes into the instance zip.
# Consumers: lib/pack.nix (`prism`); lib/lib.nix's buildServerPack publishes it as prism/<id>/.
{ pkgs, packwizInstaller }:
{
  name,
  minecraft,
  forge,
  mods,
  tree,
  preserve,
  baseUrl,
  icon,
}:
let
  inherit (pkgs) lib;
in
pkgs.runCommand "${name}-prism"
  {
    modsJSON = builtins.toJSON mods;
    passAsFile = [ "modsJSON" ];
    nativeBuildInputs = [ pkgs.python3 ];
  }
  ''
    python3 ${./make_packwiz.py} \
      --name ${lib.escapeShellArg name} \
      --minecraft ${lib.escapeShellArg minecraft} \
      --forge ${lib.escapeShellArg forge} \
      --mods "$modsJSONPath" \
      --tree ${tree} \
      ${lib.concatMapStringsSep " " (path: "--preserve ${lib.escapeShellArg path}") preserve} \
      --base-url ${lib.escapeShellArg baseUrl} \
      --installer ${packwizInstaller}/share/java/packwiz-installer.jar \
      --icon ${icon} \
      --out "$out"
  ''
