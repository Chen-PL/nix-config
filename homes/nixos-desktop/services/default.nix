{
  imports = [
    # ./picom
    # ./polybar
    # ./random-background
    # ./udiskie
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
