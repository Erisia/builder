# Slime Stomach: server-side only. The jar is prebuilt from ./source (commit e674ccf) with
# Gradle/RetroFuturaGradle, which needs network access, so it is pinned here by hash instead.
# ./history.bundle holds the original git history (`git clone history.bundle`).
{ runCommand }:
runCommand "slimestomach-1.0.0" {
  meta.description = "Big slimes swallow players into a stomach in a private void dimension";
} ''
  echo "60c371f122a1cb7158c904939a0468936d57c49f984835297c89f0a91106e185  ${./slimestomach-1.0.0.jar}" | sha256sum -c -
  mkdir -p "$out/mods"
  cp ${./slimestomach-1.0.0.jar} "$out/mods/slimestomach-1.0.0.jar"
''
