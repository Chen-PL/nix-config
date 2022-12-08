{ pkgs, ... }:

{
  imports = [
    ./theme.nix
  ];

  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    extraConfig = {
      modi = "drun,window,filebrowser";
      show-icons = false;
      dpi = 180;
    };
  };
}
