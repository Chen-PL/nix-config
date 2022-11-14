{ pkgs, ... }:

let
  nord = import ../../themes/nord.nix;
in
{
  services.polybar = {
    enable = true;
    script = ''
      polybar top &
      polybar bottom &
    '';
    package = pkgs.polybar.override {
      alsaSupport = true;
      mpdSupport = true;
      nlSupport = true;
      pulseSupport = true;
    };
    config = with nord; {
      "bar/base" = {
        width = "100%";
        height = "3%";
        offset-x = 0;
        offset-y = 0;
        radius = 0;
        dpi = 180; # HiDPI
        background = nord0;
        foreground = nord9;
        line-size = 6;
        padding = 2;
        cursor-click = "pointer";
        cursor-scroll = "ns-resize";
        enable-ipc = true;
        font-0 = "FiraCode Nerd Font:style=Light:size=10;3";
        font-1 = "WenQuanYi Micro Hei:style=Regular:size=10;3";
        module-margin = 1;
        separator = "%{F#D8DEE9}|%{F-}";
      };
      "bar/top" = {
        "inherit" = "bar/base";
        modules-left = "ewmh title";
        modules-right = "pulseaudio date";
      };
      "bar/bottom" = {
        "inherit" = "bar/base";
        bottom = true;
        foreground = nord9;
        modules-left = "os-text kernel filesystem memory network temperature cpu spotify";
        tray-position = "right";
        tray-maxsize = 30;
      };
      "module/ewmh" = {
        type = "internal/xworkspaces";
        enable-click = true;
        enable-scroll = true;
        reverse-scroll = true;

        format = "<label-state>";
        label-active = "%name%@";
        label-occupied = "%name%*";
        label-empty = "%name% ";
        label-active-padding = 2;
        label-occupied-padding = 2;
        label-empty-padding = 2;
        label-active-background = nord1;
        label-active-underline = nord7;
        label-active-foreground = nord7;
      };
      "module/title" = {
        type = "internal/xwindow";
        format-foreground = nord4;
      };
      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        sink = "alsa_output.pci-0000_00_1f.3.hdmi-stereo"; # find using `pacmd list-sinks`, name field
        use-ui-max = false; # PA_VOLUME_NORM (100%)
        interval = 5;
        format-volume = "<ramp-volume> <label-volume>";
        label-volume = "%{F#8FBCBB}%percentage%%%{F-}";
        label-muted = "婢 %{F#8FBCBB}Muted%{F-}";
        ramp-volume-0 = "";
        ramp-volume-1 = "墳";
        ramp-volume-2 = "";

        click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
      };
      "module/date" = {
        type = "internal/date";
        internal = 1;
        date = "%b %d";
        time = "%H:%M";
        label = "%date% %{F#8FBCBB}%time%%{F-}";
      };
      "module/os-text" = {
        type = "custom/text";
        content = " NixOS";
      };
      "module/kernel" = {
        type = "custom/script";
        exec = ''
          ${pkgs.coreutils}/bin/printf " %%{F#8FBCBB}%s%%{F-}" $(${pkgs.coreutils}/bin/uname -r)
        '';
        tail = false;
        interval = 3600;
      };
      "module/filesystem" = {
        type = "internal/fs";
        mount-0 = "/";
        interval = 10;
        fixed-values = true;
        format-mounted = "<label-mounted>";
        label-mounted = " %{F#8FBCBB}%used:9%%{F-} (%{F#8FBCBB}%percentage_used:2%%%{F-}) %{F#D8DEE9}/%{F-} %total%";
      };
      "module/memory" = {
        type = "internal/memory";
        label = " %{F#8FBCBB}%gb_used:9%%{F-} (%{F#8FBCBB}%percentage_used:2%%%{F-}) %{F#D8DEE9}/%{F-} %gb_total%";
        format = "<label>";
      };
      "module/network" = {
        type = "internal/network";
        interface-type = "wired";
        interface = "enp86s0";
        format-connected = "<label-connected>";
        format-disconnected = "<label-disconnected>";
        format-packetloss = "<animation-packetloss> <label-connected>";
        label-connected = "祝 %{F#8FBCBB}%upspeed:9%%{F-} %{F#D8DEE9}/%{F-}  %{F#8FBCBB}%downspeed:9%%{F-}";
        label-disconnected = "";
      };
      "module/temperature" = {
        type = "internal/temperature";
        thermal-zone = 0;
        hwmon-path = "/sys/devices/platform/coretemp.0/hwmon/hwmon3/temp1_input";
        format = "<label>";
        format-warn = "<label-warn>";
        label = " %{F#8FBCBB}%temperature-c%%{F-}";
        label-warn = " %{F#BF616A}%temperature-c%%{F-}";
      };
      "module/cpu" = {
        type = "internal/cpu";
        format = "CPU <label> <ramp-coreload>";
        label = "%{F#8FBCBB}%percentage:2%%%{F-}";
        ramp-coreload-spacing = 1;
        ramp-coreload-0 = "▁";
        ramp-coreload-1 = "▂";
        ramp-coreload-2 = "▃";
        ramp-coreload-3 = "▄";
        ramp-coreload-4 = "▅";
        ramp-coreload-5 = "▆";
        ramp-coreload-6 = "▇";
        ramp-coreload-7 = "█";
      };
    };
  };
}