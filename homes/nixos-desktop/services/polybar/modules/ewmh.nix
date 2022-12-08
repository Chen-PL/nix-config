{ lib, config, tools, ... }:


with tools.nix-colors.withHashtag config.colorScheme.colors;

let
  icon-font = 3;

  inherit (builtins) length;
  inherit (lib.lists) range zipListsWith;
  inherit (tools) simpleMerge;
  inherit (tools.polybar) withFont;
  workspaces = [
    { name = "www"; icon = ""; }
    { name = "fsm"; icon = ""; }
    { name = "thm"; icon = ""; }
    { name = "com"; icon = ""; }
    { name = "mus"; icon = ""; }
    { name = "obs"; icon = ""; }
    { name = "nix"; icon = ""; }
    { name = "etc"; icon = ""; }
  ];
  icons = zipListsWith
    (i: ws: { "icon-${toString i}" = "${ws.name};${withFont icon-font ws.icon}"; })
    (range 0 ((length workspaces) - 1))
    workspaces;
in
{
  services.polybar.config."module/ewmh" = {
    type = "internal/xworkspaces";
    enable-click = true;
    enable-scroll = true;
    reverse-scroll = true;

    format = "<label-state>";
    label-active = "%icon% %name%";
    label-occupied = "%icon% %name%";
    label-empty = "%icon% %name%";
    label-active-padding = 2;
    label-occupied-padding = 2;
    label-empty-padding = 2;
    label-active-underline = base09;
    label-active-foreground = base00;
    label-active-background = base09;
    label-occupied-underline = base09;
  } // simpleMerge icons;
}
