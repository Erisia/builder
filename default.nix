with import ./nixpkgs {};
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
    e30 = buildPack e30;
    e29 = buildPack e29;
  };

  e30 = {
    name = "Create";
    tmuxName = "e30";
    description = "E30: Modus Burpium";
    ram = "12000m";
    port = 25565;
    prometheusPort = 1223;
    forge = {
      major = "1.16.5";
      minor = "36.2.20";
    };
    extraDirs = [
      ./base/erisia
      ./base/e30
    ];
    extraServerDirs = [
      ./base/server
    ];
    extraClientDirs = [
      ./base/client
    ];
    manifests = [
      ./manifest/e30.nix
    ];
    blacklist = [
    ];
  };

  e29 = {
    name = "RusticWaters";
    tmuxName = "e29";
    description = "E29: Occulai Abyssi";
    ram = "12000m";
    port = 25565;
    prometheusPort = 1223;
    forge = {
      major = "1.12.2";
      minor = "14.23.5.2855";
    };
    extraDirs = [
      ./base/erisia
      ./base/e29
      ./third_party/1.12.2
    ];
    extraServerDirs = [
      ./base/server
    ];
    extraClientDirs = [
      resources_12
      ./base/client
    ];
    manifests = [
      ./manifest/e29.nix
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
