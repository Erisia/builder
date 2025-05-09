{ builder ? import ./default.nix
, pkgs ? (import ../nixpkgs {}).pkgs
}:

let
  packs = (import ../.).packs;

  smokeTest = pack: pkgs.runCommandLocal "smoketest" {
    server = pack.server;
    world = ./testdata/SmokeTest.tar.gz;
    props = ./testdata/server.properties;
    buildInputs = with pkgs; [ jre8 rsync procps psmisc tmux ];

    # Enable web access
    __noChroot = 1;
  } ''
    set -e

    ln -s $server server
    tar xvzf $world
    cat $props > server.properties
    echo -n server-port= >> server.properties
    id -u | ${pkgs.bc}/bin/dc -e '? 1000 % 30000 + p' >> server.properties
    cat server.properties

    echo 'eula=true' > eula.txt

    export SKIP_TMUX=1
    export KILL_PROMETHEUS=1

    echo | timeout -s 9 900 bash server/start.py -Dfml.queryResult=confirm &
    sleep 3

    terminate() {
      echo 'Exiting.'
      set +e
      pgrep -s 0 | grep -v "^$$$" | xargs kill
      set -e
      echo 'Exited.'
    }

    time=0
    while true; do
      grep 'Task Failed Successfully' logs/latest.log && {
        echo 'Smoke test successful. Exiting.'
        terminate
        cp logs/latest.log $out
        exit 0
      }
      ps -u $UID | grep -q java || {
        echo 'Java process unexpectedly terminated'
	exit 1
      }
      time=$(($time + 1))
      if [[ $time -gt 1000 ]]; then
        echo 'Exiting with timeout'
        terminate
        exit 1
      fi
      sleep 1
    done
  '';
in

pkgs.lib.mapAttrs (name: pack: smokeTest pack) packs
