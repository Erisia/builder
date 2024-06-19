{ builder ? import ./default.nix
, pkgs ? (import ../nixpkgs {}).pkgs
}:

let
  packs = (import ../.).packs;

  # “e” stands for “executable”.
  # Attribute name is executable name.
  # Attribute value is an escaped full path in Nix store to an executable.
  # For instance { dc = "'/nix/store/…-bc-…/bin/dc'"; }
  e = builtins.mapAttrs (n: v: pkgs.lib.escapeShellArg "${v}/bin/${n}") {
    cat = pkgs.coreutils;
    cp = pkgs.coreutils;
    id = pkgs.coreutils;
    ln = pkgs.coreutils;
    sleep = pkgs.coreutils;
    timeout = pkgs.coreutils;

    dc = pkgs.bc;
    grep = pkgs.gnugrep;
    tar = pkgs.gnutar;
    xargs = pkgs.findutils;

    pgrep = pkgs.procps;
    ps = pkgs.procps;
  };

  guardDependencies =
    builtins.concatStringsSep "\n" (map (executable: ''
      if ! [[ -r ${executable} ]] || ! [[ -e ${executable} ]]; then
        >&2 printf 'Executable "%s" is not found!\n' ${executable}
        exit 1
      fi
    '') (builtins.attrValues e));

  smokeTest = pack: pkgs.runCommandLocal "smoketest" {
    server = pack.server;
    world = ./testdata/SmokeTest.tar.gz;
    props = ./testdata/server.properties;
    buildInputs = with pkgs; [ jre8 rsync tmux ];

    # Enable web access
    __noChroot = 1;
  } ''
    set -Eeuo pipefail || exit

    # Guard dependencies first
    ${guardDependencies}

    ${e.ln} -s -- "$server" server
    ${e.tar} -xvz --file="$world"
    ${e.cat} -- "$props" > server.properties
    echo -n server-port= >> server.properties
    ${e.id} -u | ${e.dc} -e '? 1000 % 30000 + p' >> server.properties
    ${e.cat} server.properties

    echo 'eula=true' > eula.txt

    export SKIP_TMUX=1
    export KILL_PROMETHEUS=1

    echo | ${e.timeout} -s 9 900 bash server/start.sh -Dfml.queryResult=confirm &
    ${e.sleep} 3

    terminate() {
      set -Eeuo pipefail || exit
      echo 'Exiting.'
      ${e.pgrep} -s 0 | (${e.grep} -v "^$$$" || true) | ${e.xargs} kill
      echo 'Exited.'
    }

    time=0
    while true; do
      if ${e.grep} 'Task Failed Successfully' logs/latest.log; then
        echo 'Smoke test successful. Exiting.'
        terminate
        ${e.cp} logs/latest.log -- "$out"
        exit 0
      fi
      if ! ${e.ps} -u "$UID" | ${e.grep} -q java; then
        >&2 echo 'Java process unexpectedly terminated'
        exit 1
      fi
      time=$(( time + 1 ))
      if (( time > 1000 )); then
        >&2 echo 'Exiting with timeout'
        >&2 terminate
        exit 1
      fi
      ${e.sleep} 1
    done
  '';
in

pkgs.lib.mapAttrs (name: pack: smokeTest pack) packs
