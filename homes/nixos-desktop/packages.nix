{ pkgs, ... }:

{
  home.packages = with pkgs; [
    _1password-gui # Multi-platform password manager
    arandr # A simple visual front end for XRandR
    aspell # Spell checker for many languages
    avidemux # Free video editor designed for simple video editing tasks
    blanket # Listen to different sounds
    file # A program that shows the type of files
    geeqie # Lightweight GTK based image viewer
    shutter # Screenshot and annotation tool
    jq # A lightweight and flexible command-line JSON processor
    lm_sensors # Tools for reading hardware sensors
    mullvad-vpn # Client for Mullvad VPN
    okular # KDE document viewer
    pavucontrol # PulseAudio Volume Control
    playerctl # Command-line utility and library for controlling media players that implement MPRIS
    screenfetch # Fetches system/theme information in terminal for Linux desktop screenshots
    spotify # Play music from the Spotify music service
    spotify-tui # Spotify for the terminal written in Rust
    tdesktop # Telegram Desktop messaging app
    vlc # Cross-platform media player and streaming server
    dolphin # KDE file manager

    # Haskell
    (haskellPackages.ghcWithPackages            # The Glasgow Haskell Compiler
      (hsPkgs: with hsPkgs; [
        xmobar # A Minimalistic Text Based Status Bar
        xmonad # A tiling window manager
        xmonad-contrib # Community-maintained extensions for xmonad
      ])
    )

    nur.repos.yes.electronic-wechat
    nur.repos.linyinfeng.icalingua-plus-plus
  ];
}
