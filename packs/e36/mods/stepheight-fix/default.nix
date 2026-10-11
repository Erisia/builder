{ lib, runCommand, python3, jdk25, launcherDir }:
let
  source = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [ ./src ./build.py ];
  };
in runCommand "erisia-stepheight-fix-2.0.0" {
  nativeBuildInputs = [ python3 jdk25 ];
  meta.description = "Server-only: mixin making AS Step Assist give at least 1.5 step height; undoes Chibi's 0.7 base";
} ''
  python3 ${source}/build.py --launcher ${launcherDir}/forge --java-home ${jdk25.home} --output build
  mkdir -p "$out/mods"
  cp build/erisia-stepheight-fix-2.0.0.jar "$out/mods/"
''
