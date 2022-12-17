{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (retroarch.override {
      cores = [
        libretro.genesis-plus-gx
        libretro.snes9x
        libretro.beetle-psx-hw
      ];
    })
    libretro.genesis-plus-gx
    libretro.snes9x
    libretro.beetle-psx-hw
  ];
}
