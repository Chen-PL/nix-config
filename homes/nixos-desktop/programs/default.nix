{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./chromium
    ./gpg
    ./micro.nix
    ./nnn.nix
    ./rime
    ./rofi
    ./xmonad
    ./yubikey
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
