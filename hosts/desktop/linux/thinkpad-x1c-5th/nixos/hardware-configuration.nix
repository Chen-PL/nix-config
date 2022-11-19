{ config, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "uas" "sd_mod" "rtsx_pci_sdmmc" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f53c7311-d7b7-49ab-ba17-49c4cae33f1a";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D752-9C8F";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/49a9a18a-a601-4093-bc0a-b2ec58ce00e4"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
