{
  imports = [
    ./exa
    ./fzf
    ./git
    ./ssh
    ./zsh
  ];

  programs = {
    home-manager.enable = true;
    tmux.enable = true;
    vim.enable = true;
  };
}
