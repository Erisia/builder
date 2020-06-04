{ stdenv, symlinkJoin, runCommand, linkFarm, fetchurl, callPackage, writeText
, xorg, cacert, jre, wget, zip, rsync, saxonb, python
}:
with stdenv;

rec {

  /**
   * Extends a pack definition with all its derivations.
   *
   * Attributes:
   * - mcuPack: Everything needed to build an MCUpdater config.
   * - cursePack: A Curse zipfile. (TODO)
   * - server: The completed server, with all dependencies.
   *
   * - clientConfigDir: A combined directory with all the client-propagated configuration.
   * - clientConfigs: Zipfiles and md5s for the above, one per zipdir.
   * - clientConfigsDir: That, as one directory.
   * - clientMods: Filtered manifest entries for the client.
   * - clientModsDir: The client's mods directory.
   *
   * - forgeDir: A derivation containing the Forge server.
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
    forge,
    ram ? "4000m",
    manifests ? [],
    blacklist ? [],
    extraDirs ? [],
    extraServerDirs ? [],
    extraClientDirs ? [],
  }: (self // rec {
    ## Client:
    clientMods = filterManifests {
      side = "client";
      inherit manifests blacklist;
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
    forgeDir = wrapDir "forge" (fetchForge forge);

    serverMods = filterManifests {
      side = "server";
      inherit manifests blacklist;
    };

    serverModsDir = fetchMods serverMods;

    server = symlinkJoin {
      name = name + "-server";

      inherit tmuxName ram serverName port prometheusPort;

      paths = [
        forgeDir
        (wrapDir "mods" serverModsDir)
        (callPackage ../tools/control {})
      ] ++ extraServerDirs ++ extraDirs;

      postBuild = ''
        cd $out
        for i in *.sh *.service config/prometheus-integration.cfg; do
          substituteAll "$i" "$i".tmp
	  mv "$i".tmp "$i"
          chmod +x "$i"
        done
      '';
    };
  });

  fetchForge = { major, minor }: runLocally "forge-${major}-${minor}" {
    inherit major minor;

    url = {
      "1.7.10" = "https://files.minecraftforge.net/maven/net/minecraftforge/forge/${major}-${minor}-${major}/forge-${major}-${minor}-${major}-installer.jar";
      "1.10.2" = "https://files.minecraftforge.net/maven/net/minecraftforge/forge/${major}-${minor}/forge-${major}-${minor}-installer.jar";
      "1.12.2" = "https://files.minecraftforge.net/maven/net/minecraftforge/forge/${major}-${minor}/forge-${major}-${minor}-installer.jar";
    }.${major};

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

  /**
   * Returns a set of mods, of the same format as in the manifest.
   */
  filterManifests = { side, manifests, blacklist }: let
    allMods = concatSets (map (f: (import f).mods) manifests);
    filteredMods = lib.filterAttrs (n: mod:
        (mod.side == "both" || mod.side == side) &&
        mod.type != "missing" &&
        !(builtins.any (b: b == n) blacklist)
      ) allMods;
    byProjectId = lib.mapAttrs' (name: info: lib.nameValuePair (toString info.projectID or name) { inherit name info; }) filteredMods;
    byNameAgain = lib.mapAttrs' (name: bundle: lib.nameValuePair bundle.name bundle.info) byProjectId;
  in
    byNameAgain;

  /**
   * Returns a derivation bundling all the given mods in a directory.
   */
  fetchMods = mods: let
    fetchMod = info: rec {
      local = info.src;
      remote = fetchurl {
        name = builtins.replaceStrings
          [" " "[" "]" "'"]
          ["_" "_" "_" "_"]
          info.filename;
        url = info.src;
        sha256 = info.sha256;
      };
    }.${info.type};
    modFile = name: mod: {
      name = mod.filename;
      path = fetchMod mod;
    };
  in
    linkFarm "manifest-mods" (lib.mapAttrsToList modFile mods);

  buildServerPack = {
    packs, hostname, urlBase
  }: let
    combinedPack = linkFarm "combined-packs" (lib.mapAttrsToList packDir packs);
    packDir = name: pack: { inherit name; path = pack.mcuPack; };
    /* This bit of craziness provides all the parameters to serverpack.xsl */
    packParams = name: pack: let revless = rec {
      packUrlBase = urlBase + "packs/" + urlencode name + "/";
      serverId = name;
      serverDesc = pack.description or name;
      serverAddress = hostname + ":" + toString pack.port;
      minecraftVersion = pack.forge.major;
      forgeVersion = "${pack.forge.major}-${pack.forge.minor}";
      configs = lib.mapAttrs (name: config: {
        configId = "config-" + name;
        url = packUrlBase + "configs/" + urlencode name + ".zip";
        md5 = config.md5;
        size = config.size;
      }) pack.clientConfigs;
      mods = lib.mapAttrs (name: mod: {
        modId = name;
        name = mod.title or name;
        isDefault = mod.default or true;
        md5 = mod.md5;
        modpath = "mods/" + mod.filename;
        modtype = mod.modType or "Regular";
        required = mod.required or true;
        side = mod.side or "BOTH";
        size = mod.size;
        url = packUrlBase + "mods/" + mod.encoded;
      }) pack.clientMods;
    }; in revless // {
      revision = builtins.hashString "sha256" (builtins.toXML revless);
    };
    packFile = runLocally "ServerPack.xml" {
      buildInputs = [ saxonb ];
      stylesheet = ./serverpack.xsl;
      paramsText = writeText "params.xml" (builtins.toXML (lib.mapAttrs packParams packs));
    } ''
      saxonb $paramsText $stylesheet > $out
    '';
    preconfiguredMCUpdater = runLocally "Preconfigured-MCUpdater" {
      mcupdater = ./MCUpdater-recommended.jar;
      buildInputs = [ zip ];
    } ''
      cat >> config.properties <<EOF
        bootstrapURL = https://files.mcupdater.com/Bootstrap.xml
        distribution = Release
        defaultPack = ${urlBase}ServerPack.xml
        customPath =
        passthroughArgs = -defaultMem 3G
      EOF
      cp $mcupdater MCUpdater.jar
      chmod u+w MCUpdater.jar
      zip MCUpdater.jar -X --latest-time config.properties
      mv MCUpdater.jar $out
    '';
  in linkFarm "ServerPack" [
    { name = "index.html"; path = ./index.html; }
    { name = "packs"; path = combinedPack; }
    { name = "ServerPack.xml"; path = packFile; }
    { name = "params.xml"; path = packFile.paramsText; }
    { name = "MCUpdater-Bootstrap.jar"; path = preconfiguredMCUpdater; }
  ];

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
    buildInputs = [ python ];
  } ''
    echo -e "import sys, urllib as ul\nsys.stdout.write(ul.pathname2url(sys.stdin.read()))" > program
    python program < $textPath > $out
  '');

  /**
   * Runs a command. Locally.
   */
  runLocally = name: env: cmd: runCommand name ({
    preferLocalBuild = true;
    allowSubstitutes = false;
  } // env) cmd;
}
