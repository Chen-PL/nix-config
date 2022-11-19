{
  services.xserver = {
    enable = true;
    layout = "us";

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };

    displayManager = {
      defaultSession = "none+xmonad";
      lightdm.enable = true;
    };
  };
}
