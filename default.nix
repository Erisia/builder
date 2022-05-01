with import <nixpkgs> {};
with stdenv;

with callPackage ./lib/lib.nix {};

let resources_12 = runLocally "resources-1.12" {
    } ''
      mkdir -p $out/resourcepacks $out/shaderpacks
      #ln -s $seus $out/shaderpacks/SEUS-v11.0.zip
      #ln -s $faithful $out/resourcepacks/F32-1.10.2.zip
      #ln -s $sphax $out/resourcepacks/Sphax.zip
    '';
   resources_10 = runLocally "resources-1.10" {
   } ''
     mkdir -p $out/resourcepacks
     #ln -s $ozocraft $out/resourcepacks/OzoCraft.zip
   '';
   resources_7 = runLocally "resources-1.7" {
   } ''
     mkdir -p $out/resourcepacks
     #ln -s $erisia $out/resourcepacks/erisia-pack.zip
   '';
   sprocket = callPackage ./lib/sprocket {};
in

rec {

  packs = {
      e31 = buildPack e31;
      v18 = buildPack v18;
  };

  e31 = {
    name ="All of Fabric 5";
    tmuxName = "e31";
    description = "e31: Packname TBD";
    ram = "4G";
    port = 25566;
    prometheusPort = 1224;
    minecraftVersion = "1.18.1";
    fabric = "0.10.2";
    extraDirs = [
    ];
    extraServerDirs = [
      ./base/server
    ];
    extraClientDirs = [
      ./base/client
    ];
    manifests = [
      ./manifest/all_of_fabric_5.nix
    ];
    blacklist = [
    ];
  };


  v18 = {
    name ="Vanilla 1.18";
    tmuxName = "v18";
    description = "V18: Errata Worldheightitus";
    ram = "4G";
    port = 25566;
    minecraftVersion = "1.18.1";
    prometheusPort = 1224;
    forge = "39.0.8";
    extraDirs = [
      ./base/erisia
    ];
    extraServerDirs = [
      ./base/server
    ];
    extraClientDirs = [
      ./base/client
    ];
    manifests = [
      ./manifest/v18.nix
    ];
    blacklist = [
    ];
  };

  ServerPack = buildServerPack rec {
    inherit packs;
    hostname = "madoka.brage.info";
    urlBase = "https://madoka.brage.info/pack/";
  };

  # To use:
  # (nix build -f . ServerPackLocal && cd result && python -m SimpleHTTPServer)
  ServerPackLocal = buildServerPack rec {
    inherit packs;
    hostname = "localhost:8000";
    urlBase = "http://" + hostname + "/";
  };

  web = callPackage ./web {};
}
