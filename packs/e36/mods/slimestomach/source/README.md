# Slime Stomach (Forge 1.12.2 / Cleanroom, server-side only)

Big slimes swallow players into a small organic stomach in a private void dimension. Someone else kills the slime to get
them out; breaking the wall makes it fill with gastric juice that digests them (the grave lands where the slime is).

## Install
Drop `slimestomach-1.0.0.jar` in the server's `mods/`. Clients need nothing: no blocks/items are registered, and the
stomach dimension (default ID 7355) uses the vanilla OVERWORLD type. Needs Tinkers' Construct for the default themes
(congealed slime walls, liquid blue slime); falls back to vanilla blocks/water if missing.
Check first that dimension 7355 is free (it was in e36 on 2026-09-28); otherwise set `stomachDimension`.

## Behaviour
- Right-click a slime / Tinkers blue slime / magma cube of size >= 4, or get hurt by one (1/6 chance): swallowed.
  The slime is renamed "Stomach of <player>", persistent, and the server announces its position.
- Slime dies (or vanishes): everyone inside comes out where it was (offline players on next login), with 5 s of
  invulnerability; the stomach is demolished.
- Breaking a wall/glowstone block starts the juice rising (a layer per 5 s). Damage: 1 HP/s x blocks broken, doubling every
  10 s, ignoring armor/Protection/Resistance and shields. The last bite teleports you to the slime and kills you there.
- Inside, only digestion hurts; Mining Fatigue III; no beds/spawn points. Leaving via /home etc. counts as escaping.
- Anyone found in the stomach dimension without a stomach is sent to overworld spawn.

## Admin
`/slimestomach list | release <player> | releaseall` (op level 2). Config: `config/slimestomach.cfg` (themes, chances,
damage, timings). Logs lines tagged `[Slime Stomach]` for every swallow, digestion, release and demolition.

## Build
Gradle (CleanroomMC TemplateDevEnv + RetroFuturaGradle). Needs network on first build (Mojang jars, MCP mappings,
Forge userdev), JDK 8 and JDK 21 toolchains, and a JDK 17+ to run Gradle 9.7:
`JAVA_HOME=<jdk25> ./gradlew build` -> `build/libs/slimestomach-1.0.0.jar` (reobfuscated to SRG).
Toolchain paths are set in gradle.properties (`org.gradle.java.installations.paths`); adjust for your machine.
