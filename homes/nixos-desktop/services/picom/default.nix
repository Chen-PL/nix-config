{
  services.picom = {
    enable = true;
    backend = "glx";
    fade = true;
    fadeDelta = 5;
    opacityRules = [
      "95:class_g = 'Polybar'"
      "95:class_g = 'Sublime_text'"
      "95:class_g = 'Code'"
    ];
    vSync = true;
    settings = {
      # corner-radius = 15;

      blur-method = "dual_kawase";
      blur-strength = 5;
      alpha-step = 0.06;
      detect-transient = true;
      detect-client-opacity = true;
    };
  };
}
