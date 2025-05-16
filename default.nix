with import <nixpkgs> {};
with stdenv;

with callPackage ./lib/lib.nix {};

rec {

  packs = {
    # e33 = buildPack e33;
    # e33_5 = buildPack e33_5;
    e34 = buildPack e34;
  };
  
  e34 = {
    name = "E34";
    tmuxName = "e34";
    description = "E34: Plerumque Nubila Meatballs";
    ram = "14G";
    port = 25565;
    prometheusPort = 1224;
    minecraft = "1.12.2";
    cleanroom = {
      major = "0.3.4";
      minor = "alpha";
    };
    client-forge = {
      major = "1.12.2";
      minor = "14.23.5.2860";
    };
    extraDirs = [
      ./base/e34
      ./base/erisia
    ];
    extraServerDirs = [
      ./base/e34-server
      ./base/server
    ];
    extraClientDirs = [
      ./base/e34-client
      ./base/client
    ];
    manifest = ./manifest/e34.json;
  };

  e33_5 = {
    name = "E33.5";
    tmuxName = "e335";
    description = "E33.5: Exiled Incognito";
    ram = "8G";
    port = 25566;
    prometheusPort = 1225;
    minecraft = "1.20.1";
    forge = {
      major = "1.20.1";
      minor = "47.2.18";
    };
    extraDirs = [
      ./base/e33_5
    ];
    extraServerDirs = [
      ./base/e33_5-server
      ./base/server
    ];
    extraClientDirs = [
      ./base/e33_5-client
    ];
    manifest = ./manifest/e33_5.json;
  };

  e33 = {
    name = "E33";
    tmuxName = "e33";
    description = "E33: Pars Una";
    ram = "16G";
    port = 25565;
    prometheusPort = 1224;
    minecraft = "1.20.1";
    neoforge = {
      major = "1.20.1";
      minor = "47.1.104";
    };
    extraDirs = [
      ./base/e33
      ./base/erisia
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
    hostname = "minecraft.maxwell-lt.dev";
    urlBase = "https://minecraft.maxwell-lt.dev/pack/";
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
