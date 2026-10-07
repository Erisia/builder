# The typed options of a pack definition (packs/<pack>/pack.nix).
#
# Produces: a module for lib.evalModules. A misspelt option or a wrong type fails at evaluation
#   with a message naming the option, and `nix build .#pack-options` renders these declarations as
#   Markdown, so the docs can't drift from the code.
# Inputs: the pack module itself. lib/pack.nix passes `inHouseMods` as a module argument, so a
#   pack can list the builder's own mods in `dirs.server`.
# Consumers: lib/pack.nix (evalPack, then buildPack turns the values into derivations).
# Interface kept (see runtime-interface.md): the server's substituted variables (ram, serverName,
#   port, prometheusPort, rconPort), the ServerPack's description/minecraft/port, and
#   the order in which config directories are joined.
{ config, lib, ... }:
let
  inherit (lib) mkOption types;

  # A directory to merge into the pack. Packages are checked first: types.path would turn a
  # derivation into a string, which forces its outPath. The in-house mods depend on this pack's
  # own launcherDir, so forcing them while the pack is still being evaluated would loop.
  dir = types.either types.package types.path;

  # A loader version, split the way the loaders' download URLs and launcher-lock.json are.
  versionOptions = {
    major = mkOption {
      type = types.str;
      description = "The Minecraft version the loader is built for, e.g. `1.12.2`.";
    };
    minor = mkOption {
      type = types.str;
      description = "The loader's own version, e.g. `14.23.5.2864`.";
    };
  };
in
{
  options = {
    name = mkOption {
      type = types.str;
      example = "E36";
      description = "Short name. Store paths are named after it (`<name>-server`).";
    };
    description = mkOption {
      type = types.str;
      default = config.name;
      defaultText = lib.literalExpression "config.name";
      description = "The name players see in MCUpdater.";
    };
    serverName = mkOption {
      type = types.str;
      default = config.name;
      defaultText = lib.literalExpression "config.name";
      description = "Name substituted for `@serverName@` in the server's scripts.";
    };
    publish = mkOption {
      type = types.bool;
      default = true;
      description = "Whether the pack is listed in the ServerPack, so players can install it.";
    };

    ram = mkOption {
      type = types.strMatching "[0-9]+[mMgG]";
      default = "4000m";
      example = "8G";
      description = "Java heap size, substituted for `@ram@`.";
    };
    port = mkOption {
      type = types.port;
      description = "The port players connect to.";
    };
    rconPort = mkOption {
      type = types.port;
      default = config.port + 10000;
      defaultText = lib.literalExpression "config.port + 10000";
      description = "The RCON port.";
    };
    prometheusPort = mkOption {
      type = types.port;
      description = "The port of the server's Prometheus exporter.";
    };

    minecraft = mkOption {
      type = types.str;
      example = "1.12.2";
      description = "The Minecraft version.";
    };
    loader = mkOption {
      type = types.submodule {
        options = {
          type = mkOption {
            type = types.enum [
              "forge"
              "cleanroom"
            ];
            description = "Which loader the server runs.";
          };
        }
        // versionOptions;
      };
      description = "The server's mod loader. Its installer must be pinned in launcher-lock.json.";
    };
    clientForge = mkOption {
      type = types.nullOr (types.submodule { options = versionOptions; });
      default = null;
      description = ''
        The Forge version MCUpdater installs for players. Required when the server runs
        Cleanroom, since MCUpdater clients run Forge. When null, clients get the server's Forge.
      '';
    };
    java = mkOption {
      type = types.nullOr types.package;
      default = null;
      defaultText = lib.literalExpression "null";
      description = ''
        The JDK the server runs on, linked as `bin/java` in the server. start.py prefers it over
        `nix shell nixpkgs#…`, so the JDK comes from flake.lock. When null, start.py's fallback is used.
      '';
    };

    prism.preserve = mkOption {
      type = types.listOf types.str;
      default = [ ];
      example = [ "config/jei/jei.cfg" ];
      description = ''
        Client files Prism players are expected to edit: packwiz-installer installs them when
        missing but doesn't overwrite them when the pack changes them (lib/prism.nix).
      '';
    };

    upstream = mkOption {
      type = types.nullOr (
        types.submodule {
          options = {
            urls = mkOption {
              type = types.nonEmptyListOf types.str;
              description = "Where to fetch the pack's CurseForge zip, tried in order: our mirror first.";
            };
            hash = mkOption {
              type = types.str;
              example = "sha256-lFW+VUHhuDPUwhRLcdmRzPUPSTSnC3CXahWZtrIZcFg=";
              description = "The zip's SRI hash.";
            };
            removed = mkOption {
              type = types.path;
              description = ''
                The tombstone list: files under the zip's `overrides/` that the pack leaves out, one
                per line (`#` comments allowed). An entry the zip doesn't have fails the build.
              '';
            };
            clientOnly = mkOption {
              type = types.listOf types.str;
              default = [ ];
              example = [
                "resources"
                "schematics"
              ];
              description = "Top-level override directories only clients get. The rest goes to both sides.";
            };
            textSuffixes = mkOption {
              type = types.listOf types.str;
              default = [ ];
              example = [
                ".cfg"
                ".json"
              ];
              description = "Upstream files with these suffixes get CRLF line endings converted to LF.";
            };
            overlay = mkOption {
              type = types.nullOr types.path;
              default = null;
              description = ''
                The pack's changes to upstream: a directory with `common/`, `client/` and `server/`.
                `common/` and `client/` replace or add upstream files; one identical to the upstream
                file it replaces fails the build. `server/` is added to the server's directories as it is.
              '';
            };
          };
        }
      );
      default = null;
      description = ''
        An upstream CurseForge modpack whose `overrides/` the pack builds on (lib/upstream.nix).
        It comes after `dirs`, so files in `dirs` take precedence.
      '';
    };

    manifest = mkOption {
      type = types.path;
      description = "The generated mod lock, `manifest/<pack>.json`.";
    };
    # Joined with symlinkJoin, where the first directory that has a file wins. The server gets
    # `server` then `common`; clients get `client` then `common`.
    dirs = {
      common = mkOption {
        type = types.listOf dir;
        default = [ ];
        description = "Directories both the server and clients get.";
      };
      server = mkOption {
        type = types.listOf dir;
        default = [ ];
        description = "Directories only the server gets. They take precedence over `common`.";
      };
      client = mkOption {
        type = types.listOf dir;
        default = [ ];
        description = "Directories only clients get. They take precedence over `common`.";
      };
    };
  };
}
