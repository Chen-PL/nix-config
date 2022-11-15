{ pkgs, ... }:

let
  abella-modded = pkgs.callPackage ./abella-modded {
    ocamlPackages = pkgs.ocaml-ng.ocamlPackages_4_12;
  };
in
{
  home.packages = with pkgs; [
    _1password-gui # Multi-platform password manager
    abella-modded # Abella theorem prover modded by Jimmy
    arandr # A simple visual front end for XRandR
    aspell # Spell checker for many languages
    avidemux # Free video editor designed for simple video editing tasks
    blanket # Listen to different sounds
    docker-compose # Docker CLI plugin to define and run multi-container applications with Docker
    file # A program that shows the type of files
    gcc # GNU Compiler Collection
    geeqie # Lightweight GTK based image viewer
    gnumake # A tool to control the generation of non-source files from sources
    htop # An interactive process viewer
    jq # A lightweight and flexible command-line JSON processor
    kdenlive # Video editor
    lm_sensors # Tools for reading hardware sensors
    mediainfo # Supplies technical and tag information about a video or audio file
    mullvad-vpn # Client for Mullvad VPN
    nixpkgs-fmt # Nix code formatter for nixpkgs
    pavucontrol # PulseAudio Volume Control
    playerctl # Command-line utility and library for controlling media players that implement MPRIS
    rnix-lsp # A work-in-progress language server for Nix, with syntax checking and basic completion
    screenfetch # Fetches system/theme information in terminal for Linux desktop screenshots
    spotify # Play music from the Spotify music service
    spotify-tui # Spotify for the terminal written in Rust
    stress # Simple workload generator for POSIX systems. It imposes a configurable amount of CPU, memory, I/O, and disk stress on the system
    sublime4 # Sophisticated text editor for code, markup and prose (and Abella)
    texlive.combined.scheme-full # TeX Live environment for scheme-full
    vlc # Cross-platform media player and streaming server
    wget # Tool for retrieving files using HTTP, HTTPS, and FTP
    xfce.thunar # Xfce file manager
    xorg.xev # Print contents of X events
    xorg.xsetroot # Classic X utility to set your root window background to a given pattern or color

    # Fonts
    fira # Sans-serif font for Firefox OS
    fira-code # Monospace font with programming ligatures
    fira-code-symbols # FiraCode unicode ligature glyphs in private use area
    nerdfonts # Iconic font aggregator, collection, & patcher. 3,600+ icons, 50+ patched fonts
    source-code-pro # Monospaced font family for user interface and coding environments
    wqy_microhei # A (mainly) Chinese Unicode font
    wqy_zenhei # A (mainly) Chinese Unicode font

    # Haskell
    (haskellPackages.ghcWithPackages            # The Glasgow Haskell Compiler
      (hsPkgs: with hsPkgs; [
        xmobar # A Minimalistic Text Based Status Bar
        xmonad # A tiling window manager
        xmonad-contrib # Community-maintained extensions for xmonad
      ])
    )
    haskellPackages.stack # The Haskell Tool Stack
    haskellPackages.cabal-install # The command-line interface for Cabal and Hackage
    haskellPackages.haskell-language-server # LSP server for GHC
  ];
}
