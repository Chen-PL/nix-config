{ inputs, lib, config, pkgs, hostname, username, ... }:

{
  imports = [
    ./locale
    ./security
    ./xserver
    ./impermanence.nix
  ];

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

  users.users.${username}.extraGroups = [
    "audio"
    "docker" # equivalent to being root!
    "networkmanager"
    "vboxusers"
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

  # For udiskie
  services.udisks2.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
