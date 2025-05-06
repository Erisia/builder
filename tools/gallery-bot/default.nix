{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let 
  pythonWithDeps = python3.withPackages (ps: with ps; [
    discordpy
    aiohttp
  ]);
in 
buildEnv {
  name = "erisia-gallery-bot";
  paths = [
    (writeScriptBin "gallery-bot" ''
      #!${stdenv.shell}
      cd ${toString ./.}
      exec ${pythonWithDeps}/bin/python3 gallery_bot.py
    '')
  ];
  meta = {
    description = "Discord bot for collecting images and serving them via HTTP";
    maintainers = ["Erisia"];
  };
}
