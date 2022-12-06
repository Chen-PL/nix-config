{ lib, pkgs, ... }:

let
  inherit (builtins) attrValues foldl';
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  merge = attrs: foldl' (x: y: x // y) { } (attrValues attrs);

  antialias =
    if isLinux then {
      font_options = [ "gray_antialias" ];
      theme_font_options = [ "gray_antialias" ];
    } else { };
in
{
  imports = [ ./packages.nix ];

  programs.sublime = {
    enable = true;
    enablePackageControl = true;

    settings = merge {
      ui = {
        margin = 4;
        gutter = true;
        drag_text = false;
        line_numbers = true;
        show_encoding = true;
        ui_separator = false;
        fold_buttons = false;
        highlight_line = true;
        scroll_past_end = true;
        hardware_acceleration = "opnegl";
      };
      font = {
        font_size = 14;
        font_face = "Fira Code";
      } // antialias;
      format = {
        default_line_ending = "unix";
        ensure_newline_at_eof_on_save = true;
        trim_trailing_white_space_on_save = "all";
      };
      autoComplete = {
        auto_complete_delay = 0;
        auto_complete_trailing_symbols = true;
      };
      misc = {
        ignored_packages = [ "Vintage" ];
        file_exclude_patterns = import ./patterns.nix;
      };
    };

    packageSettings =
      if isLinux then {
        Abella = {
          "abella.exec" = "${pkgs.abella-modded}/bin/abella";
          "proof_view_mode" = "window";
        };
      } else { };

    theme.ayu-mirage.enable = true;

    color.Nord = {
      enable = true;
      config = {
        rules = [
          {
            name = "[Keyword] Abella";
            scope = "keyword.source.abella";
            foreground = "var(nord_keyword)";
          }
          rec {
            name = "Proven with Abella";
            scope = "meta.abella.proven";
            foreground = "#344D67";
            background = foreground;
          }
          rec {
            name = "Modified with Abella";
            scope = "meta.abella.modified";
            foreground = "#5E81AC";
            background = foreground;
          }
        ];
      };
    };
  };
}
