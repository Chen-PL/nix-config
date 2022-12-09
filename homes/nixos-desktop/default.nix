{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./impermanence.nix
    ./packages.nix
    ./programs
    ./services
    ./themes
  ];

  fonts.fontconfig.enable = true;
}
