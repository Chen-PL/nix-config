{ inputs, lib, pkgs, ... }:

{
  imports = [
    inputs.hardware.nixosModules.common-pc
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-intel
    ./hardware-configuration.nix
  ];

  system.stateVersion = "22.11";

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
    hostName = "intel-nuc-12";
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
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  services.xserver.videoDrivers = [ "modesetting" ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # HiDPI
  hardware.video.hidpi.enable = true;
  services.xserver.dpi = 180;

  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    QT_SCALE_FACTOR = "2";
  };
}
