{
  additions = final: _prev: import ../../pkgs/darwin { pkgs = final; };

  modifications = final: prev:
    let
      inherit (import ./lib.nix final prev) installApplication;
    in
    {
      sublime4 = installApplication {
        name = "Sublime Text";
        version = "4143";
        sourceRoot = "Sublime Text.app";
        src = prev.fetchurl {
          url = "https://download.sublimetext.com/sublime_text_build_4143_mac.zip";
          sha256 = "sha256-K9VLq8ayc2ToDEwQfOG0ACZmI3H1bDXiWyn967KUKxk=";
        };
        description = "Sophisticated text editor for code, markup and prose";
        homepage = "https://www.sublimetext.com/";
      };

      firefox = installApplication rec {
        name = "Firefox";
        version = "107.0.1";
        sourceRoot = "Firefox.app";
        src = prev.fetchurl {
          name = "Firefox-${version}.dmg";
          url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/107.0.1/mac/zh-CN/Firefox%20${version}.dmg";
          sha256 = "sha256-K9VLq8ayc2ToDEwQfOG0ACZmI3H1bDXxWyn967KUKxk=";
        };
        description = "The Firefox web browser";
        homepage = "https://www.mozilla.org/en-US/firefox/";
      };
    };
}
