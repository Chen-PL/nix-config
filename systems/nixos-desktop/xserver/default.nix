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
    
    libinput.enable = true;
  };
  
  # HiDPI
  hardware.video.hidpi.enable = true;
  services.xserver.dpi = 180;
}
