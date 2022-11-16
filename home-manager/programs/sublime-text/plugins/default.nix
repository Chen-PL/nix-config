{ config, pkgs, ... }:

let
  sublimePkgsHome = "${config.xdg.configHome}/sublime-text/Packages";
in
{
  home.file = {
    "${sublimePkgsHome}/abella".source = pkgs.fetchFromGitHub {
      owner = "JimmyZJX";
      repo = "SublimeAbella";
      rev = "a42909957d6028321c8964712e700c12ceac58b7";
      hash = "sha256-SnwTCjdI9jPvZLhraRUmLzt6zSf5wxxqxLXIVTSQWts=";
    };
    "${sublimePkgsHome}/A File Icon".source = pkgs.fetchFromGitHub {
      owner = "SublimeText";
      repo = "AFileIcon";
      rev = "862a6bb2b5fe76ae5f377888ec437187c3f499f2";
      hash = "sha256-/Mn8MwMhbmSpMDLzI6T7kuiXdb3It6le7rXv3oEfgu4=";
    };
    "${sublimePkgsHome}/ayu".source = pkgs.fetchFromGitHub {
      owner = "dempfi";
      repo = "ayu";
      rev = "362525bcd7a832684eed5a0e054a97356fdf353a";
      hash = "sha256-Rd/OfwRZ5jQrQERgAWwPH7TW1tqAOoRJFThAMopwlNw=";
    };
    "${sublimePkgsHome}/Nord".source = pkgs.fetchFromGitHub {
      owner = "arcticicestudio";
      repo = "nord-sublime-text";
      rev = "57cb731ef47b9ede6b8af23cdfcec735fe545c6a";
      hash = "sha256-1VXmh7xP/gs9MISaTISfIx9O83jxncU2yRml3Cb3I/0=";
    };
  };
}