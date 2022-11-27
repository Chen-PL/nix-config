{ pkgs ? (import ../nixpkgs.nix) { } }:

let
  merge = builtins.foldl' (total: sub: total // (import sub { inherit pkgs; })) { };
  subPackages = [ ./unix ./linux ./darwin ];
in
merge subPackages
