{
  additions = final: _prev: import ../../pkgs/darwin { pkgs = final; };

  modifications = final: prev:
    let
      inherit (import ./lib.nix final prev) installApplication;
    in
    {
      sublime4 = installApplication {
        name = "sublimetext4";
        version = "4143";
        sourceRoot = "Sublime Text.app";
        src = prev.fetchurl {
          url = "https://download.sublimetext.com/sublime_text_build_4143_mac.zip";
          sha256 = "0xizsq75dws08x6q7zss2rik9rd6365w1y2haa08hqnjzkf7yb8x";
        };
        description = "Sophisticated text editor for code, markup and prose";
        homepage = "https://www.sublimetext.com/";
      };
    };
}