{ inputs, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    dpi = 180;
    layout = "us";
    displayManager = {
      sddm.enable = true;
      sessionPackages = [
        inputs.hyprland.packages.${pkgs.system}.default
        pkgs.sway
      ];
    };
    libinput = {
      enable = true;
      # disabling mouse acceleration
      mouse.accelProfile = "flat";
      # disabling touchpad acceleration
      touchpad.accelProfile = "flat";
    };
  };

  environment = {
    sessionVariables = {
      _JAVA_AWT_WM_NONREPARENTING = "1";
      XCURSOR_SIZE = "24";
    };
  };
  hardware.video.hidpi.enable = true;
}
