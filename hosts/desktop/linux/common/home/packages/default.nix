{ pkgs, ... }:

{
  home.packages = with pkgs; [
    arandr # A simple visual front end for XRandR
    aspell # Spell checker for many languages
    avidemux # Free video editor designed for simple video editing tasks
    blanket # Listen to different sounds
    docker-compose # Docker CLI plugin to define and run multi-container applications with Docker
    file # A program that shows the type of files
    geeqie # Lightweight GTK based image viewer
    jq # A lightweight and flexible command-line JSON processor
    lm_sensors # Tools for reading hardware sensors
    mediainfo # Supplies technical and tag information about a video or audio file
    mullvad-vpn # Client for Mullvad VPN
    pavucontrol # PulseAudio Volume Control
    playerctl # Command-line utility and library for controlling media players that implement MPRIS
    screenfetch # Fetches system/theme information in terminal for Linux desktop screenshots
    spotify # Play music from the Spotify music service
    spotify-tui # Spotify for the terminal written in Rust
    stress # Simple workload generator for POSIX systems. It imposes a configurable amount of CPU, memory, I/O, and disk stress on the system
    sublime4 # Sophisticated text editor for code, markup and prose (and Abella)
    texlive.combined.scheme-full # TeX Live environment for scheme-full
    vlc # Cross-platform media player and streaming server
    xfce.thunar # Xfce file manager

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
