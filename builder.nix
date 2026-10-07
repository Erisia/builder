{ pkgs ? import <nixpkgs> {} }:

with pkgs;
with stdenv;

with callPackage ./lib/lib.nix {};

rec {

  # Fix for the vanilla RCON threading bug (save-all/save-off) on 1.12.2 specifically.
  saveThreadingFix = callPackage ./packs/e36/mods/save-threading-fix {
    launcherDir = packs.e36.launcherDir;
  };

  liveInspector = callPackage ./packs/e36/mods/live-inspector {
    launcherDir = packs.e36.launcherDir;
  };

  slimeStomach = callPackage ./packs/e36/mods/slimestomach {};

  # Runs before every launch of a Prism instance to sync it to the published pack (lib/prism.nix).
  packwizInstaller = callPackage ./vendor/packwiz-installer { };

  # Moves DankNull 1.7.91 contents into the 1.7.95+ storage tag; keep it installed after the update.
  dankNullMigrate = callPackage ./packs/e36/mods/danknull-migrate {
    launcherDir = packs.e36.launcherDir;
  };

  # The builder's own mods, as pack modules see them (`inHouseMods` in packs/*/pack.nix).
  inHouseMods = {
    inherit saveThreadingFix liveInspector slimeStomach dankNullMigrate;
  };

  inherit (callPackage ./lib/pack.nix {
    builderLib = callPackage ./lib/lib.nix {};
    inherit packwizInstaller;
  })
    evalPack buildPack;

  # Only E36 is live. Older packs were retired on 2026-10-06; see the archive/pre-2026-10 bookmark.
  # Each server is built with the ServerPack (`clientPack`, see lib/pack.nix): players need a
  # working client pack, so a broken one fails the server build. Nix is lazy and the ServerPack
  # reads only the packs' client halves, so this isn't circular.
  packs = {
    e36 = buildPack (evalPack ./packs/e36/pack.nix inHouseMods) { clientPack = ServerPack; };
  };

  # Only these packs reach players.
  publishedPacks = lib.filterAttrs (_: pack: pack.config.publish) packs;

  ServerPack = buildServerPack {
    packs = publishedPacks;
    hostname = "minecraft.brage.info";
    urlBase = "https://madoka.brage.info/pack/";
  };

  # To use:
  # (nix build -f . ServerPackLocal && cd result && python -m http.server)
  ServerPackLocal = buildServerPack rec {
    packs = publishedPacks;
    hostname = "localhost:8000";
    urlBase = "http://" + hostname + "/";
  };

  # MCUpdater Flake Repository
  # Served as a dumb-HTTP git repo, for `nix run git+https://madoka.brage.info/mcupdater-nixos`.
  # Deterministic: the hash is read at build time (not by evaluation), the commit date is fixed,
  # and the index (stat data) is dropped, so the same jar always gives the same commit.
  mcupdaterFlakeRepo = runCommand "mcupdater-flake-repo" {
    src = ./mcupdater-nixos;
    buildInputs = [ git ];
    bootstrap = "${ServerPack}/MCUpdater-Bootstrap.jar";
  } ''
    # Create git repo with flake
    cp -r $src/* .

    # Substitute the bootstrap hash
    substituteInPlace flake.nix \
      --replace-fail "@BOOTSTRAP_HASH@" "$(sha256sum "$bootstrap" | cut -d' ' -f1)"

    # Initialize git repo
    export GIT_AUTHOR_DATE="2000-01-01T00:00:00Z" GIT_COMMITTER_DATE="2000-01-01T00:00:00Z"
    git init -b master
    git config user.name "Erisia Builder"
    git config user.email "builder@madoka.brage.info"
    git add .
    git commit -m "MCUpdater flake for Erisia servers"
    git update-server-info
    rm .git/index

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
