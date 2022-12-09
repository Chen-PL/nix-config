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
<<<<<<< HEAD
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=32G" "mode=755" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/ec092543-e2ea-43c4-8d66-6f9cd76afde3";
=======
    device = "/dev/disk/by-uuid/29199ab8-28f0-46c5-81a0-301055e41c9e";
>>>>>>> parent of 4cfb317 (try impermanence)
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D63B-93B4";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/0ec4710f-a7d8-4a18-887a-8e705863c916"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
