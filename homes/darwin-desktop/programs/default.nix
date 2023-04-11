{
  imports = [
    ./gpg
  ];

  programs.zsh = {
    shellAliases = {
      update-hm = "home-manager switch --flake ~/nix-config/.#chen@macbook-air-2021";
      update-sys = ''
        nix build ~/nix-config/.\#darwinConfigurations.macbook-air-2021.system -o /tmp/nix-result && \
        /tmp/nix-result/sw/bin/darwin-rebuild switch --flake ~/nix-config && \
        rm -rf /tmp/nix-result
      '';
    };
  };
}
