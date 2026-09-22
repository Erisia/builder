# Minebuild inspection and optional edit bridge

E36 extraServerDirs includes base/e36-minebuild-server. Its stable artifact name
mods/minebuild-server.jar prevents accumulating versioned runtime jars during
startup rsync. Source: /home/svein/dev/minebuild; build with JDK25 and ./gradlew build,
then copy build/libs/minebuild-server-0.1.0.jar here.

Source revision: 9b743da7 (Minebuild repository).
Artifact SHA-256: 11f17e1c42902609b7a5d233594cb3b714348a817f730f917edf68adf26edf99.
49 Java and 62 Python tests passed. Isolated Cleanroom .12 tests verified block,
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

This artifact also preserves NuclearCraft 2.18r's exact default tile radiation
capability. Unknown, nondefault, or differently typed capabilities remain
unsupported. See the Minebuild docs/edit-api.md for the narrow data contract.
