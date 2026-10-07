#!/usr/bin/env bash

cd "$(dirname "$(readlink -f "$0")")"

exec server/bin/control @tmuxName@ "$@"
