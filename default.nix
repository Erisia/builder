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
    sv = buildPack sv;
    eln = buildPack eln;
    squishy = buildPack squishy;
  };

  squishy = eln // {
    name = "Sir_Squishalot";
    description = "Squishy: Rubber";
    tmuxName = "squishy";
    port = 25569;
    prometheusPort = 1226;
    blacklist = [
      "dynmapforge"
    ];
  };

  eln = {
    name = "ElectricalAssault";
    tmuxName = "eln";
    description = "SV: Electrical Assault";
    ram = "12000m";
    port = 25567;
    prometheusPort = 1225;
    forge = {
      major = "1.7.10";
      minor = "10.13.4.1614";
    };
    extraDirs = [
      ./base/eln
      ./base/erisia
    ];
    extraServerDirs = [
      ./base/server
    ];
    extraClientDirs = [
      resources_7
      ./base/client
    ];
    manifests = [
      ./manifest/electrical_assault.nix
    ];
    blacklist = [
    ];
  };

  sv = {
    name = "MeteoricDescent";
    tmuxName = "sv";
    description = "SV: Meteoric Descent";
    ram = "12000m";
    port = 25565;
    prometheusPort = 1224;
    forge = {
      major = "1.12.2";
      minor = "14.23.5.2847";
    };
    extraDirs = [
      ./base/sv
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
      ./manifest/meteoric_descent.nix
    ];
    blacklist = [
    ];
  };

  ServerPack = buildServerPack rec {
    inherit packs;
    hostname = "173.231.55.228";
    urlBase = "https://minecraft.sufficientvelocity.com/pack/";
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
