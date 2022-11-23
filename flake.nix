{
  description = "Chen's Home Manager & NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hardware.url = "github:nixos/nixos-hardware";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
  };

  outputs = { nixpkgs, darwin, home-manager, ... }@inputs:
    let
      pkgs-x86_64-linux = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        intel-nuc-12 = nixpkgs.lib.nixosSystem {
          pkgs = pkgs-x86_64-linux;
          specialArgs = { inherit inputs; };
          modules = [
            ./devices/lg-42c2
            ./hosts/desktop/linux/intel-nuc-12/nixos
          ];
        };

        thinkpad-x1c-5th = nixpkgs.lib.nixosSystem {
          pkgs = pkgs-x86_64-linux;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/desktop/linux/thinkpad-x1c-5th/nixos
          ];
        };
        linode = nixpkgs.lib.nixosSystem {
          pkgs = pkgs-x86_64-linux;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/server/linode/nixos
          ];
        };
      };

      darwinConfigurations = {
        macbook-air-2021 = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./hosts/desktop/darwin/macbook-air-2021/macos
          ];
          inherit inputs;
        };
      };

      homeConfigurations = {
        "chen@intel-nuc-12" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs-x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./hosts/desktop/linux/intel-nuc-12/home
          ];
        };
        "chen@thinkpad-x1c-5th" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs-x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./hosts/desktop/linux/thinkpad-x1c-5th/home
          ];
        };
        "chen@linode" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs-x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./hosts/server/linode/home
          ];
        };
        "chen@macbook-air-2021" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./hosts/desktop/darwin/macbook-air-2021/home
          ];
        };
      };
    };
}
