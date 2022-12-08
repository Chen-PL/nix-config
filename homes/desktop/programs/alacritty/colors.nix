{ config, tools, ... }:

with tools.withHashtag config.colorScheme.colors;

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
      red = base08;
      green = base0B;
      yellow = base0A;
      blue = base0D;
      magenta = base0E;
      cyan = base0C;
      white = base05;
    };
    
    bright = {
      black = base03;
      red = base09;
      green = base01;
      yellow = base02;
      blue = base04;
      magenta = base06;
      cyan = base0F;
      white = base07;
    };
  };
}
