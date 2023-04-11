{
  imports = [
    ./alacritty
    ./emacs
    # ./firefox
    ./ssh
    ./sublime
    ./vscode
  ];

  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;
    };
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
