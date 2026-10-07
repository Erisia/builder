# E36, "Calculus difficilis est": Erisia's live pack, based on Infinity Beyond Plus (IBP).
# The options are declared, with their documentation, in lib/pack-module.nix.
{ pkgs, inHouseMods, ... }:
{
  name = "E36";
  description = "E36: Calculus difficilis est";
  ram = "8G";
  port = 25565;
  prometheusPort = 1224;

  minecraft = "1.12.2";
  loader = {
    type = "cleanroom";
    major = "0.6.12";
    minor = "alpha";
  };
  # MCUpdater clients run Forge; only the server runs Cleanroom.
  clientForge = {
    major = "1.12.2";
    minor = "14.23.5.2864";
  };
  # start.py runs Cleanroom on Java 25; this pins which build.
  java = pkgs.jdk25;

  manifest = ../../manifest/e36.json;
  # IBP's configs and scripts, with Erisia's changes in ./overlay.
  upstream = {
    urls = [
      "https://madoka.brage.info/upstream/IBP-Dev-2.0.13.zip"
      "https://mediafilez.forgecdn.net/files/3067/178/IBP%20Dev-2.0.13.zip"
    ];
    hash = "sha256-lFW+VUHhuDPUwhRLcdmRzPUPSTSnC3CXahWZtrIZcFg=";
    removed = ./overlay/removed.txt;
    clientOnly = [
      "resources"
      "schematics"
    ];
    # What E36 had already converted to LF. Other files (.ini, .rcst, .csv, ...) keep IBP's bytes.
    textSuffixes = [
      ".cfg"
      ".conf"
      ".config"
      ".js"
      ".json"
      ".lang"
      ".mcmeta"
      ".old"
      ".properties"
      ".tml"
      ".txt"
      ".zs"
    ];
    overlay = ./overlay;
  };
  # Prism players run Cleanroom natively, so they don't need the relauncher MCUpdater's Forge clients use.
  prism.excludeMods = [ "improved-cleanroom-relauncher" ];
  dirs.server = [
    ../../runtime
    inHouseMods.saveThreadingFix
    inHouseMods.liveInspector
    inHouseMods.slimeStomach
    inHouseMods.dankNullMigrate
  ];
}
