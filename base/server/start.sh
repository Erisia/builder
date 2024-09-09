#!/usr/bin/env nix-shell
#!nix-shell -i bash -p jre8 rsync tmux numactl

set -eum

BASE=$(dirname $0)
FORGE='forge/forge-*.jar'

fixperms() {
    if [[ ! -L $1 ]]; then
        find $1 -exec chmod a+r {} +
        find $1 -exec chmod u+w {} +
        find $1 -type d -exec chmod a+x {} +
    fi
}

tmux_session() {
  tmux display-message -p '#S' 2>&1
}


if [[ -z "${SKIP_TMUX:-}" ]]; then
    if [[ "$(tmux_session)" =~ "no server running on" ]]; then
        echo "Expected to run inside a tmux session named @tmuxName@."
        echo "Press enter if you know what you're doing, otherwise ctrl-c. Maintenance scripts will not be run."
        read
        EXTRAS=0
    elif [[ "$(tmux_session)" != "@tmuxName@" ]]; then
        echo "Expected to run inside a tmux session named @tmuxName@."
        echo "Actually running in $(tmux_session)"
        echo "Aborting."
        exit 1
    else
        EXTRAS=1
    fi
else
    EXTRAS=0
fi

# Yes, we delete everything on every startup.
# This is very much intended. To avoid redownloads, let's put anything that got downloaded
# into the pack definition in default.nix.
for f in $BASE/*; do
    b=$(basename $f)
    case "$b" in
        config | world)
            # Don't overwrite the config dir, because some mods cache data there.
            # Isn't this what the world dir is for, guys?
            # We also don't want to ovewrite world, as some mods store configs in world/serverconfigs and datapacks exist.
            # once again, isn't this what the configs dir is for, guys?
            rsync -acL server/$b .
            ;;
        start.sh)
            # Don't copy this script.
            continue
            ;;
        forge | resources)
	        # Overwrite the libraries dir, and symlink
            ln -sf "$f" .
            rsync -a "$f"/libraries .
            ;;
        *.properties | *.json)
            ## Copy, but only if nonexistent.
            [[ -e "$b" ]] || cp -aL "$f" "$b"
            ;;
        *)
            [[ -e "$b" ]] && fixperms "$b" && rm -rf "$b"
            cp -aL "$f" .
            ;;
    esac
    fixperms "$b"
done

rm -f gc.log

source scripts.sh

## Maintenance scripts ##
dailyRestart() {
    set +x
    while true; do
      sleep 45
      if [[ $(date +%R) = 06:00 ]]; then
        set -x
        ./stop.sh
        exit
      fi
      if [[ $(date +%R) = 18:00 ]]; then
        set -x
        ./stop.sh
        exit
      fi
    done
}

cleanup() {
    if [[ -n "$(jobs -p)" ]]; then
        echo 'Killing all subprocesses...'
        kill $(jobs -p) || true
        wait
    fi
}

antiChunkChurn() {
    set +e
    sleep 600
    while true; do
      sleep 60
      say 'save-on'
      say 'chunkpurge enable true'
      say 'chunkpurge delay 60'
      say 'save-all'
      sleep 10
      say 'chunkpurge delay 6000'
      sleep 20   #@saveTime@
      say 'chunkpurge enable false'
      say 'save-off'
      sleep 1800
    done
}

set -x

# TODO: Factor in scripts.sh, and other scripts.
if [[ $EXTRAS -eq 1 ]]; then
    trap cleanup EXIT
    dailyRestart &
#    antiChunkChurn &
fi

if [[ -e ~/web/deploy.sh ]]; then
    ~/web/deploy.sh
fi

if [[ -e logs/world.log ]]; then
  gzip -c logs/world.log >> logs/world.log.gz
  rm logs/world.log
fi

if [[ "${KILL_PROMETHEUS:-0}" = 1 ]]; then
  rm mods/prometheus-integration-*
fi

echo $$ > server.pid

if [[ -e fabric ]]; then
    # This is a Fabric server. Use newer Java.
    nix run nixpkgs#jre -- \
        "$@" \
        $(cat user_jvm_args.txt) \
        -jar fabric/fabric-launcher.jar nogui &
elif [[ -e forge/run.sh ]]; then
	# This is an 1.18+ server.
	# Use the provided run script. This implicitly invokes user_jvm_args, and works with newer Java.
	nix shell 'nixpkgs#jre' --command forge/run.sh &
elif find forge/ -name 'cleanroom*.jar' -printf 1 -quit | grep -q 1; then
    nix run nixpkgs#jre -- \
        "$@" \
        $(cat user_jvm_args.txt) \
        -jar forge/cleanroom-*.jar nogui &
else
	# 1.17 or below; invoke jar directly.
	java \
	  "$@" \
	  -XX:+UnlockExperimentalVMOptions \
	  -XX:+AggressiveOpts \
	  -XX:+UseG1GC \
	  -XX:G1HeapRegionSize=32M \
	  -XX:G1NewSizePercent=20 \
	  -XX:+UseAdaptiveGCBoundary \
	  $(cat user_jvm_args.txt) \
	  -jar $FORGE nogui &
fi

echo $! > server-jvm.pid
fg
