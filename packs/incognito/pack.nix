# incognito: a small MC 26.3 playtest pack around the Electrical Age port and Stasis Delvers.
# The options are declared, with their documentation, in lib/pack-module.nix.
{ pkgs, ... }:
{
  name = "Incognito";
  description = "Incognito: Electrical Age playtest (MC 26.3)";
  ram = "8G";
  port = 25566;
  # Nothing exports metrics yet (E36's Prometheus integration is a 1.12 mod); reserved.
  prometheusPort = 1225;

  minecraft = "26.3";
  loader = {
    type = "neoforge";
    major = "26.3";
    minor = "26.3.0.95";
  };
  java = pkgs.jdk25;

  # MCUpdater can't install NeoForge 26.x: players use the Prism instance.
  mcupdater = false;
  # Published (Prism only) so Baughn can look; testers get the link once it has passed a join test.
  publish = true;

  manifest = ../../manifest/incognito.json;
  # config/fml.toml with NeoForge's early loading window off: it crashes Wayland + NVIDIA clients.
  dirs.client = [ ./client ];
  dirs.server = [
    ./server
    ../../runtime
  ];
}
