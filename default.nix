with import <nixpkgs> {};
with stdenv;

with callPackage ./lib/lib.nix {};

rec {

  packs = {
    e33 = buildPack e33;
  };
  
  e33 = {
    name = "E33";
    tmuxName = "e33";
    description = "E33: Pars Una";
    ram = "18G";
    port = 25565;
    prometheusPort = 1224;
    minecraft = "1.20.1";
    neoforge = {
      major = "1.20.1";
      minor = "47.1.104";
    };
    extraDirs = [
      ./base/e33
    ];
    extraServerDirs = [
      ./base/server
    ];
    extraClientDirs = [
      ./base/client
    ];
    manifest = ./manifest/e33.json;
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
