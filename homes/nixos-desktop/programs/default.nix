{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./chromium
    ./gpg
    ./rime
    ./rofi
    ./xmonad
    ./yubikey
    ./micro.nix
    ./nnn.nix
    ./retroarch.nix
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
