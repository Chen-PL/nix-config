{ config, nix-colors, ... }:

with config.colorScheme.colors;

let
  inherit (nix-colors.lib-core.conversions) hexToRGBString;
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs.rofi.theme = {
    "*" = {
      foreground = mkLiteral "#${base09}";
      background-color = mkLiteral "transparent";
      highlight = mkLiteral "underline bold #${base06}";
      transparent = mkLiteral "#${base00}";
    };

    window = {
      location = mkLiteral "center";
      anchor = mkLiteral "center";
      transparency = "screenshot";
      padding = mkLiteral "10px";
      border = mkLiteral "0px";
      border-radius = mkLiteral "6px";

      background-color = mkLiteral "@transparent";
      spacing = 0;
      children = map mkLiteral [ "mainbox" ];
      orientation = mkLiteral "horizontal";
    };

    mainbox = {
      spacing = 0;
      children = map mkLiteral [ "inputbar" "message" "listview" ];
    };

    message = {
      color = mkLiteral "#${base00}";
      padding = 5;
      border-color = mkLiteral "@foreground";
      border = mkLiteral "0px 2px 2px 2px";
      background-color = mkLiteral "#${base07}";
    };

    inputbar = {
      color = mkLiteral "#${base06}";
      padding = mkLiteral "11px";
      background-color = mkLiteral "#3b4252";

      border = mkLiteral "1px";
      border-radius = mkLiteral "6px 6px 0px 0px";
      border-color = mkLiteral "#${base0F}";
    };

    "entry, prompt, case-indicator" = {
      text-font = mkLiteral "inherit";
      text-color = mkLiteral "inherit";
    };

    prompt = {
      margin = mkLiteral "0px 1em 0em 0em";
    };

    listview = {
      padding = mkLiteral "8px";
      border-radius = mkLiteral "0px 0px 6px 6px";
      border-color = mkLiteral "#${base0F}";
      border = mkLiteral "0px 1px 1px 1px";

      background-color = mkLiteral "rgba(${hexToRGBString "," base00},0.9)";
      dynamic = false;
    };

    element = {
      padding = mkLiteral "3px";
      vertical-align = mkLiteral "0.5";
      border-radius = mkLiteral "4px";
      background-color = mkLiteral "transparent";
      color = mkLiteral "@foreground";
      text-color = mkLiteral "#${base04}";
    };

    "element selected.normal" = {
      background-color = mkLiteral "#${base07}";
      text-color = mkLiteral "#${base00}";
    };

    "element-text, element-icon" = {
      background-color = mkLiteral "inherit";
      text-color = mkLiteral "inherit";
    };

    button = {
      padding = mkLiteral "6px";
      color = mkLiteral "@foreground";
      horizontal-align = mkLiteral "0.5";

      border = mkLiteral "2px 0px 2px 2px";
      border-radius = mkLiteral "4px 0px 0px 4px";
      border-color = mkLiteral "@foreground";
    };

    "button selected normal" = {
      border = mkLiteral "2px 0px 2px 2px";
      border-color = mkLiteral "@foreground";
    };
  };
}

