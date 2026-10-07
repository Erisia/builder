#!/usr/bin/env nix-shell
#!nix-shell -i bash -p jdk

set -em

cd "$(dirname "$(readlink -f "$0")")"
./control.sh check

java \
  -Djava.library.path=${JAVA_HOME}/jre/bin \
  -cp ${JAVA_HOME}/lib/tools.jar:warmroast-1.0.0-SNAPSHOT.jar \
  com.sk89q.warmroast.WarmRoast --thread "Server thread" \
  --mappings ${HOME}/src/mcp/conf \
  --pid $(cat server-jvm.pid) &

sleep 2

echo
echo "============================="
echo "Profile will be available on https://warmroast.brage.info/"
echo "============================="
echo

fg
