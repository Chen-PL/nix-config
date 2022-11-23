{ pkgs, ... }:

let
  abella-modded = pkgs.callPackage ./abella-modded {
    ocamlPackages = pkgs.ocaml-ng.ocamlPackages_4_12;
  };
in
{
  home.packages = with pkgs; [
    abella-modded # Abella theorem prover modded by Jimmy
    coq # Coq proof assistant
    htop # An interactive process viewer
    nixpkgs-fmt # Nix code formatter for nixpkgs
    ott # A tool for the working semanticist
    rnix-lsp # A work-in-progress language server for Nix, with syntax checking and basic completion

    # Fonts
    fira # Sans-serif font for Firefox OS
    fira-code # Monospace font with programming ligatures
    fira-code-symbols # FiraCode unicode ligature glyphs in private use area
    nerdfonts # Iconic font aggregator, collection, & patcher. 3,600+ icons, 50+ patched fonts
    source-code-pro # Monospaced font family for user interface and coding environments
    wqy_microhei # A (mainly) Chinese Unicode font
    wqy_zenhei # A (mainly) Chinese Unicode font
  ];
}
