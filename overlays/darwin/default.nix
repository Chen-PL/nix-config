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
    };
}