{ config, tools, ... }:

with tools.nix-colors.withHashtag config.colorScheme.colors;

{
  programs.alacritty.settings.colors = {
    primary = {
      background = base00;
      foreground = base05;
    };

    cursor = {
      text = base00;
      cursor = base05;
    };

    vi_mode_cursor = {
      text = base00;
      cursor = base04;
    };

    selection = {
      text = "CellForeground";
      background = base03;
    };

    search = {
      matches = {
        foreground = "CellBackground";
        background = base0C;
      };
      footer_bar = {
        background = base02;
        foreground = base04;
      };
    };

    normal = {
      black = base00;
      red = base0B;
      green = base0E;
      yellow = base0D;
      blue = base09;
      magenta = base0F;
      cyan = base08;
      white = base05;
    };
    
    bright = {
      black = base03;
      red = base0B;
      green = base0E;
      yellow = base0D;
      blue = base09;
      magenta = base0F;
      cyan = base07;
      white = base06;
    };
  };
}
