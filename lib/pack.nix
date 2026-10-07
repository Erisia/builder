# Turns a pack definition (packs/<pack>/pack.nix) into its derivations.
#
# Produces:
#   evalPack:  module, inHouseMods -> the pack's checked option values (see lib/pack-module.nix).
#   buildPack: config, { clientPack } -> `config` (the values, unchanged) and the pack's derivations:
#     client            what a client receives, as plain data with no server references. The
#                       ServerPack is built from these alone, so server-only changes never reach players.
#     server            the complete server; start.py sits at its root.
#     launcherDir       the server's loader (Forge or Cleanroom), in `forge/`.
#     clientMods, serverMods            the manifest entries for each side.
#     clientModsDir, serverModsDir      each side's mods directory.
#     clientConfigDir   the client's combined config tree. Top-level files move into `base/`.
#     clientConfigsDir  one <dir>.zip (+ .md5, .size) per top-level dir of clientConfigDir.
#     clientTree        the client's files besides the manifest mods, before `base/` is split off.
#     prism             baseUrl -> the Prism-native pack served there (lib/prism.nix).
# Inputs: pkgs and inHouseMods, which pack modules may use as arguments; builderLib (lib/lib.nix) for fetching mods and loaders and for zipping configs;
#   packwizInstaller (vendor/packwiz-installer) for the Prism instance.
# Consumers: builder.nix. The flake exports the fields above as `<pack>-<field>`, update-and-start.sh
#   builds `<pack>-server`, golden.nix and the lab read them too. Keep the names.
{
  pkgs,
  lib,
  symlinkJoin,
  callPackage,
  lndir,
  builderLib,
  packwizInstaller,
}:
let
  inherit (builderLib)
    filterManifest
    fetchMods
    fetchForge
    fetchCleanroom
    mkZipDirs
    runLocally
    wrapDir
    ;
in
{
  evalPack =
    module: inHouseMods:
    (lib.evalModules {
      modules = [
        ./pack-module.nix
        module
        { _module.args = { inherit pkgs inHouseMods; }; }
      ];
    }).config;

  buildPack =
    cfg:
    {
      # The ServerPack that publishes this pack's client. When set, the server build depends on
      # it, so the server can't be built (or restarted) while the client pack is broken: running
      # a server players can't join, or serving them a stale pack, is worse than failing loudly.
      # Its path is recorded in the server's `serverpack` file. It's an argument rather than an
      # option because the ServerPack is built from every published pack, not from this one.
      clientPack ? null,
    }:
    rec {
      # The evaluated options, for callers that need them (e.g. `publish`).
      config = cfg;

      # The upstream pack with its overlay applied (lib/upstream.nix), or null.
      upstream =
        if cfg.upstream == null then
          null
        else
          import ./upstream.nix { inherit pkgs; } { inherit (cfg) name upstream; };

      # Each side's directories, first wins: the pack's `dirs`, then upstream and its overlay.
      dirs =
        let
          overlay = if cfg.upstream == null then null else cfg.upstream.overlay;
          overlayServer = overlay + "/server";
        in
        {
          common = cfg.dirs.common ++ lib.optional (upstream != null) upstream.out;
          client = cfg.dirs.client ++ lib.optional (upstream != null) upstream.client;
          server =
            cfg.dirs.server
            ++ lib.optional (overlay != null && builtins.pathExists overlayServer) overlayServer;
        };

      ## Client

      clientMods = filterManifest {
        side = "client";
        inherit (cfg) manifest;
      };

      clientModsDir = fetchMods clientMods;

      # The client's files besides the manifest mods. symlinkJoin keeps the first file it sees, so
      # `client` overrides `common`.
      clientTree = symlinkJoin {
        name = "${cfg.name}-client-config";
        paths = dirs.client ++ dirs.common;
      };

      clientConfigDir =
        runLocally "${cfg.name}-client-config-debased"
          {
            buildInputs = [ lndir ];
            base = clientTree;
          }
          ''
            mkdir $out; cd $out
            lndir $base .
            mkdir base
            find -L . -maxdepth 1 -type f -exec mv {} base/ \;
          '';

      clientConfigsDir = mkZipDirs "${cfg.name}-client-configs" clientConfigDir;

      # The Forge clients run (MCUpdater and Prism), also when the server runs Cleanroom.
      clientForge =
        if cfg.clientForge != null then
          cfg.clientForge
        else if cfg.loader.type == "forge" then
          cfg.loader
        else
          throw "${cfg.name}: a Cleanroom server needs `clientForge`, the Forge version its clients run";

      # What MCUpdater installs.
      clientLoader = {
        type = "Forge";
        version = "${clientForge.major}-${clientForge.minor}";
        # Forge 1.12.2 starts through launchwrapper.
        mainClass = "net.minecraft.launchwrapper.Launch";
      };

      client = {
        inherit (cfg) description minecraft port;
        loader = clientLoader;
        mods = clientMods;
        modsDir = clientModsDir;
        configsDir = clientConfigsDir;
      };

      # The Prism-native pack (lib/prism.nix), for the URL it's served from. A function, because
      # that URL belongs to the ServerPack that publishes it (lib/lib.nix, buildServerPack).
      prism =
        baseUrl:
        import ./prism.nix { inherit pkgs packwizInstaller; } {
          inherit (cfg) name minecraft;
          inherit (cfg.prism) preserve;
          inherit baseUrl;
          forge = clientForge.minor;
          mods = clientMods;
          tree = clientTree;
          icon = ../web/static/img/logo.png;
        };

      ## Server

      # Cleanroom installs the same layout as Forge, so both go in `forge/`.
      launcherDir = wrapDir "forge" (
        (if cfg.loader.type == "cleanroom" then fetchCleanroom else fetchForge) {
          inherit (cfg.loader) major minor;
        }
      );

      serverMods = filterManifest {
        side = "server";
        inherit (cfg) manifest;
      };

      serverModsDir = fetchMods serverMods;

      server = symlinkJoin {
        name = cfg.name + "-server";

        # Only these attributes become environment variables, and substituteAll below replaces
        # every `@var@` it has a variable for. Keep this set exact.
        inherit (cfg)
          ram
          serverName
          port
          prometheusPort
          rconPort
          ;

        # First wins: the loader, the mods, the control tool and pack-docs, then the JDK, then `server` over `common`.
        paths = [
          launcherDir
          (wrapDir "mods" serverModsDir)
          (callPackage ../tools/control { })
          (import ./pack-docs.nix { inherit pkgs; }).viewer
        ]
        ++ lib.optional (cfg.java != null) (
          runLocally "${cfg.name}-java" { } ''
            mkdir -p $out/bin
            ln -s ${cfg.java}/bin/java $out/bin/java
          ''
        )
        ++ dirs.server
        ++ dirs.common;

        postBuild =
          lib.optionalString (clientPack != null) ''
            echo ${clientPack} > $out/serverpack
          ''
          + ''
            cd $out
            for i in *.py *.sh *.service config/prometheus-integration.cfg *.txt; do
              substituteAll "$i" "$i".tmp
              mv "$i".tmp "$i"
              chmod +x "$i"
            done
          '';
      };
    };
}
