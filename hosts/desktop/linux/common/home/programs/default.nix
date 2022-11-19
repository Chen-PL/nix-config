{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./alacritty
    ./autorandr
    ./micro
    ./nnn
    ./rime
    ./rofi
    ./sublime-text
    ./xmonad
    ./zoxide
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
