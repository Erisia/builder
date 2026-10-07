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
  dirs = {
    common = [
      ../../base/e36
      ../../base/e36-third-party
    ];
    server = [
      ../../runtime
      inHouseMods.saveThreadingFix
      inHouseMods.liveInspector
      inHouseMods.slimeStomach
      inHouseMods.dankNullMigrate
      ../../base/e36-minebuild-server
    ];
    client = [ ../../base/e36-client ];
  };
}
