# Minebuild inspection bridge

E36 extraServerDirs includes base/e36-minebuild-server. Its stable artifact name
mods/minebuild-server.jar prevents accumulating versioned runtime jars during
startup rsync. The source lives in /home/svein/dev/minebuild; build with JDK25
and ./gradlew build, then copy build/libs/minebuild-server-0.1.0.jar here.

Initial source revision: d44720c3 (Minebuild repository).
Artifact SHA-256: 36d5e54eb297a6330fc10a7495330449a0a36a92428854a597d214627c5fce3f.
19 Java and 18 Python tests passed before staging. Packaging checks verify
client and server class separation. Both e36-server and serverPack Nix outputs
build successfully with this artifact.

The bridge is read-only: dimensions, registry descriptions, bounded resident
block/state/tile SNBT inspection. It binds 127.0.0.1:8766 and creates private
runtime credentials under config/minebuild-server. Never copy those credentials
into this source tree. See the Minebuild docs/server-api.md for limits and API.

The initial deployment target is only the disposable local copy at
/home/svein/dev/minebuild/server. Source inclusion alone does not install into
an already-running JVM. Production deployment has not been validated or performed.
