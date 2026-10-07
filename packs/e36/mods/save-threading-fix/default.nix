{ lib, runCommand, python3, jdk25, makeWrapper, launcherDir }:
let
  source = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [ ./src ./build.py ./test.py ];
  };
  launcher = "${launcherDir}/forge";
  mod = runCommand "erisia-save-threading-0.1.0" {
    nativeBuildInputs = [ python3 jdk25 makeWrapper ];
    passthru.tests.integration = runCommand "erisia-save-threading-integration" {} ''
      ${mod}/bin/test-save-threading --work-dir "$TMPDIR/server"
      mkdir "$out"
      cp "$TMPDIR/server/test-result.txt" "$TMPDIR/server/console.log" "$out/"
    '';
    meta.description = "Experimental server save threading fix for Cleanroom 0.6.12-alpha";
  } ''
    python3 ${source}/build.py --launcher ${launcher} --java-home ${jdk25.home} \
      --output build --with-tests
    mkdir -p "$out/mods" "$out/share/save-threading-tests"
    cp build/erisia-save-threading-0.1.0.jar "$out/mods/"
    cp build/erisia-save-threading-tests-0.1.0.jar "$out/share/save-threading-tests/"
    ln -s ../../mods/erisia-save-threading-0.1.0.jar "$out/share/save-threading-tests/"
    makeWrapper ${python3}/bin/python3 "$out/bin/test-save-threading" \
      --add-flags "${source}/test.py --launcher ${launcher} --java-home ${jdk25.home} --build $out/share/save-threading-tests"
  '';
in mod
