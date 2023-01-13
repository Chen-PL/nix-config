{ pkgs, ... }:

{
  home.packages = with pkgs; [
    abella-modded # Interactive theorem prover (modded by Jimmy)
    coq # Coq proof assistant
    docker-compose # Docker CLI plugin to define and run multi-container applications with Docker
    nil # Yet another language server for Nix
    nixpkgs-fmt # Nix code formatter for nixpkgs
    ott # A tool for the working semanticist
    statix # Lints and suggestions for the nix programming language
    texlive.combined.scheme-full # TeX Live environment for scheme-full
  ];
}
