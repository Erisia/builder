# Unit tests for the pack options (lib/pack-module.nix) and lib/pack.nix.
#
# Produces: a derivation (`checks.pack-module`) that fails, listing the failed cases, if any
#   expected value differs. Everything is evaluated; nothing is built.
# Consumers: the flake's checks.
{ pkgs, builder }:
let
  inherit (pkgs) lib;
  inherit (builder) evalPack buildPack;

  # The least a pack must set.
  minimal = {
    name = "T";
    port = 25570;
    prometheusPort = 1300;
    minecraft = "1.12.2";
    loader = {
      type = "forge";
      major = "1.12.2";
      minor = "14.23.5.2864";
    };
    manifest = ./testdata/empty-manifest.json;
  };
  eval = module: evalPack module { };

  # Whether evaluating `value` fails. tryEval catches the module system's `throw`s.
  fails = value: !(builtins.tryEval value).success;

  # An upstream pack; nothing below builds it, so the hash and URL are never used.
  withUpstream =
    overlay:
    minimal
    // {
      upstream = {
        urls = [ "https://example.invalid/pack.zip" ];
        hash = lib.fakeHash;
        removed = ./testdata/removed-none.txt;
        inherit overlay;
      };
    };
  dirsOf = module: (buildPack (eval module) { }).dirs;

  results = lib.runTests {
    testDefaults = {
      expr = {
        inherit (eval minimal)
          description
          serverName
          rconPort
          ram
          publish
          java
          ;
      };
      expected = {
        description = "T";
        serverName = "T";
        rconPort = 35570;
        ram = "4000m";
        publish = true;
        java = null;
      };
    };

    testNoUpstreamKeepsDirs = {
      expr = {
        inherit (eval minimal) upstream;
        dirs = dirsOf (minimal // { dirs.server = [ ./testdata ]; });
      };
      expected = {
        upstream = null;
        dirs = {
          common = [ ];
          client = [ ];
          server = [ ./testdata ];
        };
      };
    };
    # Upstream comes after the pack's own dirs (first wins), on each side.
    testUpstreamDirs = {
      expr =
        let
          built = buildPack (eval (withUpstream ./testdata/overlay)) { };
        in
        {
          common = map (d: d == built.upstream.out) built.dirs.common;
          client = map (d: d == built.upstream.client) built.dirs.client;
          server = built.dirs.server;
        };
      expected = {
        common = [ true ];
        client = [ true ];
        server = [ (./testdata/overlay + "/server") ];
      };
    };
    testOverlayWithoutServerDir = {
      expr = (dirsOf (withUpstream ./testdata/overlay-common-only)).server;
      expected = [ ];
    };
    testUpstreamNeedsUrls = {
      expr =
        fails
          (eval (
            minimal
            // {
              upstream = {
                urls = [ ];
                hash = lib.fakeHash;
                removed = ./testdata/removed-none.txt;
              };
            }
          )).upstream.urls;
      expected = true;
    };

    testWrongTypeFails = {
      expr = fails (eval (minimal // { port = "25570"; })).port;
      expected = true;
    };
    testPortRangeFails = {
      expr = fails (eval (minimal // { port = 70000; })).port;
      expected = true;
    };
    testBadRamFails = {
      expr = fails (eval (minimal // { ram = "8 GB"; })).ram;
      expected = true;
    };
    testUnknownOptionFails = {
      expr = fails (eval (minimal // { prot = 1; })).port;
      expected = true;
    };
    testUnknownLoaderFails = {
      expr =
        fails
          (eval (
            minimal
            // {
              loader = minimal.loader // {
                type = "fabric";
              };
            }
          )).loader.type;
      expected = true;
    };

    # MCUpdater clients run Forge: a Forge server's own version, or clientForge for Cleanroom.
    testClientLoaderForge = {
      expr = (buildPack (eval minimal) { }).client.loader.version;
      expected = "1.12.2-14.23.5.2864";
    };
    testClientLoaderCleanroomNeedsForge = {
      expr =
        fails
          (buildPack (eval (
            minimal
            // {
              loader = minimal.loader // {
                type = "cleanroom";
              };
            }
          )) { }).client.loader.version;
      expected = true;
    };

    # The client descriptor is what the ServerPack (and its revision) is built from: it must not
    # change shape, and it must not mention the server.
    testClientFields = {
      expr = builtins.attrNames (buildPack (eval minimal) { }).client;
      expected = [
        "configsDir"
        "description"
        "loader"
        "minecraft"
        "mods"
        "modsDir"
        "port"
      ];
    };

    # The attributes flake.nix, golden.nix, update-and-start.sh and the lab read.
    testE36Interface = {
      expr = builtins.all (name: builder.packs.e36 ? ${name}) [
        "server"
        "launcherDir"
        "clientConfigDir"
        "clientConfigsDir"
        "clientModsDir"
        "serverModsDir"
      ];
      expected = true;
    };
    testE36Values = {
      expr = {
        inherit (builder.packs.e36.config)
          name
          ram
          port
          rconPort
          prometheusPort
          publish
          ;
        loader = builder.packs.e36.client.loader.version;
      };
      expected = {
        name = "E36";
        ram = "8G";
        port = 25565;
        rconPort = 35565;
        prometheusPort = 1224;
        publish = true;
        loader = "1.12.2-14.23.5.2864";
      };
    };
    testOnlyPublishedPacksInServerPack = {
      expr = builtins.attrNames builder.publishedPacks;
      expected = [ "e36" ];
    };
  };
in
pkgs.runCommand "pack-module-tests" { } (
  if results == [ ] then
    ''touch "$out"''
  else
    ''
      echo "Failed pack-module tests:"
      cat ${pkgs.writeText "failures.json" (builtins.toJSON results)}
      exit 1
    ''
)
