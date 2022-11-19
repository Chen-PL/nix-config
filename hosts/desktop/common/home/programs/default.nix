{
  imports = [
    ./chromium
    ./emacs
    ./exa
    ./fzf
    ./git
    ./nix-index
    ./opam
    ./ssh
    ./vscode
    ./zsh
  ];

  programs = {
    home-manager.enable = true;
    tmux.enable = true;
    vim.enable = true;
  };
}
