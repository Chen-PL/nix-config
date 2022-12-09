{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./packages.nix
    ./programs
    ./services
    ./themes
  ];

  home.sessionVariables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    QT_SCALE_FACTOR = "1.5";
  };

  fonts.fontconfig.enable = true;
}
