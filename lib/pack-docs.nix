# The pack options (lib/pack-module.nix) as Markdown, and a command that shows them.
#
# Produces: `doc`, the Markdown file (`nix build .#pack-options`), and `viewer`, the `pack-docs`
#   command, which pages it with glow (`nix run .#pack-docs`; the server has it as bin/pack-docs).
# Consumers: flake.nix and lib/pack.nix. The `.envrc` command lists point at the viewer.
{ pkgs }:
let
  doc =
    (pkgs.nixosOptionsDoc {
      options =
        builtins.removeAttrs
          (pkgs.lib.evalModules {
            modules = [ ./pack-module.nix ];
          }).options
          [ "_module" ];
      # Name the file by its repository path, not its store path.
      transformOptions =
        opt:
        opt
        // {
          declarations = [
            {
              name = "lib/pack-module.nix";
              url = "https://github.com/Erisia/builder/blob/master/lib/pack-module.nix";
            }
          ];
        };
    }).optionsCommonMark;
in
{
  inherit doc;

  viewer = pkgs.writeShellApplication {
    name = "pack-docs";
    runtimeInputs = [
      pkgs.glow
      pkgs.less
    ];
    # Pages in a terminal; piped, it prints the Markdown as it is.
    text = ''
      if [[ -t 1 ]]; then
        exec glow --pager ${doc}
      else
        exec cat ${doc}
      fi
    '';
  };
}
