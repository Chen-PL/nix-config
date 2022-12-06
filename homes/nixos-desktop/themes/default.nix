{ pkgs, ... }:

{
  gtk = {
    enable = true;
    font = {
      package = pkgs.fira;
      name = "Fira Sans 14";
    };
    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
    };
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    cursorTheme = {
      name = "Arc";
      package = pkgs.arc-icon-theme;
      size = 24;
    };
  };
}
