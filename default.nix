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
        url = https://madoka.brage.info/baughn/chunkgen-1.7.10-1.2.3+10.jar;
        sha256 = "0pd77rzghp3fh1pnvk7paws2ksk6alx0riar9wk2b4g67wmn8sn6";
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

    eirairc = fetchCurse {
      name = "eirairc";
      target = "eirairc-mc1.7.10-2.9.402.jar";
      side = "SERVER";
    };
    
    PrometheusIntegration = mkMod {
      name = "PrometheusIntegration-1.1.0";
      src = fetchurl {
        url = https://madoka.brage.info/baughn/prometheus-integration-1.1.0.jar;
        sha256 = "b38cdb14dd571fc6e257737d2c5464ec8b9f1fbf942b4da2bfab736dd309f247";
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
      ver = "51.19";
      name = "ElectricalAge-${ver}";
      src = fetchurl {
        url = "https://madoka.brage.info/baughn/ElectricalAge-${ver}.jar";
        sha256 = "7d0cda0e505fccee5fe97489316ce50c1917e14573fe53802d85e5309008726f";
      };
    };

    TickProfiler = mkMod {
      name = "TickProfiler-1.7.10-jenkins-31";
      src = fetchurl {
        url = https://jenkins.nallar.me/job/TickProfiler/branch/1.7.10/lastSuccessfulBuild/artifact/build/libs/TickProfiler-1.7.10.jenkins.31.jar;
        sha256 = "1b23jl3xf354nm7x9dmyr9wgj444v26xy6c8v69vxzv0bmayh49q";
      };
      side = "SERVER";
    };
  };
in

rec {

  servers = {
    erisia-12 = {
      serverId = "erisia";
      serverDesc = "Erisia #12: Vivat Apparatus";
      server = server;
      port = 25565;
      hacks = {
        enableAntiChunkChurn = true;
        saveTime = 0;
      };
    };

    erisia-13 = {
      serverId = "erisia-13";
      serverDesc = "Erisia #13: Ave Dolor";
      server = tfp-server;
      port = 25566;
      hacks = {
        enableAntiChunkChurn = false;
        saveTime = 45;
      };
    };
  };

  ServerPack = mkServerPack {
    inherit forgeMajor forgeMinor servers;
  };

  web = callPackage ./web {};

  ## TerraFirmaPunk ##

  tfp = mkBasePack {
    src = fetchzip {
      url = https://madoka.brage.info/baughn/TerraFirmaPunk-2.0.3.zip;
      sha256 = "0qvqg81jkrg1p4rl3q965dgdr0k5930vyv748g2b399071b30cbf";
    };

    modConfig = {
      Opis = {
        required = false;
      };
      AutoRun = {
        side = "CLIENT";
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
      MobDismemberment = {
        side = "CLIENT";
      };
      SoundFilters = {
        side = "CLIENT";
      };
      ArmorStatusHUD = {
        side = "CLIENT";
        required = false;
        isDefault = true;
      };
      DamageIndicatorsMod = {
        side = "CLIENT";
        required = false;
        isDefault = true;
      };
      fastcraft = {
        required = false;
        side = "CLIENT";
        isDefault = true;
      };
      journeymap = {
        required = false;
        isDefault = true;
      };
      HQM-The_Journey = {
        required = false;
        isDefault = true;
        side = "CLIENT";
      };
    };
  };

  tfp-mods = (builtins.removeAttrs tfp.mods [
    "Aroma1997Core"
    "MemoryCleaner" # This thing just forces even more explicit GCs. WTF? Away, foul one!
  ]) // common-mods // {
    # Libraries.
    ForgeMultiPart = mkMod {
      name = "ForgeMultiPart-1.7.10";
      src = fetchurl {
        url = http://files.minecraftforge.net/maven/codechicken/ForgeMultipart/1.7.10-1.2.0.347/ForgeMultipart-1.7.10-1.2.0.347-universal.jar;
        sha256 = "0r3mgss1fakbrrkiifrf06dcdwnxbwsryiiw0l2k4sbjvk58hah0";
      };
    };

    # bspkrsCore = fetchCurse {
    #   name = "bspkrsCore";
    #   target = "[1.7.10]bspkrsCore-universal-6.16.jar";
    # };

    # CodeChickenLib = mkMod {
    #   name = "CodeChickenLib-1.1.3.140";
    #   src = fetchurl {
    #     url = http://files.minecraftforge.net/maven/codechicken/CodeChickenLib/1.7.10-1.1.3.140/CodeChickenLib-1.7.10-1.1.3.140-universal.jar;
    #     sha256 = "06jf4h34by7d9dfbgsb3ii7fm6kqirny645afvb8c8wlg65n0rvr";
    #   };
    # };

    # Extra paintings!
    BiblioCraft = bibliocraftWithPaintings {
      bibliocraft = tfp.mods.BiblioCraft;
      paintings = ./extraPaintings;
    };

    # Extra cosmetic mods.
    DynamicSurroundings = fetchCurse {
      name = "238891-dynamic-surroundings";
      target = "DynamicSurroundings-1.7.10-1.0.5.6.jar";
      side = "CLIENT";
      required = false;
      isDefault = true;
    };

    # Shaders = mkMod {
    #   name = "shaders";
    #   src = fetchurl {
    #     url = http://www.karyonix.net/shadersmod/files/ShadersModCore-v2.3.31-mc1.7.10-f.jar;
    #     sha256 = "1a5wz4haa6639asrskraj1vdafi7f16gv9dib9inqsjdc9hvkv3j";
    #   };
    #   side = "CLIENT";
    #   required = false;
    # };

    Optifine = mkMod {
      name = "optifine";
      src = fetchurl {
        url = https://madoka.brage.info/baughn/OptiFine_1.7.10_HD_U_D4.jar;
        sha256 = "0h4920r69cfzfgyca6xv46m4ynbc2jb09ipvf3z5rb4a6jms3qqw";
      };
      side = "CLIENT";
      required = false;
      isDefault = true;
    };

    GardenStuff = bevos.mods.GardenStuff;

    # Stellar Sky is disabled for now, due to various apparent bugs and incompatibilities. Sorry~
    # Needed by StellarSky and Photoptics.
    StellarAPI = fetchCurse {
      name = "stellar-api";
      target = "Stellar API v0.1.3.7b [1.7.10]";
    };
    StellarSky = fetchCurse {
      name = "stellar-sky";
      target = "Stellar Sky v0.1.5.7[1.7.10] (Stellar API v0.1.3.7)  (Final for 1.7.10)";
    };
    Weather = mkMod {
      name = "Weather-2.3.10";
      src = fetchurl {
        url = https://madoka.brage.info/baughn/weather2-1.7.10-2.3.10.jar;
        sha256 = "edca9d4adff5dcf090b7f9cd370d80ee978646fe72dd6487bd05663b2883164b";
      };
    };
  };

  tfp-resourcepack = fetchzip {
    url = https://madoka.brage.info/baughn/ResourcePack-tfp.zip;
    sha256 = "01wrf1vnwwgd5vazmbs24kwhb4njys33wbx65inagkfpz7sg9mxs";
    stripRoot = false;
  };

  tfp-server = mkServer {
    name = "erisia-13";

    mods = tfp-mods;

    inherit forgeMajor;
    forge = fetchForge {
      major = forgeMajor; minor = forgeMinor;
      sha1 = "4d2xzm7w6xwk09q7sbcsbnsalc09xp0v";
    };

    screenName = "e13";
    hacks = servers.erisia-13.hacks;

    # These are applied in order. In case of overwrites nothing is deleted.
    # They're also copied to the client, after applying the below patches.
    extraDirs = [
      (tfp.getDir "config")
      (tfp.getDir "scripts")
      (tfp.getDir "mods/resources")
      (bevos.getDir "libraries")
      tfp-resourcepack
      ./base
    ];

    # These are applied after everything else.
    # And in order, if it matters.
    # TODO: Write something that understands what it's doing.
    configPatches = [
      # Keep the SD behaviour we're used to.
      ''sed -i StorageDrawers.cfg -e s/B:invertShift=false/B:invertShift=true/''
      # No, don't lock people out if they die. :'(
      ''sed -i hqm/hqmconfig.cfg -e 's/B:"Auto-start hardcore mode"=true/B:"Auto-start hardcore mode"=false/' ''
      # Avoid spawning Steamcraft blocks, because they kill TPS and glitch rendering.
      ''cd ../mods/resources/ruins/
        chmod -R u+w .
        find . -type f -print0 | xargs -0 sed -ri 's/,Steamcraft:[^,]+/,air/g' ''
      # We've diked out HQM. Remove its drops.
      ''find MobProperties -name \*.json -print0 \
          | xargs -0 sed -ri 's/HardcoreQuesting:[^"]+/terrafirmacraft:Torch/g' ''
    ];
  };

  ##########################
  ## Erisia 12 below here ##
  ##########################

  bevos = mkBasePack {
    src = fetchzip {
      url = https://madoka.brage.info/baughn/BevosUNC.zip;
      sha256 = "1w5ks89lga3lrv5gzc24sxx0szqryn111xn2k8zmb78v0vk8mmsc";
      stripRoot = false;
    };

    # This lets you set options for mods in the base back.
    # Same way as for mods added to it, below.
    modConfig = {
      fastcraft = {
        required = false;
        side = "CLIENT";
      };
    };
  };

  # This is where we add mods that weren't part of Bevos.
  mods = bevos.mods // common-mods // {
    # TODO: The below has a hell of a lot of not-using-the-version-option.
    # Because it never works.
    # It should be possible to make use of the perl version-number parser to fix that.

    # These mod(s) override mods that exist in Bevo's pack, so the attribute name
    # actually matters. For everything else, it pretty much doesn't.

    # None at the moment.

    # Client-side:
    WhatsThisPack = fetchCurse {
      name = "wtp-whats-this-pack";
      target = "WTP-1.7.10-1.0.29.1.jar";
      side = "CLIENT";
    };

    DynamicSurroundings = fetchCurse {
      name = "238891-dynamic-surroundings";
      target = "DynamicSurroundings-1.7.10-1.0.5.6.jar";
      side = "CLIENT";
      required = false;
      isDefault = true;
    };

    # StellarSky = fetchCurse {
    #   name = "stellar-sky";
    #   target = "Stellar Sky v0.1.2.9b[1.7.10] (SciAPI v1.1.0.0)";
    #   side = "CLIENT";
    #   required = false;
    #   # TODO: Make this depend on sciapi, make both optional.
    #   # Implement dependencies.
    # };

    # sciapi = fetchCurse {
    #   name = "sciapi";
    #   target = "SciAPI v1.1.0.0[1.7.10]";
    #   side = "CLIENT";
    # };

    # Both-sided:

    # Opis appears to be incompatible with ForgeEssentials.
    
    Opis = fetchCurse {
      name = "opis";
      target = "Opis-1.2.5_1.7.10.jar";
      required = false;
    };

    # Opis depends on this.
    MobiusCore = fetchCurse {
      name = "mobiuscore";
      target = "MobiusCore-1.2.5_1.7.10.jar";
      required = false;
    };
    
    ImmibisCore = mkMod {
      name = "ImmibisCore-59.1.4";
      src = fetchurl {
        url = https://madoka.brage.info/baughn/ImmibisCore-59.1.4.jar;
        md5 = "14dbc89ce3d361541234ac183270b5a1";
      };
    };

    DimensionalAnchors = mkMod {
      name = "DimensionalAnchors-59.0.3";
      src = fetchurl {
        url = https://madoka.brage.info/baughn/DimensionalAnchors-59.0.3.jar;
        md5 = "65669c1fab43ae1d3ef41a659fdd530c";
      };
    };

    Agricraft = fetchCurse {
      name = "AgriCraft";
      version = "1.5.0";
    };
    Automagy = fetchCurse {
      name = "Automagy";
      target = "v0.28.2";
    };
    BiomesOPlenty = fetchCurse {
      name = "biomes-o-plenty";
      target = "BiomesOPlenty-1.7.10-2.1.0.1889-universal.jar";
    };
    Farseek = fetchCurse { # streams dependency
      name = "Farseek";
      target = "Farseek-1.0.11.jar";
    };
    Flatsigns = fetchCurse {
      name = "flatsigns";
      target = "FlatSigns-1.7.10-universal-2.1.0.19.jar";
    };
    ForbiddenMagic = fetchCurse {
      name = "forbidden-magic";
      target = "Forbidden Magic-1.7.10-0.574.jar";
    };
    IguanasTinkerTweaks = fetchCurse {
      name = "iguanas-tinker-tweaks";
      target = "IguanaTinkerTweaks-1.7.10-2.1.6.jar";
    };
    MagicBees = fetchCurse {
      name = "magic-bees";
      target = "magicbees-1.7.10-2.4.3.jar";
    };
    Streams = fetchCurse {
      name = "streams";
      target = "Streams-0.2.jar";
    };
    RTG = fetchCurse {
      name = "realistic-terrain-generation";
      target = "RTG-1.7.10-0.7.0";
    };
    TcNodeTracker = fetchCurse {
      name = "thaumcraft-node-tracker";
      target = "tcnodetracker-1.7.10-1.1.2.jar";
    };
    ThaumicEnergistics = fetchCurse {
      name = "thaumic-energistics";
      target = "Thaumic Energistics 1.0.0.1";
    };
    ThaumicHorizons = fetchCurse {
      name = "thaumic-horizons";
      target = "thaumichorizons-1.7.10-1.1.9.jar";
    };
    ThaumicTinkerer = fetchCurse {
      name = "thaumic-tinkerer";
      target = "Thaumic Tinkerer 164";
    };
    TravellersGear = fetchCurse {
      name = "travellers-gear";
      target = "Traveller's Gear v1.16.6";
    };
    Witchery = fetchCurse {
      name = "witchery";
      version = "0.24.1";
    };
    WitchingGadgets = fetchCurse {
      name = "witching-gadgets";
      target = "Witching Gadgets v1.1.10";
    };
    Ztones = fetchCurse {
      name = "ztones";
      target = "Ztones-1.7.10-2.2.1.jar";
    };

    # Reika's mods below. Beware.
    DragonAPI = fetchCurse {
      name = "dragonapi";
      target = "DragonAPI 1.7.10 V15a.jar";
    };
    RotaryCraft = fetchCurse {
      name = "rotarycraft";
      target = "RotaryCraft 1.7.10 V15a.jar";
    };
    
    #ForgeEssentials
    #ForgeEssentials = fetchCurse {
    #  name = "forge-essentials-74735";
    #  target = "forgeessentials-1.7.10-1.4.4.1146";
    #  side = "SERVER";
    #};
    #ForgeEssentialsClient = fetchCurse {
    #  name = "forge-essentials-client";
    #  target = "forgeessentials-1.7.10-1.4.4.1146-client";
    #  side = "CLIENT";
    #  required = false;
    #};

    # Adds extra paintings!
    BiblioCraft = bibliocraftWithPaintings {
      bibliocraft = bevos.mods.BiblioCraft;
      paintings = ./extraPaintings;
    };
  };

  resourcepack = fetchzip {
    url = https://madoka.brage.info/baughn/ResourcePack.zip;
    sha256 = "1xlw05895qvrhdn075lg88g07f1bc5h8xmj7v76434rcwbr5s2dd";
    stripRoot = false;
  };

  server = mkServer {
    name = "erisia-12";

    mods = mods;

    inherit forgeMajor;
    forge = fetchForge {
      major = forgeMajor; minor = forgeMinor;
      sha1 = "4d2xzm7w6xwk09q7sbcsbnsalc09xp0v";
    };

    screenName = "e12";
    hacks = servers.erisia-12.hacks;

    # These are applied in order. In case of overwrites nothing is deleted.
    # They're also copied to the client, after applying the below patches.
    extraDirs = [
      (bevos.getDir "config")
      (bevos.getDir "scripts")
      (bevos.getDir "libraries")
      (bevos.getDir "mods/resources")
      resourcepack
      # This is, of course, inside the git repository. Being last, any files you
      # put here override files in Bevos' zips.
      ./base
    ];

    # These are applied after everything else.
    # And in order, if it matters.
    # TODO: Write something that understands what it's doing.
    configPatches = [
      ''sed -i StorageDrawers.cfg -e s/B:invertShift=false/B:invertShift=true/''

      # AOBD / RotC integration is frequently buggy, and nearly pointless anyway.
      ''sed -i aobd.cfg -e s/B:RotaryCraft=true/B:RotaryCraft=false/''

      # Start AE off with a more useful default, if we're overwriting the config every time anyway.
      ''sed -i AppliedEnergistics2/AppliedEnergistics2.cfg -e "s/S:SEARCH_MODE=.*/S:SEARCH_MODE=NEI_AUTOSEARCH/"''

      #disable extremely annoying tree planting
      ''sed -i scottstweaks.cfg -e s/B:doPlantGrowable=true/B:doPlantGrowable=false/''

      # So many client configs.
      ''find . | grep -i client | xargs rm''

      # Patch an entity ID conflict. It didn't happen before. ...I don't know.
      ''sed -i "MatterOverdrive/Matter Overdrive.cfg" -e "s/I:entity.failed_pig.id=38/I:entity.failed_pig.id=138/"''

     # Why on notch's green overworld would anyone ever want expensive safari nets?    
     ''sed -i "powercrystals/minefactoryreloaded/common.cfg" -e "s/B:ExpensiveSafariNet=true/B:ExpensiveSafariNet=false/"''

    ];
  };

}
