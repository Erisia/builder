with (import <nixpkgs> {});

mkShell {
  buildInputs = [ ruby_2_6 bundix ];
}
