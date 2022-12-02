{
  imports = [
    ./exa
    ./git
    ./zsh
  ];

  programs = {
    home-manager.enable = true;
    tmux.enable = true;
    vim.enable = true;
  };
}
