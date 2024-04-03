#!/usr/bin/env bash

cd "$(dirname "$(readlink -f "$0")")"

exec ./control.sh stop --lazy 6 "$@"
