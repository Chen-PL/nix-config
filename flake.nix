{
  description = "Chen's Home Manager & NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hardware.url = "github:nixos/nixos-hardware";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      pkgs-x86_64 = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        intel-nuc-12 = nixpkgs.lib.nixosSystem {
          pkgs = pkgs-x86_64;
          specialArgs = { inherit inputs; };
          modules = [
            ./devices/lg-42c2
            ./hosts/desktop/linux/intel-nuc-12/nixos
          ];
        };
        thinkpad-x1c-5th = nixpkgs.lib.nixosSystem {
          pkgs = pkgs-x86_64;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/desktop/linux/thinkpad-x1c-5th/nixos
          ];
        };
      };

      homeConfigurations = {
        "chen@intel-nuc-12" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs-x86_64;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./hosts/desktop/linux/intel-nuc-12/home
          ];
        };
        "chen@thinkpad-x1c-5th" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs-x86_64;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./hosts/desktop/linux/thinkpad-x1c-5th/home
          ];
        };
      };
    };
}
