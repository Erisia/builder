with import <nixpkgs> {};
with stdenv;

with callPackage ./lib/lib.nix {};

rec {

  packs = {
    e32 = buildPack e32;
  };

  e32 = {
    name = "E32";
    tmuxName = "e32";
    description = "E32: Coloni Catan";
    ram = "18G";
    port = 25565;
    prometheusPort = 1224;
    minecraft = "1.19.2";
    fabric = {
      loader = "0.14.22";
      installer = "0.11.2";
      yarnBuild = "build.28";
    };
    extraDirs = [
      ./base/e32
    ];
    extraServerDirs = [
      ./base/server
    ];
    extraClientDirs = [
      ./base/client
    ];
    manifest = ./manifest/e32.json;
  };

  ServerPack = buildServerPack rec {
    inherit packs;
    hostname = "madoka.brage.info";
    urlBase = "https://madoka.brage.info/pack/";
  };

  # To use:
  # (nix build -f . ServerPackLocal && cd result && python -m http.server)
  ServerPackLocal = buildServerPack rec {
    inherit packs;
    hostname = "localhost:8000";
    urlBase = "http://" + hostname + "/";
  };

  web = callPackage ./web {};
}
