{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ../../../common/home

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
