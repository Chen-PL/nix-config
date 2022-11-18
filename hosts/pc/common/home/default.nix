{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./packages
    ./programs
    ./services
    ./themes
  ];

  home = {
    username = "chen";
    homeDirectory = "/home/chen";
    sessionPath = [ "$HOME/bin" ];
  };

  fonts.fontconfig.enable = true;
}
