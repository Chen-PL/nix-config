{ pkgs, ... }:

{
  gtk = {
    enable = true;
    font = {
      package = pkgs.fira;
      name = "Fira Sans 11";
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

  home.pointerCursor = {
    package = pkgs.nordic;
    name = "Nordic";
    size = 48;
    gtk.enable = true;
    x11 = {
      enable = true;
      defaultCursor = "X_cursor";
    };
  };
}