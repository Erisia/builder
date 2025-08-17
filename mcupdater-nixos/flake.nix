{
  description = "Erisia MCUpdater for NixOS users";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      packages.${system} = {
        mcupdater = pkgs.stdenv.mkDerivation rec {
          pname = "erisia-mcupdater";
          version = "1.0.0";

          src = pkgs.fetchurl {
            url = "https://madoka.brage.info/pack/MCUpdater-Bootstrap.jar";
            sha256 = "@BOOTSTRAP_HASH@"; # Will be substituted during build
          };

          nativeBuildInputs = with pkgs; [
            makeWrapper
            unzip
          ];

          buildInputs = with pkgs; [
            jdk17
            # Graphics and X11 libraries for JavaFX
            xorg.libX11
            xorg.libXext
            xorg.libXi
            xorg.libXrender
            xorg.libXtst
            xorg.libXxf86vm
            libGL
            # Audio support
            alsa-lib
            # Font rendering
            fontconfig
            freetype
          ];

          unpackPhase = ''
            mkdir -p $out/share/mcupdater
            cp $src $out/share/mcupdater/MCUpdater-Bootstrap.jar
          '';

          installPhase = ''
            mkdir -p $out/bin

            # Create wrapper script
            makeWrapper ${pkgs.jdk17}/bin/java $out/bin/erisia-mcupdater \
              --add-flags "-jar $out/share/mcupdater/MCUpdater-Bootstrap.jar" \
              --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath buildInputs}" \
              --set JAVA_HOME "${pkgs.jdk17}" \
              --set _JAVA_AWT_WM_NONREPARENTING 1 \
              --set _JAVA_OPTIONS "-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true" \
              --prefix PATH : "${pkgs.lib.makeBinPath [ pkgs.xorg.xrandr ]}"
          '';

          meta = with pkgs.lib; {
            description = "MCUpdater bootstrap configured for Erisia Minecraft servers";
            homepage = "https://madoka.brage.info/";
            license = licenses.asl20; # MCUpdater is Apache 2.0 licensed
            platforms = platforms.linux;
            maintainers = [ ];
          };
        };

        # Alias for convenience
        default = self.packages.${system}.mcupdater;
      };

      apps.${system} = {
        mcupdater = {
          type = "app";
          program = "${self.packages.${system}.mcupdater}/bin/erisia-mcupdater";
        };
        default = self.apps.${system}.mcupdater;
      };
    };
}
