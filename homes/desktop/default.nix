{ nix-colors, ... }:

{
  imports = [
    nix-colors.homeManagerModule
    ./fonts.nix
    ./packages.nix
    ./programs
  ];

  colorScheme = nix-colors.colorSchemes.nord;
  # config.colorScheme.colors.baseXX
}
