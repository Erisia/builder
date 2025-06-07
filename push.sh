#!/usr/bin/env bash

set -e

echo "This script will push the currently checked-out (and named) commit as master."
echo "Press ctrl-c if this isn't intended"
read

jj b s master -r 'latest(ancestors(@) & ~empty() & ~description(exact:""))'
jj git push
