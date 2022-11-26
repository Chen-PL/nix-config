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
    in
    {
      packages = lib.packages;
      devShells = lib.devShells;

      overlays = import ./overlays;
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        intel-nuc-12 = lib.mkNixosConfig {
          hostname = "intel-nuc-12";
        };
        thinkpad-x1c-5th = lib.mkNixosConfig {
          hostname = "thinkpad-x1c-5th";
        };
        linode-server = lib.mkNixosConfig {
          hostname = "linode-server";
          server = true;
        };
      };

      darwinConfigurations = {
        macbook-air-2021 = lib.mkDarwinConfig {
          hostname = "macbook-air-2021";
        };
      };

      homeConfigurations = {
        "chen@intel-nuc-12" = lib.mkHomeConfig {
          hostname = "intel-nuc-12";
        };
        "chen@thinkpad-x1c-5th" = lib.mkHomeConfig {
          hostname = "thinkpad-x1c-5th";
        };
        "chen@linode-server" = lib.mkHomeConfig {
          hostname = "linode-server";
          server = true;
        };
        "chen@macbook-air-2021" = lib.mkHomeConfig {
          arch = "aarch64";
          platform = "darwin";
          hostname = "macbook-air-2021";
        };
      };
    };
}
