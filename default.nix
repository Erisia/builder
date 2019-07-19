with import <nixpkgs> {};
with stdenv;

with import ./lib/lib.nix;
with import ./lib/sprocket;

let resources_12 = runLocally "resources-1.12" {
      sphax = fetchurl {
        url = https://madoka.brage.info/baughn/Sphax64x_FTB_Revelation.zip;
        sha256 = "03jdl0y2z00gnvc18gw69jcx08qigf6fbj09ii21gikh1fg4imfi";
      };
    } ''
      mkdir -p $out/resourcepacks $out/shaderpacks
      #ln -s $seus $out/shaderpacks/SEUS-v11.0.zip
      #ln -s $faithful $out/resourcepacks/F32-1.10.2.zip
      ln -s $sphax $out/resourcepacks/Sphax.zip
    '';
   resources_10 = runLocally "resources-1.10" {
     ozocraft = fetchurl {
       url = https://madoka.brage.info/baughn/OzoCraft-1.10a.zip;
       sha256 = "07xkg39idnp99gn4v7c2nc2sc9a948h16nsan4f68h3ncyshxbgs";
     };
   } ''
     mkdir -p $out/resourcepacks
     ln -s $ozocraft $out/resourcepacks/OzoCraft.zip
   '';
   resources_7 = runLocally "resources-1.7" {
     erisia = fetchurl {
       url = https://madoka.brage.info/baughn/erisia-pack.zip;
       sha256 = "17hy9hf948xkj3wgkr1q2q8qr2cqgkvy7d0zii89vrzai9xw0aif";
     };
   } ''
     mkdir -p $out/resourcepacks
     ln -s $erisia $out/resourcepacks/erisia-pack.zip
   '';
in

rec {

  packs = {
    e22-5 = buildPack e22-5;
    elncognito = buildPack elncognito;
#    mettle = buildPack mettle;
    e23 = buildPack e23;
  };

  e23 = {
    name = "Omnifactory";
    screenName = "e23";
    description = "E23: Per Omnis Ad Nullus";
    ram = "12000m";
    port = 25523;
    prometheusPort = 1223;
    forge = {
      major = "1.12.2";
      minor = "14.23.5.2838";
    };
    extraDirs = [
      ./base/e23
      ./base/omnifactory
    ];
    extraServerDirs = [
      ./base/server
    ];
    extraClientDirs = [
      resources_12
      ./base/client
    ];
    manifests = [
      ./manifest/e23.nix
    ];
    blacklist = [
    ];
  };
  
  mettle = {
    name = "mettle";
    screenName = "mettle";
    description = "Mettle Alpha";
    ram = "12000m";
    port = 25565;
    prometheusPort = 1234;
    forge = {
      major = "1.12.2";
      minor = "14.23.5.2837";
    };
    extraDirs = [
      ./base/mettle
    ];
    extraServerDirs = [
      ./base/server
    ];
    extraClientDirs = [
      resources_12
      ./base/client
    ];
    manifests = [
      ./manifest/mettle.nix
    ];
    blacklist = [
    ];
  };

  e22-5 = {
    name = "e22.5";
    screenName = "e225";
    description = "Undiscovered: Half Episode";
    ram = "20000m";
    port = 25567;
    prometheusPort = 1237;
    forge = {
      major = "1.12.2";
      minor = "14.23.5.2836";
    };
    extraDirs = [
      ./base/undiscovered
    ];
    extraServerDirs = [
      ./base/server
      ./base/e22.5
    ];
    extraClientDirs = [
      resources_12
      ./base/client
    ];
    manifests = [
      ./manifest/e22.5.nix
    ];
    blacklist = [
    ];
  };

  elncognito = {
    name = "elncognito";
    screenName = "elncognito";
    description = "Experimental Eln pack";
    ram = "10000m";
    port = 25566;
    prometheusPort = 1235;
    forge = {
      major = "1.7.10";
      minor = "10.13.4.1614";
    };
    extraDirs = [
      ./base/elncognito
    ];
    extraServerDirs = [
      ./base/server
    ];
    extraClientDirs = [
      resources_7
      ./base/client
    ];
    manifests = [
      ./manifest/elncognito.nix
    ];
    blacklist = [
    ];
  };


  e22-leisurely = e22base // {
    screenName = "e22lei";
    port = 25567;
    prometheusPort = 1236;
    description = "Erisia #22 Take it slow server: Ovilis uniusque Pastoris coccineam";
    extraDirs = [ ./base/e22-lei ] ++ e22base.extraDirs;
  };

  e22 = e22base // {
    extraDirs = [ ./base/e22 ] ++ e22base.extraDirs;
  };

  e22base = {
    name = "erisia22";
    screenName = "e22";
    description = "Erisia #22: Ovilis uniusque Pastoris coccineam";
    ram = "20000m";
    port = 25565;
    prometheusPort = 1234;
    forge = {
      major = "1.7.10";
      minor = "10.13.4.1614";
    };
    extraDirs = [
      ./base/erisia
      ./third_party/ruins-1.12
      ./base/unabridged
    ];
    extraServerDirs = [
      ./base/server
    ];
    extraClientDirs = [
      resources_7
      ./base/client
      ./base/unabridged/oresources
      ./base/unabridged/armourersWorkshop
      ./base/unabridged/TCSchematics
    ];
    manifests = [
      ./manifest/e22.nix
    ];
    blacklist = [
    ];
  };

  e21 = {
    name = "erisia21";
    screenName = "e21";
    description = "Erisia #21: Armodulu Emmayhus";
    ram = "20000m";
    port = 25565;
    forge = {
      major = "1.12.2";
      minor = "14.23.5.2768";  # TODO: Should be able to get this from manifest.json
    };
    # These are copied to the client as well as the server.
    # Suggested use: Configs. Scripts. That sort of thing.
    # Higher entries override later ones.
    extraDirs = [
      ./base/erisia
      ./third_party/ruins-1.12
      ./base/mm2
    ];
    extraServerDirs = [
      ./base/server
    ];
    extraClientDirs = [
      resources_12
      ./base/client
    ];
    # These are all the mods we'd like to include in this pack.
    manifests = [
      ./manifest/e21.nix
    ];
    blacklist = [
      "drcyanos-lootable-bodies"
      "silents-gems"
      "silents-gems-extra-parts"
      "refined-storage-addons"
      "refined-storage"
      "rebornstorage"
      "silent-lib"
      "creeperhost-minetogether"  # Fuck that.
      "fps-reducer"  # Seems to cause a memory leak?
      "signals"  # Reduces TPS a lot. Wow this is terrible.
      "aromabackup"  # We use ZFS snapshots, so never want this.
    ];
  };

  farmingValley = {
    name = "incognito";
    screenName = "incognito";
    description = "Incognito: Farming Valley (experimental Eln pack)";
    ram = "2800m";
    port = 25566;
    forge = {
      major = "1.10.2";
      minor = "12.18.3.2511";
    };
    extraDirs = [
      ./third_party/ruins-1.12
      ./base/farmingvalley
    ];
    extraServerDirs = [
      ./base/server
    ];
    extraClientDirs = [
      resources_10
      ./base/client
    ];
    manifests = [
      ./manifest/i20.nix
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
