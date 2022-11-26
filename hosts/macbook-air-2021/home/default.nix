{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./programs
  ];

  home = {
    username = "chen";
    homeDirectory = "/Users/chen";
    sessionPath = [ "$HOME/bin" ];

    # very very werid version number
    stateVersion = "22.11";
  };

  fonts.fontconfig.enable = true;
}
