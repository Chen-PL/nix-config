{ lib, pkgs, hostname, username, stateVersion, ... }:

{
  imports = [ "nix.nix" ];

  networking.hostName = hostname;

  users.users.${username} = {
    name = username;
    shell = pkgs.zsh;
  };

  system.stateVersion = lib.mkDefault stateVersion;
}
