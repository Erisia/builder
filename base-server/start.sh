#!/usr/bin/env nix-shell
#!nix-shell -i bash -p jre8 rsync screen

set -eu

BASE=$(dirname $0)
JAR=forge-*-universal.jar

fixperms() {
    find $1 -exec chmod a+r {} +
    find $1 -exec chmod u+w {} +
    find $1 -type d -exec chmod a+x {} +
}

if [[ -z ${STY:-} ]]; then
    echo "Expected to run inside a screen session named @screenName@."
    if [[ -z ${FORCE:-} ]]; then
        echo "Press enter if you know what you're doing, otherwise ctrl-c. Maintenance scripts will not be run."
        read
    fi
    EXTRAS=0
elif [[ ${STY##*.} != @screenName@ ]]; then
    echo "Expected to run inside a screen session named @screenName@."
    echo "Actually running in ${STY##*.}."
    echo "Aborting."
    exit 1
else
    EXTRAS=1
fi

# Yes, we delete everything on every startup.
# This is very much intended. To avoid redownloads, let's put anything that got downloaded
# into the pack definition in default.nix.
for f in $BASE/*; do
    b=$(basename $f)
    if [[ $b = "config" ]]; then
        # Except for the config dir, just because a lot of mods cache things there.
        # For some reason. Isn't this what the world dir is for, guys?
        rsync -aL server/config .
    elif [[ $b = "start.sh" ]]; then
        # Don't copy this script.
        continue
    else
        [[ -e $b ]] && fixperms $b && rm -rf $b
        cp -aL $f .
    fi
    fixperms $b
done

rm -f gc.log

say() {
  screen -S @screenName@ -p 0 -X stuff  "$@"`echo -ne '\015'`
}


## Maintenance scripts ##
dailyRestart() {
    while true; do
      sleep 45
      if [[ $(date +%R) = 06:00 ]]; then
        ./stop.sh
        exit
      fi
    done
}

cleanup() {
    if [[ -n "$(jobs -p)" ]]; then
        echo 'Killing all subprocesses...'
        kill $(jobs -p)
        wait
    fi
}

set -x

# TODO: Factor in scripts.sh, and other scripts.
if [[ $EXTRAS -eq 1 ]]; then
    trap cleanup EXIT
    dailyRestart &
fi

java -d64 -server -Xmx4000m \
  "$@" \
  -Djava.net.preferIPv4Stack=true \
  -Dfastcraft.asm.permissive=true \
  -XX:+AggressiveOpts \
  -XX:+UseG1GC \
  -XX:+UnlockExperimentalVMOptions \
  -XX:G1HeapRegionSize=32M \
  -XX:G1NewSizePercent=20 \
  -XX:+DisableExplicitGC -XX:MaxGCPauseMillis=500 \
  -XX:+UseAdaptiveGCBoundary \
  -XX:+StartAttachListener \
  -XX:+PrintGC -XX:+PrintGCTimeStamps -Xloggc:gc.log \
  -jar $JAR nogui
