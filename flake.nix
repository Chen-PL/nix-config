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

    hardware.url = "github:nixos/nixos-hardware";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
  };

  outputs = { self, ... }@inputs:
    let
      inherit (self) outputs;
      lib = import ./lib.nix inputs outputs;

      hosts = {
        username = "chen";
        nixos = {
          intel-nuc-12     = { arch = "x86_64";  platform = "linux"; };
          thinkpad-x1c-5th = { arch = "x86_64";  platform = "linux"; };
          linode-server    = { arch = "x86_64";  platform = "linux";  server = true; };
        };
        darwin = {
          macbook-air-2021 = { arch = "aarch64"; platform = "darwin"; };
        };
      };
    in
    with hosts; {
      packages = lib.packages;
      devShells = lib.importWithPkgs ./shell.nix;

      overlays = import ./overlays;
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = lib.mkNixosConfigs username nixos;
      darwinConfigurations = lib.mkDarwinConfigs username darwin;
      homeConfigurations = lib.mkHomeConfigs username (nixos // darwin);
    };
}
