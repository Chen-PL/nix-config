{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    userSettings = import ./settings.nix;
    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace (import ./extensions.nix);
  };
}
