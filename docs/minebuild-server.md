# Minebuild inspection and optional edit bridge

E36 extraServerDirs includes base/e36-minebuild-server. Its stable artifact name
mods/minebuild-server.jar prevents accumulating versioned runtime jars during
startup rsync. Source: /home/svein/dev/minebuild; build with JDK25 and ./gradlew build,
then copy build/libs/minebuild-server-0.1.0.jar here.

Source revision: fdee219e (Minebuild repository).
Artifact SHA-256: 4b0c132f290f00f85fdf8003107ee7e9611b6d1081529613a02412cd608c218c.
46 Java and 52 Python tests passed. Isolated Cleanroom .12 tests verified block,
empty chest and sign restoration, conflict-aware undo, retries, and durable
history plus undo after restart. See Minebuild docs/edit-validation-isolated.md.

Default mode remains read-only: dimensions, registry descriptions, bounded
resident block/state/tile SNBT inspection. The bridge binds 127.0.0.1:8766 and
creates private runtime credentials under config/minebuild-server. Never copy
credentials into this source tree. See Minebuild docs/server-api.md and docs/edit-api.md.

Only the disposable local copy at /home/svein/dev/minebuild/server opts into
editing, through its runtime user_jvm_args.txt: -Dminebuild.server.edits=true.
This source tree does not enable editing by default. Edit journals and the
stable world identity reside inside the actual world save. Preserve both with
world backups. The initial adapter accepts a restricted vanilla material set.

Source inclusion alone does not install into an already-running JVM.
Production deployment has not been validated or performed.
