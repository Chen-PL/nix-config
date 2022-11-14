{ inputs, lib, config, pkgs, ... }:

{
  imports = [
    ./locale
    ./xserver
  ];

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
      allowedTCPPorts = [ 22 80 ];
      # allowedUDPPorts = [ ... ];
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };

  users.users = {
    chen = {
      isNormalUser = true;
      shell = pkgs.zsh;

      # BEWARE that the docker group membership is effectively equivalent to being root!
      extraGroups = [ "audio" "docker" "networkmanager" "vboxusers" "wheel" ];

      openssh.authorizedKeys.keys = [
        # Macbook
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDdOQtVDoRn3HoxYJwzYw3n3+LL97UKbYlicewbmWD0Hid1lq+abPBuOSUxLFDWyOC1Y8fTAJJQJEt+2a1ReVsQsriedj7i2dZqb0ydme8YsC+TEDV9HnhfjMk2Ee/Cju5ShAX/4zdjr1p+Y18VmmRVkAZYUOsAW3nYtEYu8OWZiWsHb5klyW6RnTdEGmfinO/QSx7UgQIbaRj0QjGu3JEOx6CubhGIhr14ReSlHT1ltpur2dyG9l3Ux17mlfwg5XeaVSt3rznBz/e3eQO1pyh+Tn9nTaC1g2im3Dymee8iF1+ARFcE7OBDKMGefRZnSTx1GUBZifMt9on9EBG61S+m5MFvlXL0/6OWcZhkda0HhyK8PyLe/x+b+1uXS7b4980YUpn0thtGRlunWPzEKKZqeSPtuCxm956WQOHypXT5g3r7M6wkiqAh3t0tu8mzVj7EtxJLpsRnPv+TgNd+2iAd7R/UQ3hRd3vwrBkvF4hm1zY5ZImCo52jbg0ZaqB09Fc= cuichen"
      ];
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };

    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
      addNetworkInterface = true;
    };
  };

  programs.dconf.enable = true;

  services = {
    fail2ban = {
      enable = true;
      maxretry = 5;
      ignoreIP = [
        "127.0.0.0/8"
        "192.168.0.0/16"
      ];
    };

    # For 1Password (otherwise it keeps asking for two-refactor)
    gnome.gnome-keyring.enable = true;

    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };

    openssh = {
      enable = true;
      passwordAuthentication = false;
      kbdInteractiveAuthentication = false;
      permitRootLogin = "no";
    };
  };

  system.stateVersion = "22.11";
}