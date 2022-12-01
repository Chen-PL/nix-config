{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./chromium
    ./micro
    ./nnn
    ./rime
    ./rofi
    # ./sublime-text
    ./xmonad
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
