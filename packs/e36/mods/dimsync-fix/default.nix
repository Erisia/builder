{ lib, runCommand, python3, jdk25, launcherDir }:
let
  source = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [ ./src ./build.py ];
  };
in runCommand "erisia-dimsync-fix-1.0.0" {
  nativeBuildInputs = [ python3 jdk25 ];
  meta.description = "Server-only: resends player attributes, abilities and health after a dimension change (NetherPortalFix skips them)";
} ''
  python3 ${source}/build.py --launcher ${launcherDir}/forge --java-home ${jdk25.home} --output build
  mkdir -p "$out/mods"
  cp build/erisia-dimsync-fix-1.0.0.jar "$out/mods/"
''
