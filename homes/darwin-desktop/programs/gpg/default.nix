{ pkgs, ... }:

{
  home.file = {
    ".gnupg/gpg.conf".source = ./gpg.conf;
    ".gnupg/gpg-agent.conf".text = ''
      enable-ssh-support
      ttyname $GPG_TTY
      default-cache-ttl 60
      max-cache-ttl 120
      pinentry-program /opt/homebrew/bin/pinentry-mac
    '';
  };
}
