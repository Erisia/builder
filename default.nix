with import <nixpkgs> {};
with stdenv;

with import ./lib/lib.nix;

let
  forgeMajor = "1.7.10";
  forgeMinor = "10.13.4.1566";
  common-mods = {
    chunkgen = mkMod {
      name = "chunkgen-1.2.4-dev";
      src = fetchurl {
        url = https://madoka.brage.info/baughn/chunkgen-1.7.10-dev.jar;
        sha256 = "c6789ce071781ba2ec409d0c8874dba988e1d61f43136effa9231c4c89e3b29d";
      };
      side = "SERVER";
    };

    dynmap = mkMod {
      name = "dynmapforge";
      src = fetchurl {
        url = https://bloxgaming.com/bloxgate/Dynmap-2.2-forge-1.7.10.jar;
        sha256 = "d6391dc83af1cd2ec51ffceb4e6bb58bf1419a96336ca92360acfd90a91ce9b9";
      };
      side = "SERVER";
    };
    
    PrometheusIntegration = mkMod {
      name = "PrometheusIntegration-1.2.0";
      src = fetchurl {
        url = https://madoka.brage.info/baughn/prometheus-integration-1.2.0.jar;
        sha256 = "4891a053f1db9d6ed856a694b51c9099d38db91c6cfbfb42ad76a9ba1f874414";
      };
      side = "SERVER";
    };

    Terminator = mkMod {
      name = "Terminator-1.0";
      src = fetchurl {
        url = https://madoka.brage.info/baughn/terminator-1.0.jar;
        sha256 = "8b56b632d09eeb24c52bfeb4fda576f99490c97d8d26f88cd489869c4dc38c95";
      };
      side = "SERVER";
    };

    ElectricalAge = mkMod rec {
      ver = "dev-12";
      name = "ElectricalAge-${ver}";
      src = fetchurl {
        url = "https://madoka.brage.info/baughn/ElectricalAge-${ver}.jar";
        sha256 = "b338ec815586c2d415e559d562044b15cc1e7697d8afb7560b171ec9324b607e";
      };
    };

    TickProfiler = mkMod {
      name = "TickProfiler-1.7.10-jenkins-30";
      src = fetchurl {
        url = https://jenkins.nallar.me/job/TickProfiler/branch/1.7.10/31/artifact/build/libs/TickProfiler-1.7.10.jenkins.31.jar;
        sha256 = "0lns8lsx63s752i8zfsr8r84cyp4n23g4k6cn5y6i016s34ab4ln";
      };
      side = "SERVER";
    };

    Sampler = mkMod {
      name = "Sampler-1.60";
      src = fetchurl {
        url = https://madoka.brage.info/mods/sampler-1.60.jar;
        sha256 = "0k4ghkwvd84x54p57wfdrd7bgd59sq0sl8ma0l16i9b9ws9k98js";
      };
      side = "CLIENT";
      required = false;
    };

    Shaders = mkMod {
      name = "ShadersMod-2.3.31";
      src = fetchurl {
        sha256 = "72ecb961624d6a6c635ab1a5fd4c70273ad576902a4f9db54ac318a520f9bca8";
        url = https://madoka.brage.info/baughn/ShadersModCore-v2.3.31-mc1.7.10-f.jar;
      };
      side = "CLIENT";
      required = false;
   };
     
   Optifine = mkMod {
       name = "Optifine-1.7.10";
       src = fetchurl {
         url = https://madoka.brage.info/baughn/OptiFine_1.7.10_HD_U_D6.jar;
         sha256 = "415cba487ea5eddca981c6a00a5426236f8df36c635f5808aba227ad96d1b478";
       };
       side = "CLIENT";
       required = false;
    };

    DimensionalDoors = mkMod {
      name = "DimensionalDoors-2.2.5";
      src = fetchurl {
        url = https://madoka.brage.info/baughn/DimensionalDoors-2.2.5-null.jar;
        sha256 = "0d27478ee75d1654bfb59f743edaa0afde80acd3679d6a2488c2bd87b4183865";
      };
    };
  };

  clientMod = {
    isDefault ? false
  }: {
    side = "CLIENT";
    optional = true;
    inherit isDefault;
  };
in

rec {

  servers = {
    erisia-14 = {
      serverId = "erisia-14";
      serverDesc = "Erisia #14: Cave Creeperum";
      server = mm-server;
      port = 25565;
      hacks = {
        enableAntiChunkChurn = false;
        saveTime = 45;
        serverMemory = "9500m";
      };
    };
    erisia-15 = {
      serverId = "erisia-15";
      serverDesc = "Erisia #15: Dolor et Gemitus";
      server = br-server;
      port = 25566;
      hacks = { 
        serverMemory = "9500m";
     };
    };
  };

  ServerPack = mkServerPack {
    inherit servers;
  };

  LocalServerPack = mkServerPack {
    inherit servers;
    packUrlBase = "http://localhost:8000/";
  };

  web = callPackage ./web {};

  ###############################
  ## Erisia 15: Beyond Reality ##
  ###############################

  br = mkBasePack {
    src = fetchzip {
      url = https://madoka.brage.info/baughn/BeyondReality.zip;
      sha256 = "1kz3lc45bcca9hp7r86ys91k6ir6lfmwmr1zhjl2l4rnm2wplyyb";
      stripRoot = true;
    };

    modConfig = {
      fastcraft = {
        required = false;
      };
      voxelmapNoRadar = clientMod {
        isDefault = true;
      };
    };
  };

  br-mods = (builtins.removeAttrs br.mods [
    # Mods that dupe our manifests:
    "HelpFixer"
  ]) // common-mods // (addManifests [
    ./manifests/BR-Extras.nix
    ./manifests/cosmetic.nix
    ./manifests/tools.nix
  ]) // {
    # Paintings!
    BiblioCraft = bibliocraftWithPaintings {
      bibliocraft = br.mods.BiblioCraft;
      paintings = ./extraPaintings;
    };

    # Terrain generation, mostly in fixed-base.nix.
    # These should generally *not* be updated, as it'd break the terrain.
    WildCaves = mkMod {
      name = "WildCaves-3";
      src = fetchurl {
        url = "https://madoka.brage.info/baughn/WildCaves3-0.4.3.7.jar";
        sha256 = "1yc71myww1l80xpl2wj954j43z1d1cvb40yfqgnlp5z2rdrcgfac";
      };
    };
    
  };
  
  br-server = mkServer {
    name = "erisia-15";

    mods = br-mods;

    forge = fetchForge {
      major = forgeMajor; minor = forgeMinor;
    };

    screenName = "e15";
    hacks = servers.erisia-15.hacks;

    # These are applied in order. In case of overwrites nothing is deleted.
    # They're also copied to the client, after applying the below patches.
    extraDirs = [
      (br.getDir "config")
      (fetchzip {
        url = https://madoka.brage.info/baughn/BeyondReality-fonts.zip;
        sha256 = "1pfcspsrd6zq28pv3vazxzw3x21xl95zahbx1k73fmb0pj73m9mr";
        stripRoot = true;
      })
      (fetchzip {
        url = https://madoka.brage.info/baughn/BeyondReality-resources.zip;
        sha256 = "1059swym5n8695y0qvhv2ninx2qg4sx3mmvcp71lys4hipb034i6";
      })
      (br.getDir "hats")
      (br.getDir "scripts")
      (br.getDir "mods/1.7.10")
      ./base-e15
    ];

    # These are applied after everything else.
    # And in order, if it matters.
    # TODO: Write something that understands what it's doing.
    configPatches = [
      # No creeper griefing plz.
      ''sed -i CodeChickenCore.cfg -e s/environmentallyFriendlyCreepers=false/environmentallyFriendlyCreepers=true/''
      # Enable splash screen.
      ''sed -i splash.properties -e s/enabled=false/enabled=true/''
      # Disable the goddamned tracking aura.
      ''sed -i railcraft/railcraft.cfg -e s/trackingAura=true/trackingAura=false/''
      # Keep the SD behaviour we're used to.
      ''sed -i StorageDrawers.cfg -e s/B:invertShift=false/B:invertShift=true/''
      # Kill the annoying analytics spam.
      ''sed -i -e "s/analytics=true/analytics=false/" *.cfg */*.cfg''
      ''sed -i -e "s/usageStatistics=true/usageStatistics=false/" *.cfg */*.cfg''
      # Enable OpenBlocks graves
      ''sed -i -e "s/B:grave=false/B:grave=true/" OpenBlocks.cfg''
      ''sed -i -e "s/B:destructiveGraves=false/B:destructiveGraves=true/" OpenBlocks.cfg''
      # Surpress COFH Deathspam.
      ''sed -i "cofh/core/common.cfg" -e 's/B:EnableGenericDeathMessage=true/B:EnableGenericDeathMessage=false/' ''
      # Remove heat blocks; fixes CC pylon rebuilding
      ''sed -i "railcraft/blocks.cfg" -e 's/B:residual.heat=true/B:residual.heat=false/' ''
      # So many client configs.
      ''find . | grep -i client | xargs rm''
      # Chunkloaders should not need fuel.
      ''sed -i railcraft/railcraft.cfg -e "s/S:passive.fuel=minecraft:ender_pearl=12/S:passive.fuel=/" ''
      ''sed -i railcraft/railcraft.cfg -e "s/S:personal.fuel=minecraft:ender_pearl=12/S:personal.fuel=/" ''
      ''sed -i railcraft/railcraft.cfg -e "s/S:world.fuel=minecraft:ender_pearl=12/S:world.fuel=/" ''
      # Enables the crafting of world anchors.
      ''sed -i railcraft/railcraft.cfg -e "s/B:craftable=false/B:craftable=true/" ''
      #Enable the ExU Magnum Torch.
      ''sed -i ExtraUtilities.cfg -e "s/B:MagnumTorchEnabled=true/" ''
    ];
  };


  ###############################
  ## Erisia 14: Modular Mayhem ##
  ###############################

  mm = mkBasePack {

    src = (mkCursePack {
      manifest = manifests/legacy/Modular_Mayhem-1.21.zip;
      # Generated by scraping Curse.
      updates = [
        manifests/legacy/1.7.10-ModularMayhem.nix
        manifests/legacy/1.7.10-ModularMayhemExtras.nix
        manifests/legacy/1.7.10-Cosmetic.nix
        manifests/legacy/1.7.10-fixed-base.nix
        manifests/legacy/1.7.10-base.nix
      ];
    }).pack;

    modConfig = {
      fastcraft = {
        required = false;
        side = "CLIENT";
        isDefault = true;
      };
      journeymap = {
        required = false;
        isDefault = true;
      };
      BetterFoliage = {
        side = "CLIENT";
        required = false;
      };
      DynamicLights = {
        side = "CLIENT";
        required = false;
        isDefault = true;
      };
      DynamicSurroundings = {
        side = "CLIENT";
        required = false;
        isDefault = true;
      };
      SoundFilters = {
        side = "CLIENT";
        required = false;
        isDefault = true;
      };
      Fullscreen_Windowed = {
        side = "CLIENT";
        required = false;
        isDefault = true;
      };
      morpheus = {
        side = "SERVER";
      };
      Opis = {
        required = false;
      };
      Controlling = {
        side = "CLIENT";
        required = false;
        isDefault = true;
      };
      CoFHTweaks = {
        required = false;
      };
    };
  };

  mm-mods = (builtins.removeAttrs mm.mods [
    "GalacticraftCore"
    "Galacticraft-Planets"
    "GalaxySpace"
    "MicdoodleCore"
    "extrabiomesxl"
    "StevesWorkshop-"  # Duplicate of Ewy's.
    "CyanosLootableBodies"  # Buggy.
    "ImmersiveEngineering"
  ]) // common-mods // {
    # Paintings!
    BiblioCraft = bibliocraftWithPaintings {
      bibliocraft = mm.mods.BiblioCraft;
      paintings = ./extraPaintings;
    };

    # Remove the outdated ComputerCraft API so ChromatiCraft won't crash.
    EngineersToolbox = removeAPI {
      mod = mm.mods.EngineersToolbox;
      path = "dan200";
    };
    tardismod = removeAPI {
      mod = mm.mods.tardismod;
      path = "dan200";
    };

    # Terrain generation, mostly in fixed-base.nix.
    # These should generally *not* be updated, as it'd break the terrain.
    WildCaves = mkMod {
      name = "WildCaves-3";
      src = fetchurl {
        url = "https://madoka.brage.info/baughn/WildCaves3-0.4.3.7.jar";
        sha256 = "1yc71myww1l80xpl2wj954j43z1d1cvb40yfqgnlp5z2rdrcgfac";
      };
    };
    
    # Books.
    LostBooks = mkMod {
      name = "LostBooks";
      src = fetchurl {
        url = https://madoka.brage.info/baughn/LostBooks-1.7.10-1.2.2.jar;
        sha256 = "1mf8amqq591idzid7qsqik3kb98s7nb0iihzyb5vcl92n6pdn9m9";
      };
    };

    # Fixes the shelving units.
    MagneticraftPatcher = mkMod {
      name = "MagneticraftPatcher";
      src = fetchurl {
        url = https://github.com/Belgabor/MagneticraftPatcher/releases/download/Release_v0.1/MagneticraftPatcher-1.7.10-0.1.jar;
        sha256 = "1grdgdp4clvf5mldkva0wrdkmcdn4rvx5q2zc1mg0m5xb9v67w7s";
      };
    };

    # Fixes crash with Magneticraft chunkloading
    ImmersiveEngineering = mkMod {
      name = "Immersive_Engineering_v0.7.7";
      filename = "Immersive Engineering v0.7.7-tampered.jar";
      src = fetchurl {
        url = https://madoka.brage.info/release/ImmersiveEngineering-0.7.7-tampered.jar;
        sha256 = "53f9af054c5bee1fcd333b40c421c7218f09773814e83b233f3ad531d31759f8";
      };
    };
  };

  mm-server = mkServer {
    name = "erisia-14";

    mods = mm-mods;

    forge = fetchForge {
      major = forgeMajor; minor = forgeMinor;
    };

    screenName = "e14";
    hacks = servers.erisia-14.hacks;

    # These are applied in order. In case of overwrites nothing is deleted.
    # They're also copied to the client, after applying the below patches.
    extraDirs = [
      (mm.getDir "config")
      (mm.getDir "scripts")
      ./base
      ./base-e14
    ];

    # These are applied after everything else.
    # And in order, if it matters.
    # TODO: Write something that understands what it's doing.
    configPatches = [
      # Disable the goddamned tracking aura.
      ''sed -i railcraft/railcraft.cfg -e s/trackingAura=true/trackingAura=false/''
      # Keep the SD behaviour we're used to.
      ''sed -i StorageDrawers.cfg -e s/B:invertShift=false/B:invertShift=true/''
      # Overpowered worldgen is overpowered.
      ''sed -i "MatterOverdrive/Matter Overdrive.cfg" -e 's/"generate buildings"=true/"generate buildings"=false/' ''
      # Kill the annoying analytics spam.
      ''sed -i -e "s/analytics=true/analytics=false/" *.cfg */*.cfg''
      ''sed -i -e "s/usageStatistics=true/usageStatistics=false/" *.cfg */*.cfg''
      # Enable OpenBlocks graves
      ''sed -i -e "s/B:grave=false/B:grave=true/" OpenBlocks.cfg''
      ''sed -i -e "s/B:destructiveGraves=false/B:destructiveGraves=true/" OpenBlocks.cfg''
      # Surpress COFH Deathspam.
      ''sed -i "cofh/core/common.cfg" -e 's/B:EnableGenericDeathMessage=true/B:EnableGenericDeathMessage=false/' ''
      # Remove heat blocks; fix CC pylon rebuilding
      ''sed -i "railcraft/blocks.cfg" -e 's/B:residual.heat=true/B:residual.heat=false/' ''
      # So many client configs.
      ''find . | grep -i client | xargs rm''
      # Chunkloaders do not need fuel
      ''sed -i immibis.cfg -e s/B:chunkloader.useFuel=true/B:chunkloader.useFuel=false/''
      ''sed -i railcraft/railcraft.cfg -e "s/S:passive.fuel=minecraft:ender_pearl=12/S:passive.fuel=/" ''
      ''sed -i railcraft/railcraft.cfg -e "s/S:personal.fuel=minecraft:ender_pearl=12/S:personal.fuel=/" ''
      ''sed -i railcraft/railcraft.cfg -e "s/S:world.fuel=minecraft:ender_pearl=12/S:world.fuel=/" ''
      # Enable TE Activator - as no other block except OC robots can properly left click
      ''perl -i -pe "BEGIN{undef $/;} s/(Activator .*?B:Recipe.Enable=)false/\$1true/smg" cofh/thermalexpansion/common.cfg''
      # Floodlights cause a CPU leak, or something.
      ''sed -i ImmersiveEngineering.cfg -e 's/B:"Floodlight: Spawn Prevention"=true/B:"Floodlight: Spawn Prevention"=false/' ''
      # Fix of IE Excavator scripts to properly add ores - failure chance was too high
      ''sed -i ../scripts/Tweaks.zs -e "s_\(mods.immersiveengineering.Excavator.addMineral[^,]*, [0-9]\+, \)_\10._" ''
    ];
  };
  
}
