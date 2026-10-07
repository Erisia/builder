{
  description = "Erisia pack-builder & server management tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      builder = import ./builder.nix { inherit pkgs; };
      golden = import ./lib/golden.nix { inherit pkgs builder; };
      packPackages = pkgs.lib.mapAttrs (_: pack: {
        inherit (pack)
          launcherDir
          server
          clientConfigDir
          clientConfigsDir
          clientModsDir
          serverModsDir;
      }) builder.packs;
      flatPackPackages = pkgs.lib.concatMapAttrs (name: pack: {
        "${name}-launcherDir" = pack.launcherDir;
        "${name}-server" = pack.server;
        "${name}-clientConfigDir" = pack.clientConfigDir;
        "${name}-clientConfigsDir" = pack.clientConfigsDir;
        "${name}-clientModsDir" = pack.clientModsDir;
        "${name}-serverModsDir" = pack.serverModsDir;
      }) packPackages;
    in {
      packages.${system} = flatPackPackages // {
        save-threading-fix = builder.saveThreadingFix;
        live-inspector = builder.liveInspector;
        danknull-migrate = builder.dankNullMigrate;
        golden-e36 = golden.tree;
        # The pack options (lib/pack-module.nix) as Markdown.
        pack-options = (pkgs.nixosOptionsDoc {
          options = builtins.removeAttrs
            (pkgs.lib.evalModules { modules = [ ./lib/pack-module.nix ]; }).options
            [ "_module" ];
          # Name the file by its repository path, not its store path.
          transformOptions = opt: opt // {
            declarations = [ {
              name = "lib/pack-module.nix";
              url = "https://github.com/Erisia/builder/blob/master/lib/pack-module.nix";
            } ];
          };
        }).optionsCommonMark;
        default = builder.ServerPackLocal;
        inherit (builder) ServerPack ServerPackLocal web mcupdaterFlakeRepo;
        serverPack = builder.ServerPack;
        serverPackLocal = builder.ServerPackLocal;
      };

      legacyPackages.${system} = builder;

      checks.${system} = {
        golden-e36 = golden.check;
        quality = import ./lib/quality.nix { inherit pkgs; };
        pack-module = import ./tests/pack-module.nix { inherit pkgs builder; };
        save-threading-fix = builder.saveThreadingFix.tests.integration;
        live-inspector = builder.liveInspector.tests.integration;
        tick-debug = pkgs.runCommand "minecraft-tick-debug-tests" {
          nativeBuildInputs = [ pkgs.python3 ];
        } ''
          export PYTHONDONTWRITEBYTECODE=1
          cd ${pkgs.lib.fileset.toSource {
            root = ./.;
            fileset = pkgs.lib.fileset.unions [
              ./tools/skills/minecraft-tick-debug/scripts
              ./tests/test_tick_debug.py
            ];
          }}
          python3 -m unittest discover -s tests -p test_tick_debug.py -v
          touch "$out"
        '';
        shutdown = pkgs.runCommand "minecraft-launcher-tests" {
          nativeBuildInputs = [ pkgs.python3 pkgs.bash pkgs.coreutils pkgs.gnugrep ];
        } ''
          export PYTHONDONTWRITEBYTECODE=1
          cd ${pkgs.lib.fileset.toSource {
            root = ./.;
            fileset = pkgs.lib.fileset.unions [
              ./shutdown.py
              ./update-and-start.sh
              ./runtime/crash_analysis.py
              ./runtime/start.py
              ./tests/test_daily_restart.py
              ./tests/test_start_java.py
              ./tests/test_shutdown.py
              ./tests/test_crash_analysis.py
            ];
          }}
          python3 -m unittest discover -s tests -p 'test_*.py' -v
          touch "$out"
        '';
        inherit (builder) ServerPackLocal web;
        launchers = pkgs.linkFarm "erisia-launchers"
          (pkgs.lib.mapAttrsToList
            (name: pack: { inherit name; path = pack.launcherDir; })
            builder.packs);
      };
    };
}
