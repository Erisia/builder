# Golden trees: what the e36 server and its players receive, as reviewable text.
#
# Produces:
#   tree:  a store file listing (path, mode, size, sha256) for every file in the outputs below.
#          It is exposed as `packages.golden-e36`.
#   check: fails if `tree` differs from the committed tests/golden/e36.tree, and prints the diff.
#          It is exposed as `checks.golden-e36`.
# Consumers: the flake (packages and checks). A builder change that should change nothing must
# pass this check unchanged. One that should change something commits the regenerated file, so
# the review shows exactly which files changed.
#
# Regenerate:  nix build .#golden-e36 && cp result tests/golden/e36.tree
{
  pkgs,
  builder,
}:
let
  inherit (pkgs) lib;
  inherit (builder.packs) e36;

  # What is covered. Names are the first path component in the tree file.
  roots = {
    "e36-server" = e36.server;
    "e36-client-mods" = e36.clientModsDir;
    "e36-client-configs" = e36.clientConfigsDir;
    # The packs/ tree beside these is symlinks to the dirs above.
    "ServerPack.xml" = "${builder.ServerPack}/ServerPack.xml";
    "MCUpdater-Bootstrap.jar" = "${builder.ServerPack}/MCUpdater-Bootstrap.jar";
  };

  tree = pkgs.runCommand "golden-e36.tree" { nativeBuildInputs = [ pkgs.python3 ]; } ''
    python3 ${../tools/golden/golden_tree.py} ${
      lib.escapeShellArgs (lib.mapAttrsToList (name: path: "${name}=${path}") roots)
    } > "$out"
  '';

  check = pkgs.runCommand "golden-e36-check" { nativeBuildInputs = [ pkgs.diffutils ]; } ''
    if ! diff -u ${../tests/golden/e36.tree} ${tree}; then
      echo
      echo "The e36 outputs differ from tests/golden/e36.tree (diff above)."
      echo "If that is intended, regenerate it and commit it with the change:"
      echo "  nix build .#golden-e36 && cp result tests/golden/e36.tree"
      exit 1
    fi
    touch "$out"
  '';
in
{
  inherit tree check;
}
