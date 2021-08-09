#!/usr/bin/env nix-shell
#!nix-shell -i bash -p jre8 rsync tmux numactl

set -eum

BASE=$(dirname $0)
JAR='forge/forge-*.jar'

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
        config)
            # Don't overwrite the config dir, because some mods cache data there.
            # Isn't this what the world dir is for, guys?
            rsync -acL server/config .
            ;;
        start.sh)
            # Don't copy this script.
            continue
            ;;
        forge | resources)
            # Don't copy at all.
            ln -sf "$f" .
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

numactl -m 0 -N 0 \
java -d64 -server -Xms@ram@ -Xmx@ram@ \
  "$@" \
  -Djava.net.preferIPv4Stack=true \
  -Dfml.readTimeout=1800 \
  -Dfml.loginTimeout=36000 \
  -Dfml.doNotBackup=true \
  -XX:+AggressiveOpts \
  -XX:+UseTransparentHugePages \
  -XX:+AlwaysPreTouch \
  -XX:+UseG1GC \
  -XX:+UnlockExperimentalVMOptions \
  -XX:G1HeapRegionSize=32M \
  -XX:G1NewSizePercent=20 \
  -XX:+DisableExplicitGC -XX:MaxGCPauseMillis=500 \
  -XX:+UseAdaptiveGCBoundary \
  -XX:+StartAttachListener \
  -XX:+PrintGC -XX:+PrintGCTimeStamps -Xloggc:gc.log \
  -XX:SymbolTableSize=1M \
  -XX:StringTableSize=1M \
  -XX:+PrintStringTableStatistics \
  -jar $JAR nogui &

echo $! > server-jvm.pid
fg
