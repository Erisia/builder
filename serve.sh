#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash python3

set -eu

echo 'This script will serve the serverpack from http://localhost:8000/ServerPack.xml'
nix build -f . ServerPackLocal -o serverpack
(cd serverpack && python3 -m http.server)
rm serverpack
