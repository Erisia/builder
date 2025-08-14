with import <nixpkgs> {};
with stdenv;

with callPackage ./lib/lib.nix {};

rec {

  packs = {
    # e33 = buildPack e33;
    # e33_5 = buildPack e33_5;
    # e34 = buildPack e34;
    e34_5 = buildPack e34_5;
    e35 = buildPack e35;
  };

  e35 = {
    name = "E35";
    tmuxName = "e35";
    description = "E35: Per fragore ad astra";
    ram = "8G";
    port = 25565;
    prometheusPort = 1224;
    minecraft = "1.18.2";
    fabric = {
      loader = "0.16.3";
      installer = "1.1.0";
      yarnBuild = "build.4";
    };
    extraDirs = [
      ./base/e35
    ];
    extraServerDirs = [
      ./base/e35-server
      ./base/server
    ];
    extraClientDirs = [
      ./base/e35-client
      ./base/client
    ];
    manifest = ./manifest/e35.json;
  };

  e34_5 = {
    name = "E34.5";
    tmuxName = "e345";
    description = "E34.5: Mare Incognitus";
    ram = "8G";
    port = 25566;
    prometheusPort = 1224;
    minecraft = "1.21.1";
    neoforge = {
      major =  "21.1.122";
      minor = "21.1.122";
    };
    extraDirs = [
      ./base/e34_5
    ];
    extraServerDirs = [
      ./base/e34_5-server
      ./base/server
    ];
    manifest = ./manifest/e34_5.json;
  };
  
  e34 = {
    name = "E34";
    tmuxName = "e34";
    description = "E34: Plerumque Nubila Meatballs";
    ram = "12G";
    port = 25565;
    prometheusPort = 1224;
    minecraft = "1.12.2";
    cleanroom = {
      major = "0.2.3";
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
    hostname = "minecraft.brage.info";
    urlBase = "https://madoka.brage.info/pack/";
  };

  # To use:
  # (nix build -f . ServerPackLocal && cd result && python -m http.server)
  ServerPackLocal = buildServerPack rec {
    inherit packs;
    hostname = "localhost:8000";
    urlBase = "http://" + hostname + "/";
  };

  ServerPackE35 = buildServerPack rec {
    inherit packs;
    hostname = "madoka.brage.info";
    urlBase = "https://madoka.brage.info/e35/result/";
  };


  # Website
  web = runCommand "erisia-website-hugo" {
    src = builtins.filterSource
      (path: type: type != "symlink")
      ./web;
    buildInputs = [ hugo ];
  } ''
    # Create temp directory for Hugo to build in
    TEMP_DIR=$(mktemp -d)
    cp -r $src/* $TEMP_DIR/
    cd $TEMP_DIR
    
    # Build without lock file
    hugo --minify --destination $out --ignoreCache
  '';
}
