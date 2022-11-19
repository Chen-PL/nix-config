{
  imports = [
    ./picom
    ./polybar
    ./random-background
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
