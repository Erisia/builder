#!/usr/bin/env bash

set -eu
GITDIR="$(dirname "$(readlink -f "$0")")"

if [ -z "${FORCE:-}" -a ! \( -d world -a -d mods -a -d server \) ]; then
    echo "$(pwd) doesn't look like a Minecraft server directory."
    echo "Are you sure you want to setup a server in it?"
    echo "Press return to continue, ctrl-c to abort."
    read
fi

# Link in this script, for later use.
ln -sf $GITDIR/update-and-start.sh .

if [[ ! -f server.nix-target ]]; then
    SERVERS=$(nix-instantiate --eval --strict -E "builtins.attrNames (import \"$GITDIR\").packs" | sed -r 's/(["[]|\])//g')
    echo "Which server do you want to build?"
    select server in $SERVERS; do
        echo $server > server.nix-target
        break
    done
fi

# Start the server.
nix-build $GITDIR -A "packs.$(cat server.nix-target).server" -o server --show-trace
nix-build $GITDIR -A ServerPack -o pack --show-trace

exec server/start.py
