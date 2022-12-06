{ inputs, pkgs, ... }:

{
  imports = [
    ./hyprland
    ./hyprpaper
    ./sway
    ./waybar
  ];

  home.packages = with pkgs; [
    wlogout
    grimblast # A Hyprland version of Grimshot
  ];
}