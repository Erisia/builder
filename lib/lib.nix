{ stdenv, symlinkJoin, runCommand, linkFarm, fetchurl, callPackage, writeText
, xorg, cacert, jre, wget, zip, rsync, saxonb, python3, lib
}:
with stdenv;

rec {

  /**
   * Extends a pack definition with all its derivations.
   *
   * Attributes:
   * - mcuPack: Everything needed to build an MCUpdater config.
   * - server: The completed server, with all dependencies.
   *
   * - clientConfigDir: A combined directory with all the client-propagated configuration.
   * - clientConfigs: Zipfiles and md5s for the above, one per zipdir.
   * - clientConfigsDir: That, as one directory.
   * - clientMods: Filtered manifest entries for the client.
   * - clientModsDir: The client's mods directory.
   *
   * - launcherDir: A derivation containing either Forge or Fabric.
   * - serverMods: Filtered manifest entries for the server.
   * - serverModsDir: The server's mods directory.
   */
  buildPack = self@{
    name,
    description ? name,
    tmuxName,
    serverName ? name,
    port,
    prometheusPort,
    minecraft,
    fabric ? null,
    forge ? null,
    neoforge ? null,
    cleanroom ? null,
    client-forge ? null,
    ram ? "4000m",
    manifest,
    blacklist ? [],
    extraDirs ? [],
    extraServerDirs ? [],
    extraClientDirs ? [],
  }: (self // rec {
    ## Client:
    clientMods = filterManifest {
      side = "client";
      inherit manifest;
    };

    clientModsDir = fetchMods clientMods;

    clientConfigDir = runLocally "${name}-client-config-debased" {
      buildInputs = [ xorg.lndir ];
      base = symlinkJoin {
        name = "${name}-client-config";
        paths = extraClientDirs ++ extraDirs;
      };
    } ''
      mkdir $out; cd $out
      lndir $base .
      mkdir base
      find -L . -maxdepth 1 -type f -exec mv {} base/ \;
    '';

    clientConfigs = builtins.listToAttrs (map (name: rec {
      inherit name;
      value = rec {
        zipDir = mkZipDir name "${clientConfigDir}/${name}";
        md5 = builtins.readFile "${zipDir}/${name}.md5";
        size = import "${zipDir}/${name}.size";
      };
    }) (builtins.attrNames (builtins.readDir clientConfigDir)));

    clientConfigsDir = symlinkJoin {
      name = "${name}-client-configs";
      paths = lib.mapAttrsToList (name: config: config.zipDir) clientConfigs;
    };

    mcuPack = linkFarm "${name}-pack" [
      { name = "pack.json"; path = writeJson "${name}-json" clientMods; }
      { name = "mods"; path = clientModsDir; }
      { name = "configs"; path = clientConfigsDir; }
    ];

    ## Server:
    launcherDir = let
      fabricDir = wrapDir "fabric" (fetchFabric {
        minecraft = minecraft;
        loader = fabric.loader;
        installer = fabric.installer;
      });
      forgeDir = wrapDir "forge" (if neoforge != null then fetchNeoForge neoforge 
                                  else if cleanroom != null then fetchCleanroom cleanroom
                                  else fetchForge forge
      );
    in if fabric != null then fabricDir else forgeDir;

    serverMods = filterManifest {
      side = "server";
      inherit manifest;
    };

    serverModsDir = fetchMods serverMods;

    server = symlinkJoin {
      name = name + "-server";

      inherit tmuxName ram serverName port prometheusPort;

      paths = [
        launcherDir
        (wrapDir "mods" serverModsDir)
        (callPackage ../tools/control {})
      ] ++ extraServerDirs ++ extraDirs;

      postBuild = ''
        cd $out
        for i in *.py *.sh *.service config/prometheus-integration.cfg *.txt; do
          substituteAll "$i" "$i".tmp
	  mv "$i".tmp "$i"
          chmod +x "$i"
        done
      '';
    };
  });

  fetchFabric = { minecraft, loader, installer }: runLocally "fabric-${minecraft}-${loader}-${installer}" {
    inherit minecraft loader installer;

    url = "https://meta.fabricmc.net/v2/versions/loader/${minecraft}/${loader}/${installer}/server/jar";

    # The installer needs web access. Since it does, let's download it w/o a
    # hash. We're using HTTPS anyway.
    #
    # If you get an error referring to this, you're probably using a strict
    # sandbox.  Disable it, or set it to 'relaxed'.
    __noChroot = 1;
    buildInputs = [ wget cacert ];
  } ''
    mkdir $out
    cd $out
    wget $url --ca-certificate=${cacert}/etc/ssl/certs/ca-bundle.crt --output-document=fabric-launcher.jar
  '';

  fetchForgeLike = { type, major, minor }: runLocally "forge-${major}-${minor}" {
    url =
      if type == "forge" && major == "1.7.10"
      then "https://files.minecraftforge.net/maven/net/minecraftforge/forge/${major}-${minor}-${major}/forge-${major}-${minor}-${major}-installer.jar"
      else if type == "forge"
      then "https://files.minecraftforge.net/maven/net/minecraftforge/forge/${major}-${minor}/forge-${major}-${minor}-installer.jar"
      else if type == "neoforge" && major == "1.20.1"
      then "https://maven.neoforged.net/releases/net/neoforged/forge/${major}-${minor}/forge-${major}-${minor}-installer.jar"
      else if type == "cleanroom"
      then "https://github.com/CleanroomMC/Cleanroom/releases/download/${major}-${minor}/cleanroom-${major}-${minor}-installer.jar"
      else "https://maven.neoforged.net/releases/net/neoforged/neoforge/${minor}/neoforge-${minor}-installer.jar";


    # The installer needs web access. Since it does, let's download it w/o a
    # hash. We're using HTTPS anyway.
    #
    # If you get an error referring to this, you're probably using a strict
    # sandbox.  Disable it, or set it to 'relaxed'.
    __noChroot = 1;
    buildInputs = [ jre wget cacert ];
  } ''
    mkdir $out
    cd $out
    wget $url --ca-certificate=${cacert}/etc/ssl/certs/ca-bundle.crt
    mkdir mods
    INSTALLER=$(echo *.jar)
    java -jar $INSTALLER --installServer
    rm -r $INSTALLER mods
  '';

  fetchForge = { major, minor }: fetchForgeLike { inherit major minor; type = "forge"; };
  fetchNeoForge = { major, minor }: fetchForgeLike { inherit major minor; type = "neoforge"; };
  fetchCleanroom = { major, minor }: fetchForgeLike { inherit major minor; type = "cleanroom"; };

  /**
   * Returns a list of mods, of the same format as in the manifest.
   */
  filterManifest = { side, manifest }: let
    allMods = builtins.fromJSON (builtins.readFile manifest);
    filteredMods = builtins.filter (mod: mod.side == side || mod.side == "both") allMods;
  in filteredMods;

  /**
   * Returns a derivation bundling all the given mods in a directory.
   */
  fetchMods = mods: let
    fetchMod = mod: fetchurl {
      curlOptsList = [ "-g" ];
      name = builtins.replaceStrings
        [" " "[" "]" "'"]
        ["_" "_" "_" "_"]
        mod.filename;
      url = mod.src;
      sha256 = mod.sha256;
    };
    modFile = mod: {
      name = mod.filename;
      path = fetchMod mod;
    };
  in linkFarm "manifest-mods" (builtins.map modFile mods);

  buildServerPack = {
    packs, hostname, urlBase
  }: runLocally "ServerPack" {
    packsJSON = builtins.toJSON packs;
    passAsFile = [ "packsJSON" "hostname" "urlBase" ];
  } ''
    ln -s ${./index.html} index.html
    ln -s ${./MCUpdater-recommended.jar} MCUpdater-Bootstrap.jar
    ${python3}/bin/python3 ${./make-serverpack.py} $packsJSONPath ${hostname} ${urlBase} $out
  '';

  # General utilities:
  /**
   * Writes a Nix value to a file, as JSON.
   */
  writeJson = name: tree: writeText name (builtins.toJSON tree);

  /*
   * Wraps a derivation with a directory.
   * Useful to give it a non-hashy name.
   */
  wrapDir = name: path: runCommand name {
    inherit name path;
    buildInputs = [ xorg.lndir ];
  } ''
    mkdir $out; cd $out
    if [[ -d "$path" ]]; then
      mkdir "$name"
      lndir "$path" "$name"
    else
      ln -s "$path" "${name}"
    fi
  '';

  /**
   * Concatenates a list of sets.
   */
  concatSets = builtins.foldl' (a: b: a // b) {};

  /**
   * Creates a directory containing a zipfile containing the source directory, plus hash.
   */
  mkZipDir = name: src: runLocally name {
    inherit name src;
    buildInputs = [ zip rsync ];
  } ''
    # This is fiddly because we want very badly to make the output depend only on file contents.
    mkdir $name $out
    rsync -aL $src/ $name/
    find $name -print0 | \
      xargs -0r touch -t 197001010000
    TZ=UTC find $name -print0 | sort -z | \
      xargs -0 zip -X --latest-time $out/${name}.zip
    md5=$(md5sum $out/${name}.zip | awk '{print $1}')
    echo -n $md5 > $out/${name}.md5
    stat -L -c %s $out/${name}.zip > $out/${name}.size
  '';

  /**
   * Unpacks a zipfile to a directory.
   */
   unpackZip = name: src: {
     exclude ? []
   }: runLocally name {
     inherit name src;
     buildInputs = [ unzip ];
     excludes = lib.concatMapStrings (x: "-x " + x) exclude;
   } ''
     mkdir $out
     cd $out
     unzip "$src" $excludes
   '';

  /**
   * URL-encodes a string, such as a filename.
   * This is still pretty slow.
   */
  urlencode = text: builtins.readFile (runLocally "urlencoded" {
    inherit text;
    passAsFile = [ "text" ];
    buildInputs = [ python3 ];
  } ''
    echo -e "import sys, urllib.request as ulr\nsys.stdout.write(ulr.pathname2url(sys.stdin.read()))" > program
    python3 program < $textPath > $out
  '');

  /**
   * Runs a command. Locally.
   */
  runLocally = name: env: cmd: runCommand name ({
    preferLocalBuild = true;
    allowSubstitutes = false;
  } // env) cmd;
}
