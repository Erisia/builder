with import <nixpkgs> {};
with stdenv;

with import ./lib/lib.nix;
with import ./lib/sprocket;

let protonPack = unpackZip "proton-packfile" manifest/Proton-1.0.9.zip {};
    sf3Pack = unpackZip "sf3-packfile" manifest/Skyfactory-3.0.8.zip {
      exclude = ["overrides/mods/foamfix-0.5.3-anarchy.jar"];
    };
    resources = runLocally "resources-1.10" {
      soartex = fetchurl {
        url = http://dl.soartex.net/esuzx;
        sha256 = "065wd07pjmk37m4399jl9i1rx3yqn3v6ggg0iran1xn7nvvcn0cq";
      };
      seus = fetchurl {
        url = https://madoka.brage.info/baughn/SEUS-v11.0.zip;
        sha256 = "0mlasvmfvcbf9krl7r20h2gw0q34ws48gavpiiic6x66ngikilh3";
      };
    } ''
      mkdir -p $out/resourcepacks $out/shaderpacks
      cp $soartex $out/resourcepacks/Soartex.zip
      cp $seus $out/shaderpacks/SEUS-v11.0.zip
    '';
in

rec {

  packs = {
    erisia-16 = buildPack sf3;
    proton = buildPack proton;
  };

  sf3 = {
    name = "SkyFactory-3";
    description = "Erisia #16: Ad Mundum";
    screenName = "e16";
    port = 25565;
    forge = {
      major = "1.10.2";
      minor = "12.18.3.2239";
    };
    # These are copied to the client as well as the server.
    # Suggested use: Configs. Scripts. That sort of thing.
    extraDirs = [
      "${sf3Pack}/overrides"
      ./base-sf3
      resources
      # (generateCustomOreGenConfig ./COGConfig)
    ];
    # Server only.
    extraServerDirs = [
      ./base-server
    ];
    # These are all the mods we'd like to include in this pack.
    # (Not yet, they're not.)
    manifests = [
      ./manifest/Skyfactory-3.0.8.nix
      ./manifest/tools.nix
      ./manifest/Skyfactory-extras.nix
    ];
    # Not all mods are equally welcome.
    blacklist = [
      # Conflicts with HWYLA.
      "waila"
      # Already exists in Proton.
      # "fullscreen-windowed-borderless-for-minecraft"
    ];
  };

  proton = {
    name = "proton";
    screenName = "proton";
    port = 25567;
    forge = {
      major = "1.10.2";
      minor = "12.18.3.2239";
    };
    extraDirs = [
      "${protonPack}/overrides"
      ./base-proton
    ];
    extraServerDirs = [
      ./base-server
    ];
    manifests = [
      ./manifest/Proton-1.0.9.nix
      ./manifest/tools.nix
    ];
    blacklist = [
      # Already exists in Proton.
      "fullscreen-windowed-borderless-for-minecraft"
    ];
  };

  ServerPack = buildServerPack rec {
    inherit packs;
    hostname = "madoka.brage.info";
    urlBase = "https://" + hostname + "/pack/";
  };

  # To use:
  # nix-build -A ServerPackLocal && (cd result && python -m SimpleHTTPServer)
  ServerPackLocal = buildServerPack rec {
    inherit packs;
    hostname = "localhost:8000";
    urlBase = "http://" + hostname + "/";
  };

  web = callPackage ./web {};
}
