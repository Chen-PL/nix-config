{ pkgs, ... }:

{
  imports = [
    ./brew
  ];

  system.stateVersion = 4;

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

  services.nix-daemon = {
    enable = true;
    # getting rid of "experimental-features = nix-command flakes"
    package = pkgs.nixFlakes;
  };
}
