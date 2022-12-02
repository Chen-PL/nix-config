{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      yubikey-manager-qt
      pam_u2f
    ];
    xdg.configFile."Yubico/u2f_keys".source = ./u2f_keys;
  };
}
