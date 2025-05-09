#!/usr/bin/env nix-shell
#!nix-shell -i bash -p hugo

set -e
cd $(dirname $0)
hugo server --bind=0.0.0.0 --port=1313