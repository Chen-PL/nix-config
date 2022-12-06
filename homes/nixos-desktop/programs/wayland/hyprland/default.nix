{ inputs, lib, pkgs, ... }:

let
  source = file: "source = ${file}";
  importConfigs = files: lib.concatStringsSep "\n" (map source files);
in

{
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = importConfigs [
      ./monitors.conf
      ./autostarts.conf
      ./options.conf
      ./binds.conf
      ./window-rules.conf
    ];
  };
}
