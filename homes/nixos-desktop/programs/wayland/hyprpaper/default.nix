{ pkgs, ... }:

{
  home.packages = [ pkgs.hyprpaper ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${./wallpaper.jpg}
    wallpaper = HDMI-A-1,${./wallpaper.jpg}
  '';
}
