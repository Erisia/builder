# Code-quality check for the files that have been brought up to the builder's standard.
#
# Produces: one derivation (`checks.quality`) that fails on the first problem found:
#   - Nix: nixfmt formatting, statix lints, deadnix (unused bindings).
#   - Python: ruff lint and formatting, mypy --strict, and the files' unit tests.
# Consumers: the flake's checks.
#
# The lists below name files explicitly. Each restructure phase adds the files it rewrites, so
# the older code isn't reformatted in one huge, unreviewable diff. A file on these lists must
# pass every tool.
{ pkgs }:
let
  inherit (pkgs) lib;

  nixFiles = [
    ../default.nix
    ./golden.nix
    ./quality.nix
  ];

  # Python modules, each with the unit test that covers it.
  pythonFiles = [
    ../tools/golden/golden_tree.py
    ../tests/test_golden_tree.py
  ];
  unitTests = [ "tests/test_golden_tree.py" ];

  src = lib.fileset.toSource {
    root = ../.;
    fileset = lib.fileset.unions (nixFiles ++ pythonFiles);
  };
  # Paths relative to the repository root, for the tools' messages.
  rel = files: map (f: lib.removePrefix (toString ../. + "/") (toString f)) files;
in
pkgs.runCommand "builder-quality"
  {
    nativeBuildInputs = [
      pkgs.nixfmt
      pkgs.statix
      pkgs.deadnix
      pkgs.ruff
      (pkgs.python3.withPackages (ps: [ ps.mypy ]))
    ];
  }
  ''
    cd ${src}
    export PYTHONDONTWRITEBYTECODE=1 RUFF_CACHE_DIR="$TMPDIR/ruff" MYPY_CACHE_DIR="$TMPDIR/mypy"

    nixfmt --check ${lib.escapeShellArgs (rel nixFiles)}
    for f in ${lib.escapeShellArgs (rel nixFiles)}; do statix check "$f"; done
    deadnix --fail ${lib.escapeShellArgs (rel nixFiles)}

    ruff check ${lib.escapeShellArgs (rel pythonFiles)}
    ruff format --check ${lib.escapeShellArgs (rel pythonFiles)}
    mypy --strict ${lib.escapeShellArgs (rel pythonFiles)}
    for t in ${lib.escapeShellArgs unitTests}; do python3 -m unittest -v "$t"; done

    touch "$out"
  ''
