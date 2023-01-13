{ username, ... }:

{
  imports = [
    ./packages.nix
  ];

  home = {
    homeDirectory = "/home/${username}";
    sessionPath = [ "$HOME/bin" ];
  };

  programs.zsh.initExtra = "source ~/.nix-profile/etc/profile.d/nix.sh";
}
