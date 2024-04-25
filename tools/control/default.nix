{ rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "control";
  version = "0.1";

  src = builtins.filterSource
    (path: type: type != "directory" || baseNameOf path == "src")
    ./.;

  cargoSha256 = "sha256-La8oKMeYSsmU3o5iv873tuL3ihloEa+N6C4dM+9jTRE=";
}
