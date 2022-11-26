# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) { } }: {
  abella-modded = pkgs.callPackage ./abella-modded {
    ocamlPackages = pkgs.ocaml-ng.ocamlPackages_4_12;
  };
  cgit = pkgs.callPackage ./cgit {};
  icalingua = pkgs.callPackage ./icalingua {};
}
