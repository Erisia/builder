{ rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "control";
  version = "0.1";

  src = builtins.filterSource
    (path: type: type != "directory" || baseNameOf path == "src")
    ./.;

  cargoHash = "sha256-MgizgxwgmBv8jHY4DJxJP2+WjF6mqn6rLYDkE+a7TnU=";
}
