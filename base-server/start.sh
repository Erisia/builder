#!/usr/bin/env nix-shell
#!nix-shell -i bash -p jdk rsync --pure

set -eux

BASE=$(dirname $0)
JAR=forge-universal.jar

fixperms() {
    find $1 -exec chmod a+r {} +
    find $1 -exec chmod u+w {} +
    find $1 -type d -exec chmod a+x {} +
}

# Yes, we delete everything on every startup.
# This is very much intended. To avoid redownloads, let's put anything that got downloaded
# into the pack definition in default.nix.
for f in $BASE/*; do
    b=$(basename $f)
    if [[ $b = "config" ]]; then
        # Except for the config dir, just because a lot of mods cache things there.
        # For some reason. Isn't this what the world dir is for, guys?
        rsync -a server/config .
    elif [[ $b = "start.sh" ]]; then
        # Don't copy this script.
        true
    else
        [[ -e $b ]] && fixperms $b && rm -rf $b
        cp -aL $f .
    fi
    fixperms $b
done

exec java -d64 -server -Xmn512m -Xms1g -Xmx10g \
  -Djava.net.preferIPv4Stack=true \
  -Dfastcraft.asm.permissive=true \
  -XX:+AggressiveOpts \
  -XX:+UseG1GC \
  -XX:+DisableExplicitGC -XX:MaxGCPauseMillis=150 -XX:SurvivorRatio=8 \
  -XX:TargetSurvivorRatio=85 -XX:+UseAdaptiveGCBoundary \
  -XX:+StartAttachListener \
  -jar $JAR nogui
