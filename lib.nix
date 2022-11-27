inputs: outputs:

let
  inherit (builtins) elem concatMap;
  inherit (inputs) nixpkgs;
  inherit (inputs.darwin.lib) darwinSystem;
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  inherit (nixpkgs.lib) genAttrs nixosSystem;
  inherit (nixpkgs.lib.attrsets) mapAttrs' nameValuePair;

  withPrefix = prefix: map (tag: ./${prefix}/${tag});
  concatWithDash = x: y: "${x}-${y}";
  nixosTags = server: [ "unix" "nixos" ] ++
    (if server then [ "nixos-server" ] else [ "desktop" "nixos-desktop" ]);
  darwinTags = [ "unix" "desktop" "darwin-desktop" ];
  defaultSpecialArgs = { inherit inputs outputs; };
  mkOverlays = tag:
    let overlays = import ./overlays/${tag}; in
    with overlays; [ additions modifications ];
  mkConfigs = prefix: mkFunc: mapAttrs' (hostname: config: nameValuePair (prefix + hostname)
    (mkFunc ({ inherit hostname; } // config)));
in
rec {
  architectures = [ "aarch64" "x86_64" ];
  platforms = [ "darwin" "linux" ];
  systems = [ "aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux" ];
  forAllSystems = genAttrs systems;

  importWithPkgs = path: forAllSystems (system:
    let pkgs = nixpkgs.legacyPackages.${system};
    in import path { inherit pkgs; }
  );
  packages = importWithPkgs ./pkgs;
  devShells = importWithPkgs ./shell.nix;

  mkPkgs = arch: platform:
    assert elem arch architectures;
    assert elem platform platforms;
    let
      system = concatWithDash arch platform;
    in
    import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = concatMap mkOverlays [ "unix" platform ];
    };

  mkNixosConfig = { arch ? "x86_64", hostname, server ? false, specialArgs ? { }, ... }:
    assert elem arch architectures;
    nixosSystem {
      pkgs = mkPkgs arch "linux";
      modules = withPrefix "systems" (nixosTags server) ++ [ ./hosts/${hostname}/nixos ];
      specialArgs = defaultSpecialArgs // specialArgs;
    };

  mkDarwinConfig = { arch ? "aarch64", hostname, specialArgs ? { }, ... }:
    assert elem arch architectures;
    let
      system = concatWithDash arch "darwin";
    in
    darwinSystem {
      inherit system;
      pkgs = mkPkgs arch "darwin";
      modules = withPrefix "systems" darwinTags ++ [ ./hosts/${hostname}/macos ];
      specialArgs = defaultSpecialArgs // specialArgs;
    };

  mkHomeConfig = { arch ? "x86_64", platform ? "linux", hostname, server ? false, specialArgs ? { }, ... }:
    assert elem arch architectures;
    assert elem platform platforms;
    let
      tags = if platform == "linux" then nixosTags server else darwinTags;
    in
    homeManagerConfiguration {
      pkgs = mkPkgs arch platform;
      modules = withPrefix "homes" tags ++ [ ./hosts/${hostname}/home ];
      extraSpecialArgs = defaultSpecialArgs // specialArgs;
    };

  mkNixosConfigs = mkConfigs "" mkNixosConfig;
  mkDarwinConfigs = mkConfigs "" mkDarwinConfig;
  mkHomeConfigs = username: mkConfigs "${username}@" mkHomeConfig;
}
