{
  description = "Chen's NixOS, Darwin & Home Manager configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
    hardware.url = "github:nixos/nixos-hardware";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
  };

  outputs = inputs@{ self, ... }:
    let
      inherit (self) outputs;
      inherit (import ./lib/flake inputs outputs)
        importWithPkgs mkNixosConfigs mkDarwinConfigs mkHomeConfigs;

      hosts = {
        username = "chen";
        nixos = {
          intel-nuc-12 = {
            arch = "x86_64";
            platform = "linux";
            stateVersion = "23.05";
          };
          thinkpad-x1c-5th = {
            arch = "x86_64";
            platform = "linux";
            stateVersion = "22.11";
          };
          linode-server = {
            server = true;
            arch = "x86_64";
            platform = "linux";
            stateVersion = "22.11";
          };
        };
        darwin = {
          macbook-air-2021 = {
            arch = "aarch64";
            platform = "darwin";
            stateVersion = "22.11";
          };
        };
      };
    in
    with hosts; {
      packages = importWithPkgs ./pkgs;
      devShells = importWithPkgs ./shell.nix;

      overlays = import ./overlays;
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = mkNixosConfigs username nixos;
      darwinConfigurations = mkDarwinConfigs username darwin;
      homeConfigurations = mkHomeConfigs username (nixos // darwin);
    };
}
