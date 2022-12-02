{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./chromium
    ./gpg
    ./micro
    ./nnn
    ./rime
    ./rofi
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
