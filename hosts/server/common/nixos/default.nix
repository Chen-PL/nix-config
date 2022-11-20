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
        # intel-nuc-12
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDi/dd1Nba5SDPMdQBXjgZsFDmB5WIkrs2g+oZm8hNTP cuichen"
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
