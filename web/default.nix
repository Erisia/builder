{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "erisia-website";
  src = ./.;
  
  buildInputs = [ pkgs.hugo ];
  
  buildPhase = ''
    hugo --minify
  '';
  
  installPhase = ''
    cp -r public $out
  '';
}