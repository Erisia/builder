#!/usr/bin/env bash

set -eu -o pipefail

cd "$(readlink -f "$(dirname "$0")")"

while true; do
	(set -m; exec ./update-and-start.sh)
	echo 'Waiting 5 seconds before restart'
	sleep 5
done
