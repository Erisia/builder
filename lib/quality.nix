# Code-quality check for the files that have been brought up to the builder's standard.
#
# Produces: one derivation (`checks.quality`) that fails on the first problem found:
#   - Nix: nixfmt formatting, statix lints, deadnix (unused bindings).
#   - Python: ruff lint and formatting, mypy --strict, and the files' unit tests; plus, for the
#     older Python files, a check for undefined names.
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
    ./pack-module.nix
    ./pack-docs.nix
    ./upstream.nix
    ./pack.nix
    ../packs/e36/pack.nix
    ../tests/pack-module.nix
  ];

  # Python modules, each with the unit test that covers it.
  pythonFiles = [
    ../tools/golden/golden_tree.py
    ../tests/test_golden_tree.py
    ./make-serverpack.py
    ../tests/test_make_serverpack.py
    ./unpack_upstream.py
    ../tests/test_unpack_upstream.py
    ../runtime/managed_files.py
    ../tests/test_managed_files.py
  ];
  # Not yet at that standard, but checked for undefined names (ruff F821-F823): a leftover use of
  # a removed constant only fails at runtime, and the launcher has no test that reaches every path.
  undefinedNameFiles = [
    ../runtime/start.py
    ../runtime/crash_analysis.py
    ../shutdown.py
    ../tools/recompress_audio.py
    ../tools/gallery-bot/gallery_bot.py
    ../tools/skills/minecraft-tick-debug/scripts/evidence.py
    ../tools/skills/minecraft-tick-debug/scripts/compare_inspections.py
    ../tests/test_daily_restart.py
    ../tests/test_start_java.py
    ../tests/test_sync_scripts.py
    ../tests/test_shutdown.py
    ../tests/test_crash_analysis.py
    ../tests/test_tick_debug.py
  ];
  unitTests = [
    "tests/test_golden_tree.py"
    "tests/test_make_serverpack.py"
    "tests/test_unpack_upstream.py"
    "tests/test_managed_files.py"
  ];

  src = lib.fileset.toSource {
    root = ../.;
    fileset = lib.fileset.unions (nixFiles ++ pythonFiles ++ undefinedNameFiles);
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
    ruff check --select F821,F822,F823 ${lib.escapeShellArgs (rel undefinedNameFiles)}
    for t in ${lib.escapeShellArgs unitTests}; do python3 -m unittest -v "$t"; done

    touch "$out"
  ''
