#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash pixz pv

set -ue

cd "$(dirname "$(readlink -f "$0")")"

pack() {
    EXCLUDE='backups crash-reports dynmap logs stall-reports *.nps *~'
    tar --exclude=backups --exclude=crash-reports --exclude=dynmap \
        --exclude=logs --exclude=stall-reports --exclude='*.nps' \
        --exclude='*~' --exclude='*.srp' --exclude="config/Discord-Integration.toml" \
        -c .
}

size() {
    # Not the most efficient possible impl.
    pack | wc -c
}

filename() {
    echo "$HOME/web/snapshots/@serverName@-snapshot.tar.xz"
}

echo "This script should only be used to create snapshots after the world is permanently shut down. The snapshot will be written to $(filename)." | fmt
echo

read -p 'Are you sure? ' -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    pack | pv -paes $(size) | pixz -9 > $(filename)
fi
