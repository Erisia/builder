{ lib, runCommand, python3, jdk25, launcherDir }:
let
  source = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [ ./src ./build.py ];
  };
in runCommand "erisia-stepheight-fix-1.0.0" {
  nativeBuildInputs = [ python3 jdk25 ];
  meta.description = "Server-only: restores vanilla's 1.0 server-side player step height that Chibi lowers to 0.7";
} ''
  python3 ${source}/build.py --launcher ${launcherDir}/forge --java-home ${jdk25.home} --output build
  mkdir -p "$out/mods"
  cp build/erisia-stepheight-fix-1.0.0.jar "$out/mods/"
''
