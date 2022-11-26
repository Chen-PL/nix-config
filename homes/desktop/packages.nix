{ pkgs, customPkgs, ... }:

let
  packages = with pkgs; [
    appimage-run
    coq # Coq proof assistant
    docker-compose # Docker CLI plugin to define and run multi-container applications with Docker
    htop # An interactive process viewer
    mediainfo # Supplies technical and tag information about a video or audio file
    nil # Yet another language server for Nix
    nixpkgs-fmt # Nix code formatter for nixpkgs
    ott # A tool for the working semanticist
    stress # Simple workload generator for POSIX systems. It imposes a configurable amount of CPU, memory, I/O, and disk stress on the system
    texlive.combined.scheme-full # TeX Live environment for scheme-full

    # Fonts
    fira # Sans-serif font for Firefox OS
    fira-code # Monospace font with programming ligatures
    fira-code-symbols # FiraCode unicode ligature glyphs in private use area
    nerdfonts # Iconic font aggregator, collection, & patcher. 3,600+ icons, 50+ patched fonts
    source-code-pro # Monospaced font family for user interface and coding environments
    wqy_microhei # A (mainly) Chinese Unicode font
    wqy_zenhei # A (mainly) Chinese Unicode font

    # Haskell
    haskellPackages.stack # The Haskell Tool Stack
    haskellPackages.cabal-install # The command-line interface for Cabal and Hackage
    haskellPackages.haskell-language-server # LSP server for GHC
  ];

  customPackages = with customPkgs; [
    abella-modded # Abella theorem prover modded by Jimmy
  ];
in
{
  home.packages = packages ++ customPackages;
}
