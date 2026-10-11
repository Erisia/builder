{ lib, runCommand, python3, jdk25, launcherDir }:
let
  source = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [ ./src ./build.py ];
  };
in runCommand "erisia-stepheight-fix-1.1.0" {
  nativeBuildInputs = [ python3 jdk25 ];
  meta.description = "Server-only: undoes Chibi's 0.7 player step height and lifts AS Step Assist from its 1.1 floor back to 1.5";
} ''
  python3 ${source}/build.py --launcher ${launcherDir}/forge --java-home ${jdk25.home} --output build
  mkdir -p "$out/mods"
  cp build/erisia-stepheight-fix-1.1.0.jar "$out/mods/"
''
