{ config, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "ahci"
    "nvme"
    "usbhid"
    "uas"
    "sd_mod"
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/29199ab8-28f0-46c5-81a0-301055e41c9e";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2A1A-04EC";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/b1d39a7e-014c-47a9-835d-b95c96358f77"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
