# Minebuild inspection and optional edit bridge

E36 extraServerDirs includes base/e36-minebuild-server. Its stable artifact name
mods/minebuild-server.jar prevents accumulating versioned runtime jars during
startup rsync. Source: /home/svein/dev/minebuild; build with JDK25 and ./gradlew build,
then copy build/libs/minebuild-server-0.1.0.jar here.

Source revision: e20b933b (Minebuild repository).
Artifact SHA-256: 9b2ec581ea0f748275f238f3234bf8377ee570f2d8744f87552719f09bd3e18b.
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

The current artifact adds permanent named build sections and revision-checked
metadata APIs, independently of edit enablement and journal capacity. Section
records are never expired or garbage-collected, including completed/released
ones. Keep minebuild-sections/ alongside minebuild-world-id in save backups.
See Minebuild docs/sections-api.md and docs/sections-validation-isolated.md.
The isolated .12 check retained 109 sections across restart, tested CAS/retries,
pagination, overlap reporting and world binding without any block writes.
This artifact also includes the separately validated straight-bottom stair adapter.
Read-only defaults refer to blocks; authenticated section metadata is writable.
