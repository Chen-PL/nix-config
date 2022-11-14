{ pkgs, ... }:

{
  gtk = {
    enable = true;
    font = {
      package = pkgs.fira;
      name = "Fira Sans 11";
    };
    cursorTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
    };
    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
    };
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
  };
}