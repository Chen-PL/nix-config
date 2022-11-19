{
  services.picom = {
    enable = true;
    backend = "glx";
    fade = true;
    fadeDelta = 5;
    opacityRules = [
      "90:class_g = 'Polybar'"
      "90:class_g = 'Sublime_text'"
      "90:class_g = 'Code'"
    ];
    shadow = true;
    shadowOpacity = 0.75;
    vSync = true;
  };
}
