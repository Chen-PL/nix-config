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
      allowedTCPPorts = [ 22 80 443 ];
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
      ];
    };
  };

  # Bootstrap packages
  environment.systemPackages = with pkgs; [
    git
    wget
  ];

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;

      autoPrune = {
        enable = true;
        dates = "weekly";
      };
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

    # For udiskie
    udisks2.enable = true;
  };
}
