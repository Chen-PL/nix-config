{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./alacritty
    ./autorandr
    ./chromium
    ./emacs
    ./exa
    ./fzf
    ./git
    ./micro
    ./nix-index
    ./nnn
    ./opam
    ./rime
    ./rofi
    ./sublime-text
    ./ssh
    ./vscode
    ./xmonad
    ./zoxide
    ./zsh
  ];

  programs = {
    home-manager.enable = true;
    feh.enable = true;
    firefox.enable = true;
    obs-studio.enable = true;
    sioyek.enable = true;
    tmux.enable = true;
    vim.enable = true;
  };
}
