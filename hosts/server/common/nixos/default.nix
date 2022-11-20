{ inputs, lib, config, pkgs, ... }:

{
  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  networking = {
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ];
      # allowedUDPPorts = [ ... ];
    };
  };

  users.users = {
    chen = {
      isNormalUser = true;
      shell = pkgs.zsh;

      extraGroups = [ "wheel" ];

      openssh.authorizedKeys.keys = [
        # Macbook
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDdOQtVDoRn3HoxYJwzYw3n3+LL97UKbYlicewbmWD0Hid1lq+abPBuOSUxLFDWyOC1Y8fTAJJQJEt+2a1ReVsQsriedj7i2dZqb0ydme8YsC+TEDV9HnhfjMk2Ee/Cju5ShAX/4zdjr1p+Y18VmmRVkAZYUOsAW3nYtEYu8OWZiWsHb5klyW6RnTdEGmfinO/QSx7UgQIbaRj0QjGu3JEOx6CubhGIhr14ReSlHT1ltpur2dyG9l3Ux17mlfwg5XeaVSt3rznBz/e3eQO1pyh+Tn9nTaC1g2im3Dymee8iF1+ARFcE7OBDKMGefRZnSTx1GUBZifMt9on9EBG61S+m5MFvlXL0/6OWcZhkda0HhyK8PyLe/x+b+1uXS7b4980YUpn0thtGRlunWPzEKKZqeSPtuCxm956WQOHypXT5g3r7M6wkiqAh3t0tu8mzVj7EtxJLpsRnPv+TgNd+2iAd7R/UQ3hRd3vwrBkvF4hm1zY5ZImCo52jbg0ZaqB09Fc= cuichen"
        # intel-nuc-12
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCajuTnkXhjMCKBQWR8KpGW83X4jnkzzlCtFB2qaJqIE/dSerdXT6oPl3zOlOtykHQwTGmI6a+CN2gJLA/INIdAJiNuSRPwJi4o/zVhoNzsZg/JKB4TzCEcmW3laQDaOfSe8p6E0cPHHnvWkbn0GqmRibP1GtL940ViBqEjk0QAuSzD70ONkenN10CLFN21hTdhou0vySoej9jJeOI16M4957rWj9aaLJrcsPsgCJpa82XKlRAVOZCj849Mho/KxFOboWPdPDRZwac1corA5khChP+WefXO6ibMWudXgn/NiTgyLl1ZsvJPGrZ3/avjMsaWOnbEGAvBzn3wzdku5y+JHiIGzRR5mCAG6SJz52HAZ0xLaSxoB8bYseRqFzbV4duCoWIFsTzunaVYz4m/LBZJhUdTuNWpCnwwQ0ia7Vk4w03POpJU6SQHdemiWpySeTNMwlXz61RkEdxRoe4bYsBgGCsmhGciBL3++CMTK6FSQ+9Bhv/qqLbMdsEogyVxAHM= chen@intel-nuc-12"
      ];
    };
  };

  # Bootstrap packages
  environment.systemPackages = with pkgs; [
    git
    wget
  ];

  services = {
    fail2ban = {
      enable = true;
      maxretry = 5;
    };

    openssh = {
      enable = true;
      passwordAuthentication = false;
      kbdInteractiveAuthentication = false;
      permitRootLogin = "no";
    };
  };
}
