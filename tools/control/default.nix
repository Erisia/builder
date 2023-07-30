{ rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "control";
  version = "0.1";

  src = builtins.filterSource
    (path: type: type != "directory" || baseNameOf path == "src")
    ./.;

  cargoSha256 = "sha256-Cz6JicPJEw4fdOOPZt8wnr0/3/k8b3J14nkMx/c1wmY=";

}
