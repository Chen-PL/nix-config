{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ../../../common/home
  ];

  home = {
    username = "chen";
    homeDirectory = "/Users/chen";
    sessionPath = [ "$HOME/bin" ];
  };

  fonts.fontconfig.enable = true;
}
