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
      packPackages = pkgs.lib.mapAttrs (_: pack: {
        inherit (pack)
          launcherDir
          server
          mcuPack
          clientConfigDir
          clientConfigsDir
          clientModsDir
          serverModsDir;
      }) builder.packs;
      flatPackPackages = pkgs.lib.concatMapAttrs (name: pack: {
        "${name}-launcherDir" = pack.launcherDir;
        "${name}-server" = pack.server;
        "${name}-mcuPack" = pack.mcuPack;
        "${name}-clientConfigDir" = pack.clientConfigDir;
        "${name}-clientConfigsDir" = pack.clientConfigsDir;
        "${name}-clientModsDir" = pack.clientModsDir;
        "${name}-serverModsDir" = pack.serverModsDir;
      }) packPackages;
    in {
      packages.${system} = flatPackPackages // {
        default = builder.ServerPackLocal;
        inherit (builder) ServerPack ServerPackLocal ServerPackE35 web mcupdaterFlakeRepo;
        serverPack = builder.ServerPack;
        serverPackLocal = builder.ServerPackLocal;
        serverPackE35 = builder.ServerPackE35;
      };

      legacyPackages.${system} = builder;

      checks.${system} = {
        inherit (builder) ServerPackLocal web;
        launchers = pkgs.linkFarm "erisia-launchers"
          (pkgs.lib.mapAttrsToList
            (name: pack: { inherit name; path = pack.launcherDir; })
            builder.packs);
      };
    };
}
