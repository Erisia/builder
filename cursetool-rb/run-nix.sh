#!/usr/bin/env bash

set -e

DIR="$(dirname "$(readlink -f "$0")")"
nix-shell $DIR/default.nix --run "ruby -W0 $DIR/exe/cursetool-rb $@"
