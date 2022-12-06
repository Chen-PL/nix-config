{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./chromium
    ./wayland
    ./gpg
    ./micro
    ./nnn
    ./rime
    ./rofi
    ./wofi.nix
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

  # for vscode
  home.sessionVariables = { NIXOS_OZONE_WL = "1"; };
}
