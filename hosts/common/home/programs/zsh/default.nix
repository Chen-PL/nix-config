{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    historySubstringSearch.enable = true;

    dirHashes = {
      dl = "$HOME/Downloads";
      hm = "$HOME/.config/nixpkgs";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "extract" "git" "sudo" ];
      theme = "robbyrussell";
    };

    shellAliases = {
      update     = "home-manager switch";
      update-sys = "sudo nixos-rebuild switch";
    };

    initExtra = ''
      [[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
    '';
  };
}
