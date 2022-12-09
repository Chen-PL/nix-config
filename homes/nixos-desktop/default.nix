{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./packages.nix
    ./programs
    ./services
    ./themes
  ];

  fonts.fontconfig.enable = true;
}
