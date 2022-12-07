{ config, ... }:

{
  services.random-background = {
    enable = true;
    imageDirectory = "${config.xdg.dataHome}/random-background";
  };

  xdg.dataFile."random-background/wallpaper.jpg".source = ./wallpaper.jpg;
}
