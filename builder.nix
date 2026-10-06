{ pkgs ? import <nixpkgs> {} }:

with pkgs;
with stdenv;

with callPackage ./lib/lib.nix {};

rec {

  # Fix for the vanilla RCON threading bug (save-all/save-off) on 1.12.2 specifically.
  saveThreadingFix = callPackage ./mods/save-threading-fix {
    launcherDir = packs.e36.launcherDir;
  };

  liveInspector = callPackage ./mods/live-inspector {
    launcherDir = packs.e36.launcherDir;
  };

  slimeStomach = callPackage ./mods/slimestomach {};

  # Moves DankNull 1.7.91 contents into the 1.7.95+ storage tag; keep it installed after the update.
  dankNullMigrate = callPackage ./mods/danknull-migrate {
    launcherDir = packs.e36.launcherDir;
  };

  # Only E36 is live. Older packs were retired on 2026-10-06; see the archive/pre-2026-10 bookmark.
  packs = {
    e36 = buildPack e36;
  };

  e36 = {
    name = "E36";
    tmuxName = "e36";
    description = "E36: Calculus difficilis est";
    ram = "8G";
    port = 25565;
    prometheusPort = 1224;
    minecraft = "1.12.2";
    cleanroom = {
      major = "0.6.12";
      minor = "alpha";
    };
    client-forge = {
      major = "1.12.2";
      minor = "14.23.5.2864";
    };
    #forge = {
    #  major = "1.12.2";
    #  minor = "14.23.5.2864";
    #};
    extraDirs = [
      ./base/e36
      ./base/e36-third-party
    ];
    extraServerDirs = [
      ./base/server
      saveThreadingFix
      liveInspector
      slimeStomach
      dankNullMigrate
      ./base/e36-minebuild-server
    ];
    extraClientDirs = [
      ./base/e36-client
    ];
    manifest = ./manifest/e36.json;
  };

  ServerPack = buildServerPack {
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

  # MCUpdater Flake Repository
  mcupdaterFlakeRepo = runCommand "mcupdater-flake-repo" {
    src = ./mcupdater-nixos;
    buildInputs = [ git ];
    bootstrapHash = builtins.hashFile "sha256" "${ServerPack}/MCUpdater-Bootstrap.jar";
  } ''
    # Create git repo with flake
    cp -r $src/* .
    
    # Substitute the bootstrap hash
    substituteInPlace flake.nix \
      --replace-fail "@BOOTSTRAP_HASH@" "$bootstrapHash"
    
    # Initialize git repo
    git init -b master
    git config user.name "Erisia Builder"
    git config user.email "builder@madoka.brage.info"
    git add .
    git commit -m "MCUpdater flake for Erisia servers"
    git update-server-info

    mv .git $out
  '';

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
    
    # Add mcupdater flake repo
    ln -s ${mcupdaterFlakeRepo} $out/mcupdater-nixos
  '';
}
