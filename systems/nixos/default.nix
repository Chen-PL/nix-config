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
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDFPzFTIqBjChSht32t+asVmInWeXEigF3RstiITML8Edf8j5CLmDu3o/iUCuXHU7hZgwL8xHnOw2jdNbrrol82RBouAI2N15l8JSG29CNxVwsi+9WwbspWrx4Jm93QHgUj6b+SGV6AG+NhlWqtM7tvjamVMFSLSOOvAFX7/Vz+bfBtYIuOhucujGuYXFeFPajv4BpnMKnc+PQh4ueulG+xsYC2fbRNY7ElU+1QyeTPDcJbpwVuJZ5fHqphbOmjsiGMGDtXs0/b+X3ozRkr9OdDhHDRHKrzxKGBCwd3knhBGL5uDBztHoIwLwgLDE2GwF2Pf5Sf87BP1/ZakzcPzaKdWNMwqqNhmRtQybeCBnMjt8PGmhQX1PwCMrWiz+chqhhQHW/0dRCetLxXec0PndATckwQSoF+C5Fmcc7FWNn3AIZWy/gwoiYQ2mTNQXnDSpfrdyvMI6kdui2aM7uke0t0QrdhvUlXMR/P7GIs7HVHR1Oq16D+H+bvhZgIQ+apaNXWLXdZezbwSFG4PuV9QuOSkR4Eb3TQ3zGp0xQoDqJmETn9A6jg/JiiF65xJSdAHhSKTyUJRnEoo+ewP1wA5u68TD9dXpzNbO7TqTYDM5XIcradlQG/3R4gdMbzX+K90wb0chEAHIgOGztf72+vjtLMdA0o/4zF4PSt9EtVk93oyQ== cardno:20 603 474"
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
  };
}
