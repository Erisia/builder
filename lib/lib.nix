{ stdenv, symlinkJoin, runCommand, linkFarm, fetchurl, callPackage, writeText
, cacert, jre, wget, zip, rsync, saxonb, python3, lib, lndir
}:
with stdenv;

rec {
  launcherLock = builtins.fromJSON (builtins.readFile ../launcher-lock.json);

  fetchFabric = { minecraft, loader, installer }: let
    key = "${minecraft}-${loader}-${installer}";
    locked = launcherLock.fabric.${key};
    launcher = fetchurl {
      name = "fabric-${key}-launcher.jar";
      inherit (locked) url sha256;
    };
  in runCommand "fabric-${key}" {
    inherit launcher;
  } ''
    mkdir $out
    cp $launcher $out/fabric-launcher.jar
  '';

  fetchVanilla = { minecraft }: let
    locked = launcherLock.vanilla.${minecraft};
    serverJar = fetchurl {
      name = "minecraft-server-${minecraft}.jar";
      inherit (locked) url sha256;
    };
  in runCommand "vanilla-${minecraft}" {
    inherit serverJar;
  } ''
    mkdir $out
    cp $serverJar $out/server.jar
  '';

  fetchForgeLike = { type, major, minor }: let
    lockType =
      if type == "forge" then "forge"
      else if type == "neoforge" then "neoforge"
      else "cleanroom";
    key = "${major}-${minor}";
    locked = launcherLock.${lockType}.${key};
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
  in runCommand "${type}-${major}-${minor}" {
    url = locked.installerUrl or url;
    buildInputs = [ jre wget cacert ];
    preferLocalBuild = true;
    allowSubstitutes = false;
    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = locked.outputHash;
  } ''
    mkdir $out
    cd $out
    wget $url --ca-certificate=${cacert}/etc/ssl/certs/ca-bundle.crt
    mkdir mods
    INSTALLER=$(echo *.jar)
    export _JAVA_OPTIONS="-Djava.net.preferIPv4Stack=true -Djava.net.preferIPv6Addresses=false ''${_JAVA_OPTIONS:-}"
    for attempt in 1 2 3; do
      if java -jar $INSTALLER --installServer; then
        break
      fi
      if [ "$attempt" = 3 ]; then
        exit 1
      fi
      sleep $((attempt * 5))
    done
    rm -r $INSTALLER mods
    rm -f *.log
  '';

  fetchForge = { major, minor }: fetchForgeLike { inherit major minor; type = "forge"; };
  fetchNeoForge = { major, minor }: fetchForgeLike { inherit major minor; type = "neoforge"; };
  fetchCleanroom = { major, minor }: fetchForgeLike { inherit major minor; type = "cleanroom"; };

  /**
   * Cleanroom's own Prism/MultiMC template (mmc-pack.json + patches/), pinned in launcher-lock.json
   * and mirrored on madoka. Prism builds a Cleanroom instance from it; lib/prism.nix starts from it.
   */
  fetchCleanroomPrismTemplate = { major, minor }: let
    locked = launcherLock.cleanroom."${major}-${minor}";
  in fetchurl {
    name = "cleanroom-${major}-${minor}-prism-template.zip";
    urls = locked.prismTemplateUrls;
    hash = locked.prismTemplateHash;
  };

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

  /**
   * The MCUpdater ServerPack: ServerPack.xml, the bootstrap jar and packs/<id>/{mods,configs};
   * plus prism/<id>/, each pack's Prism-native pack and instance zip.
   * It sees only each pack's `client` descriptor, so building it never builds a server.
   */
  buildServerPack = {
    packs, hostname, urlBase
  }: runLocally "ServerPack" {
    packsJSON = builtins.toJSON (lib.mapAttrs (id: pack: pack.client) packs);
    passAsFile = [ "packsJSON" "hostname" "urlBase" ];
  } ''
    ln -s ${./index.html} index.html
    ln -s ${./MCUpdater-recommended.jar} MCUpdater-Bootstrap.jar
    ${python3}/bin/python3 ${./make-serverpack.py} $packsJSONPath ${hostname} ${urlBase} $out
    # The Prism-native packs (lib/prism.nix), beside the MCUpdater files, which they don't touch.
    mkdir $out/prism
    ${lib.concatStrings (lib.mapAttrsToList (id: pack: ''
      ln -s ${pack.prism "${urlBase}prism/${id}/"} $out/prism/${id}
    '') packs)}
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
    buildInputs = [ lndir ];
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
   * Zips each top-level directory of src into one output directory: <dir>.zip, <dir>.md5 and
   * <dir>.size for every dir. The list of dirs is only known at build time, which keeps
   * evaluation from building anything. The zips depend only on file contents: fixed mtimes,
   * sorted entries, no extra attributes.
   */
  mkZipDirs = name: src: runLocally name {
    inherit src;
    buildInputs = [ zip rsync ];
  } ''
    mkdir $out
    for dir in $(cd -L $src && find -L . -mindepth 1 -maxdepth 1 -type d -printf '%P\n' | LC_ALL=C sort); do
      rsync -aL $src/$dir/ $dir/
      find $dir -print0 | \
        xargs -0r touch -t 197001010000
      TZ=UTC find $dir -print0 | sort -z | \
        xargs -0 zip -X --latest-time $out/$dir.zip
      md5=$(md5sum $out/$dir.zip | awk '{print $1}')
      echo -n $md5 > $out/$dir.md5
      stat -L -c %s $out/$dir.zip > $out/$dir.size
    done
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
