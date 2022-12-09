{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      gnupg
      pinentry-gnome
      pinentry-curses
    ];

    shellInit = ''
      export GPG_TTY="$(tty)"
      gpg-connect-agent /bye
      export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
    '';
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services = {
    # For 1Password (otherwise it keeps asking for two-refactor)
    gnome.gnome-keyring.enable = true;

    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };

    udev.packages = [ pkgs.yubikey-personalization ];

    # Smart card
    pcscd.enable = true;
  };

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
}
