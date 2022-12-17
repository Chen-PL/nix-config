{ pkgs, ... }:

{
  programs.sublime.packages = {
    abella = pkgs.fetchFromGitHub {
      owner = "JimmyZJX";
      repo = "SublimeAbella";
      rev = "a42909957d6028321c8964712e700c12ceac58b7";
      hash = "sha256-SnwTCjdI9jPvZLhraRUmLzt6zSf5wxxqxLXIVTSQWts=";
    };
    ayu = pkgs.fetchFromGitHub {
      owner = "dempfi";
      repo = "ayu";
      rev = "362525bcd7a832684eed5a0e054a97356fdf353a";
      hash = "sha256-Rd/OfwRZ5jQrQERgAWwPH7TW1tqAOoRJFThAMopwlNw=";
    };
    LSP = pkgs.fetchFromGitHub {
      owner = "sublimelsp";
      repo = "LSP";
      rev = "472187b2b9c443b5a96f861c20aeea4903fae374";
      hash = "sha256-s4nlIkJDh+jG/rPGfqn2DWrs/BYkB6ecFzZ+Mihe/Us=";
    };
    LSP-copilot = pkgs.fetchFromGitHub {
      owner = "TerminalFi";
      repo = "LSP-copilot";
      rev = "f41608198f00ccaf69c60ed6d6c05969476e78f5";
      hash = "sha256-HBo6X78jVwkWSUFXiPsLgnSTnL5fLr6ZJ97XR+ZXIvU=";
    };
    nord = pkgs.fetchFromGitHub {
      owner = "arcticicestudio";
      repo = "nord-sublime-text";
      rev = "57cb731ef47b9ede6b8af23cdfcec735fe545c6a";
      hash = "sha256-1VXmh7xP/gs9MISaTISfIx9O83jxncU2yRml3Cb3I/0=";
    };
    wakatime = pkgs.fetchFromGitHub {
      owner = "wakatime";
      repo = "sublime-wakatime";
      rev = "c1002133517337cc6f71005f71f4ab36865bceab";
      hash = "sha256-6bZ/u6mJ7kYa1V5WLvcXs8+hKpQnCUmG1LGV0PYlu/w=";
    };
  };
}
