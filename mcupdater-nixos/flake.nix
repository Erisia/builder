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
        mcupdater = pkgs.buildFHSEnv {
          name = "erisia-mcupdater";
          
          targetPkgs = pkgs: with pkgs; [
            # Java runtime
            jdk17
            
            # Essential libraries that Minecraft and MCUpdater need
            xorg.libX11
            xorg.libXext
            xorg.libXi
            xorg.libXrender
            xorg.libXtst
            xorg.libXxf86vm
            xorg.libXrandr
            libGL
            mesa
            
            # Audio support
            alsa-lib
            pulseaudio
            
            # Font rendering
            fontconfig
            freetype
            
            # System utilities that Minecraft might invoke
            bash
            coreutils
            glibc
            
            # Network tools
            curl
            wget
            
            # Archive tools (for mod downloads)
            unzip
            zip
            
            # Libraries commonly needed by native Minecraft components
            zlib
            libpng
            libjpeg
            
            # OpenGL and graphics
            libdrm
            wayland
            
            # GTK for some Java applications
            gtk3
            gtk2
          ];
          
          multiPkgs = pkgs: with pkgs; [
            # 32-bit libraries that might be needed
            libGL
            alsa-lib
            zlib
          ];
          
          runScript = let
            mcupdaterJar = pkgs.fetchurl {
              url = "https://madoka.brage.info/pack/MCUpdater-Bootstrap.jar";
              sha256 = "@BOOTSTRAP_HASH@"; # Will be substituted during build
            };
          in pkgs.writeScript "erisia-mcupdater" ''
            #!${pkgs.bash}/bin/bash
            export JAVA_HOME="${pkgs.jdk17}"
            export _JAVA_AWT_WM_NONREPARENTING=1
            export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"
            
            # Create a writable directory for MCUpdater data
            export MCUPDATER_HOME="''${XDG_DATA_HOME:-$HOME/.local/share}/mcupdater"
            mkdir -p "$MCUPDATER_HOME"
            cd "$MCUPDATER_HOME"
            
            exec ${pkgs.jdk17}/bin/java -jar ${mcupdaterJar} "$@"}
          '';
          
          meta = with pkgs.lib; {
            description = "MCUpdater bootstrap configured for Erisia Minecraft servers (FHS environment)";
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
