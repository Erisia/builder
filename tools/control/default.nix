{ rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "control";
  version = "0.1";

  src = builtins.filterSource
    (path: type: type != "directory" || baseNameOf path == "src")
    ./.;

  cargoHash = "sha256-VpzvNl8cYI9VXWM/clJkhNLKvRDMEW+Yqu9UUqnsdww=";
}
