{ inputs, lib, config, pkgs, hostname, username, ... }:

{
  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  networking.hostName = hostname;

  users.users.${username} = {
    name = username;
    shell = pkgs.zsh;
  };
}
