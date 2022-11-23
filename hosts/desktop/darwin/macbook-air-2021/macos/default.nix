{ inputs, lib, config, pkgs, ... }:

{
  imports = [
    ./brew
  ];

  system.stateVersion = 4;

  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };
  services.nix-daemon.enable = true;

  networking = {
    hostName = "macbook-air-2021";
  };

  users.users = {
    chen = {
      name = "Chen";
      home = "/Users/chen";
      shell = pkgs.zsh;
    };
  };
}
