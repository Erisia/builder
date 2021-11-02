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
   resources_enigmatica6 = runLocally "resources_enigmatica6" {
     e6 = fetchurl {
        url = "https://media.forgecdn.net/files/3248/894/ERP-V1.8.zip";
        sha256 = "1vb8vzm145ng8l58vsqz302anhgqyr0r3392bky57mbyn3mfxkgy";
     };
   } ''
      mkdir -p $out/resourcepacks
      ln -s $e6 $out/resourcepacks/ERP-V1.8.zip
   '';
   sprocket = callPackage ./lib/sprocket {};
in

rec {

  packs = {
    e28 = buildPack e28;
    e27 = buildPack e27;
  };

  e28 = {
    name = "Enigmatica 6";
    tmuxName = "e28";
    description = "E28: Latin Name Goes Here";
    ram = "18G";
    port = 25566;
    prometheusPort = 1223;
    forge = {
      major = "1.16.5";
      minor = "36.1.32";
    };
    extraDirs = [
      ./base/enigmatica6
      ./base/erisia
    ];
    extraServerDirs = [
      ./base/server
    ];
    extraClientDirs = [
      resources_enigmatica6
      ./base/client
    ];
    manifests = [
      ./manifest/e28.nix
    ];
    blacklist = [
    ];
  };

  e27 = {
    name = "MCEternal";
    tmuxName = "e27";
    description = "E27: Perfodio Fabrico Aeternum";
    ram = "12000m";
    port = 25566;
    prometheusPort = 1223;
    forge = {
      major = "1.12.2";
      minor = "14.23.5.2855";
    };
    extraDirs = [
      ./base/mc-eternal
      ./base/erisia
    ];
    extraServerDirs = [
      ./base/server
    ];
    extraClientDirs = [
      resources_12
      ./base/client
    ];
    manifests = [
      ./manifest/e27.nix
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
