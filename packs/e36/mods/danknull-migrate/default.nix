{ lib, runCommand, python3, jdk25, launcherDir }:
let
  source = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [ ./src ./build.py ];
  };
in runCommand "erisia-danknull-migrate-1.0.0" {
  nativeBuildInputs = [ python3 jdk25 ];
  meta.description = "Server-only migration of DankNull 1.7.91 contents to the 1.7.95+ format";
} ''
  python3 ${source}/build.py --launcher ${launcherDir}/forge --java-home ${jdk25.home} --output build
  mkdir -p "$out/mods"
  cp build/erisia-danknull-migrate-1.0.0.jar "$out/mods/"
''
