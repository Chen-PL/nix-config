{ pkgs ? (import ../nixpkgs.nix) { } }: {
  icalingua = pkgs.callPackage ./icalingua {};
}
