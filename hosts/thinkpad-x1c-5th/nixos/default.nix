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
    kernelParams = [ ];

    initrd.kernelModules = [ "kvm-intel" ];
  };

  networking.interfaces = {
    enp0s31f6.useDHCP = lib.mkDefault true;
    wlp4s0.useDHCP = lib.mkDefault true;
  };
}
