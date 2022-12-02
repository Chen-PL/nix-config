{ inputs, lib, config, pkgs, hostname, username, ... }:

{
  imports = [
    ./locale
    ./xserver
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

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  environment.systemPackages = with pkgs; [
    gnupg
    pinentry-gnome
    pinentry-curses
  ];

  services = {
    # For 1Password (otherwise it keeps asking for two-refactor)
    gnome.gnome-keyring.enable = true;

    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };

    udev.packages = [ pkgs.yubikey-personalization ];

    # For udiskie
    udisks2.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
