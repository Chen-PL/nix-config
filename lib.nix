inputs: outputs:

let
  withPrefix = prefix: map (tag: ./${prefix}/${tag});
  concatWithDash = x: y: "${x}-${y}";
  nixosTags = server: [ "unix" "nixos" ] ++
    (if server then [ "nixos-server" ] else [ "desktop" "nixos-desktop" ]);
  darwinTags = [ "unix" "desktop" "darwin-desktop" ];
  defaultSpecialArgs = { inherit inputs outputs; };
in
rec {
  architectures = [ "aarch64" "x86_64" ];
  platforms = [ "darwin" "linux" ];
  systems = [ "aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux" ];
  forAllSystems = inputs.nixpkgs.lib.genAttrs systems;

  importWithPkgs = path: forAllSystems (system:
    let pkgs = inputs.nixpkgs.legacyPackages.${system};
    in import path { inherit pkgs; }
  );
  packages = importWithPkgs ./pkgs;
  devShells = importWithPkgs ./shell.nix;
  overlays = import ./overlays;

  mkPkgs = system: import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = with overlays; [ additions modifications ];
  };

  mkNixosConfig = { arch ? "x86_64", hostname, server ? false, specialArgs ? { } }:
    assert builtins.elem arch architectures;
    let
      system = concatWithDash arch "linux";
    in
    inputs.nixpkgs.lib.nixosSystem {
      pkgs = mkPkgs system;
      modules = withPrefix "systems" (nixosTags server) ++ [ ./hosts/${hostname}/nixos ];
      specialArgs = defaultSpecialArgs // specialArgs;
    };

  mkDarwinConfig = { arch ? "aarch64", hostname, specialArgs ? { } }:
    assert builtins.elem arch architectures;
    let
      system = concatWithDash arch "darwin";
    in
    inputs.darwin.lib.darwinSystem {
      inherit system;
      pkgs = mkPkgs system;
      modules = withPrefix "systems" darwinTags ++ [ ./hosts/${hostname}/macos ];
      specialArgs = defaultSpecialArgs // specialArgs;
    };

  mkHomeConfig = { arch ? "x86_64", platform ? "linux", hostname, server ? false, specialArgs ? { } }:
    assert builtins.elem arch architectures;
    assert builtins.elem platform platforms;
    let
      system = concatWithDash arch platform;
      tags = if platform == "linux" then nixosTags server else darwinTags;
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = mkPkgs system;
      modules = withPrefix "homes" tags ++ [ ./hosts/${hostname}/home ];
      extraSpecialArgs = defaultSpecialArgs // specialArgs;
    };
}
