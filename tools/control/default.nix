{ rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "control";
  version = "0.2";

  src = builtins.filterSource
    (path: type: type != "directory" || baseNameOf path == "src")
    ./.;

  cargoHash = "sha256-BKjiw+fonrt8yP2hKhOEdxwOvD1eFuSdqE13wJJ8LrY=";
}
