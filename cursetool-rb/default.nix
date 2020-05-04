 with (import ../nixpkgs {});
 
let gems = bundlerEnv {
  name = "cursetool-gems";
  gemdir = ./.;
};
in mkShell {
  buildInputs = [ gems gems.wrappedRuby bundix ];
}
