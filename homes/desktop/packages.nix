{ pkgs, ... }:

{
  home.packages = with pkgs; [
    abella-modded # Interactive theorem prover (modded by Jimmy)
    coq # Coq proof assistant
    docker-compose # Docker CLI plugin to define and run multi-container applications with Docker
    gnumake
    htop # An interactive process viewer
    mediainfo # Supplies technical and tag information about a video or audio file
    nil # Yet another language server for Nix
    nixpkgs-fmt # Nix code formatter for nixpkgs
    nodejs
    ott # A tool for the working semanticist
    statix # Lints and suggestions for the nix programming language
    stress # Simple workload generator for POSIX systems. It imposes a configurable amount of CPU, memory, I/O, and disk stress on the system
    sublime4 # Sophisticated text editor for code, markup and prose (and Abella)
    texlive.combined.scheme-full # TeX Live environment for scheme-full
    unzip
    zoom-us # zoom.us video conferencing application

    # Haskell
    haskellPackages.stack # The Haskell Tool Stack
    haskellPackages.cabal-install # The command-line interface for Cabal and Hackage
    haskellPackages.haskell-language-server # LSP server for GHC
  ];
}
