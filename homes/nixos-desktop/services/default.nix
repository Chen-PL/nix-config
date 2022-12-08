{
  imports = [
    ./picom
    ./polybar
    ./random-background
    ./udiskie
    ./screenlocker.nix
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
