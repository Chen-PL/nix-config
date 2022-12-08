inputs: outputs:

let
  root = "../..";

  inherit (builtins) elem concatMap;
  inherit (inputs) nixpkgs nur nix-colors;
  inherit (inputs.darwin.lib) darwinSystem;
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  inherit (nixpkgs.lib) attrValues genAttrs nixosSystem;
  inherit (nixpkgs.lib.attrsets) filterAttrs mapAttrs' nameValuePair;

  withPrefix = prefix: map (tag: ./${root}/${prefix}/${tag});
  concatWithDash = x: y: "${x}-${y}";
  nixosTags = server: [ "unix" "nixos" ] ++
    (if server then [ "nixos-server" ] else [ "desktop" "nixos-desktop" ]);
  darwinTags = [ "unix" "desktop" "darwin-desktop" ];
  filterArgs = filterAttrs (n: v: !(elem n [ "arch" "server" ]));
  defaultSpecialArgs = {
    inherit inputs outputs;
    tools = import ./${root}/lib/tools { inherit (nixpkgs) lib; };
  };
  mkOverlays = tag:
    let overlays = import ./${root}/overlays/${tag}; in
    with overlays; [ additions modifications nur.overlay ];
  mkModules = moduleType: attrValues (import ./${root}/modules/${moduleType});
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
        modules = withPrefix "systems" (nixosTags server) ++ [ ./${root}/hosts/${hostname}/nixos ] ++ mkModules "nixos";
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
        modules = withPrefix "systems" darwinTags ++ [ ./${root}/hosts/${hostname}/macos ] ++ mkModules "nixos";
        specialArgs = defaultSpecialArgs // filterArgs args;
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
        pkgs = mkPkgs arch platform;
        nur-modules = import nur { inherit pkgs; nurpkgs = pkgs; };
        homeSpecialArgs = if server then { } else {
          inherit nix-colors;
          inherit (nur-modules.repos.rycee) firefox-addons;
        };
      in
      homeManagerConfiguration {
        inherit pkgs;
        modules = withPrefix "homes" tags ++ [ ./${root}/hosts/${hostname}/home ] ++ mkModules "home-manager";
        extraSpecialArgs = defaultSpecialArgs // homeSpecialArgs // filterArgs args;
      };

  mkNixosConfigs = mkConfigs mkNixosConfig false;
  mkDarwinConfigs = mkConfigs mkDarwinConfig false;
  mkHomeConfigs = mkConfigs mkHomeConfig true;
}
