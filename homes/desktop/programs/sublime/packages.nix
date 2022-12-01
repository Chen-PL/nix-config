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
    nord = pkgs.fetchFromGitHub {
      owner = "arcticicestudio";
      repo = "nord-sublime-text";
      rev = "57cb731ef47b9ede6b8af23cdfcec735fe545c6a";
      hash = "sha256-1VXmh7xP/gs9MISaTISfIx9O83jxncU2yRml3Cb3I/0=";
    };
  };
}
