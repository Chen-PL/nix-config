{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.chromium;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1Password
      { id = "aapbdbdomjkkjkaonfhkkikfgjllcleb"; } # Google Translate
      { id = "abehfkkfjlplnjadfcjiflnejblfmmpj"; } # Nord Theme
    ];
  };
}