{ pkgs, username, ... }:

{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  networking = {
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ];
      # allowedUDPPorts = [ ... ];
    };
  };

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      # intel-nuc-12
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDi/dd1Nba5SDPMdQBXjgZsFDmB5WIkrs2g+oZm8hNTP cuichen"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJiGou+kbjM9Q8TJsVcXwHlfXjGDwEbwo2BQ/xnOq8jd chen"
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    htop
    wget
  ];

  services = {
    fail2ban = {
      enable = true;
      maxretry = 5;
      ignoreIP = [
        "127.0.0.0/8"
        "192.168.0.0/16"
      ];
    };

    openssh = {
      enable = true;
      passwordAuthentication = false;
      kbdInteractiveAuthentication = false;
      permitRootLogin = "no";
    };

    pcscd.enable = true;
  };
}
