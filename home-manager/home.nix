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
    stateVersion = "22.11";
  };

  fonts.fontconfig.enable = true;
}
