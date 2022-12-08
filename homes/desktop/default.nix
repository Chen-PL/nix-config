{ nix-colors, ... }:

{
  imports = [
    ./colors.nix
    ./fonts.nix
    ./packages.nix
    ./programs
  ];
}
