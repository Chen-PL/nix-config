inputs: outputs:

let
  inherit (builtins) elem concatMap;
  inherit (inputs) nixpkgs;
  inherit (inputs.darwin.lib) darwinSystem;
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  inherit (nixpkgs.lib) genAttrs nixosSystem;
  inherit (nixpkgs.lib.attrsets) filterAttrs mapAttrs' nameValuePair;

  withPrefix = prefix: map (tag: ./${prefix}/${tag});
  concatWithDash = x: y: "${x}-${y}";
  nixosTags = server: [ "unix" "nixos" ] ++
    (if server then [ "nixos-server" ] else [ "desktop" "nixos-desktop" ]);
  darwinTags = [ "unix" "desktop" "darwin-desktop" ];
  filterArgs = filterAttrs (n: v: !(elem n [ "arch" "server" ]));
  defaultSpecialArgs = { inherit inputs outputs; };
  mkOverlays = tag:
    let overlays = import ./overlays/${tag}; in
    with overlays; [ additions modifications ];
  mkConfigs = mkFunc: prefix: username:
    mapAttrs' (hostname: config: nameValuePair
      ((if prefix then "${username}@" else "") + hostname)
      (mkFunc ({ inherit username; inherit hostname; } // config)));
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

  mkNixosConfig =
    { arch ? "x86_64"
    , username
    , hostname
    , server ? false
    , ...
    }@args:
      assert elem arch architectures;
      nixosSystem {
        pkgs = mkPkgs arch "linux";
        modules = withPrefix "systems" (nixosTags server) ++ [ ./hosts/${hostname}/nixos ];
        specialArgs = defaultSpecialArgs // (filterArgs args);
      };

  mkDarwinConfig =
    { arch ? "aarch64"
    , username
    , hostname
    , ...
    }@args:
      assert elem arch architectures;
      let
        system = concatWithDash arch "darwin";
      in
      darwinSystem {
        inherit system;
        pkgs = mkPkgs arch "darwin";
        modules = withPrefix "systems" darwinTags ++ [ ./hosts/${hostname}/macos ];
        specialArgs = defaultSpecialArgs // (filterArgs args);
      };

  mkHomeConfig =
    { arch ? "x86_64"
    , platform ? "linux"
    , username
    , hostname
    , server ? false
    , ...
    }@args:
      assert elem arch architectures;
      assert elem platform platforms;
      let
        tags = if platform == "linux" then nixosTags server else darwinTags;
      in
      homeManagerConfiguration {
        pkgs = mkPkgs arch platform;
        modules = withPrefix "homes" tags ++ [ ./hosts/${hostname}/home ];
        extraSpecialArgs = defaultSpecialArgs // (filterArgs args);
      };

  mkNixosConfigs = mkConfigs mkNixosConfig false;
  mkDarwinConfigs = mkConfigs mkDarwinConfig false;
  mkHomeConfigs = mkConfigs mkHomeConfig true;
}
