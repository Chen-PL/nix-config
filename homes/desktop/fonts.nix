{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    font-manager
    fira # Sans-serif font for Firefox OS
    fira-code # Monospace font with programming ligatures
    fira-code-symbols # FiraCode unicode ligature glyphs in private use area
    font-awesome # Font Awesome - OTF font
    nerdfonts # Iconic font aggregator, collection, & patcher. 3,600+ icons, 50+ patched fonts
    source-code-pro # Monospaced font family for user interface and coding environments
    wqy_microhei # A (mainly) Chinese Unicode font
    wqy_zenhei # A (mainly) Chinese Unicode font
  ];
}
