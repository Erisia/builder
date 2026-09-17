{ lib, runCommand, python3, jdk25, makeWrapper, launcherDir }:
let
  source = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [ ./src ./build.py ./test.py ];
  };
  launcher = "${launcherDir}/forge";
  mod = runCommand "erisia-live-inspector-0.1.0" {
    nativeBuildInputs = [ python3 jdk25 makeWrapper ];
    passthru.tests.integration = runCommand "erisia-live-inspector-integration" {} ''
      ${mod}/bin/test-live-inspector --work-dir "$TMPDIR/server"
      mkdir "$out"
      cp "$TMPDIR/server/test-result.txt" "$TMPDIR/server/console.log" "$out/"
      cp "$TMPDIR/server/frozen-before.json" "$TMPDIR/server/frozen-after.json" \
        "$TMPDIR/server/watch.json" "$out/"
    '';
    meta.description = "Read-only resident-world inspector for Cleanroom 0.6.12-alpha";
  } ''
    python3 ${source}/build.py --launcher ${launcher} --java-home ${jdk25.home} \
      --output build --with-tests
    mkdir -p "$out/mods" "$out/share/live-inspector-tests"
    cp build/erisia-live-inspector-0.1.0.jar "$out/mods/"
    cp build/erisia-live-inspector-tests-0.1.0.jar "$out/share/live-inspector-tests/"
    ln -s ../../mods/erisia-live-inspector-0.1.0.jar "$out/share/live-inspector-tests/"
    makeWrapper ${python3}/bin/python3 "$out/bin/test-live-inspector" \
      --add-flags "${source}/test.py --launcher ${launcher} --java-home ${jdk25.home} --build $out/share/live-inspector-tests"
  '';
in mod
