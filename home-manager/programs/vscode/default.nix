{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      arcticicestudio.nord-visual-studio-code
      haskell.haskell
      jnoortheen.nix-ide
    ];
  };
}
