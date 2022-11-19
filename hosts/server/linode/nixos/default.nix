{ inputs, lib, pkgs, ... }:

{
  imports = [
    ../../common/nixos
    ./hardware-configuration.nix
  ];

  system.stateVersion = "22.11";

  boot = {
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        forceInstall = true;
        extraConfig = ''
          serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
          terminal_input serial;
          terminal_output serial
        '';
      };
      timeout = 10;
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "console=ttyS0,19200n8" ];
  };

  networking = {
    hostName = "linode";
    useDHCP = false;
    interfaces.eth0.useDHCP = true;
    usePredictableInterfaceNames = false;
  };

  time.timeZone = "Asia/Hong_Kong";
  i18n.defaultLocale = "en_US.UTF-8";

  # Diagnostic Tools
  environment.systemPackages = with pkgs; [
    inetutils
    mtr
    sysstat
  ];
}
