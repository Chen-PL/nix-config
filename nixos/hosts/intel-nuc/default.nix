{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "i915.force_probe=46a6" ];

    initrd.kernelModules = [ "kvm-intel" ];
  };

  networking = {
    hostName = "intel-nuc";
    interfaces = {
      enp86s0.useDHCP = lib.mkDefault true;
      wlo1.useDHCP = lib.mkDefault true;
    };
  };

  # Video settings
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  services.xserver.videoDrivers = [ "modesetting" ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}