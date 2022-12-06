{
  additions = final: _prev: import ../../pkgs/linux { pkgs = final; };

  modifications = final: prev: {
    cgit-default-theme = prev.cgit.overrideAttrs (oldAttrs: {
      # change the code theme of cgit to `default`
      postPatch = oldAttrs.postPatch + ''
        substituteInPlace filters/syntax-highlighting.py \
          --replace 'pastie' 'default'
      '';
    });

    waybar-hyprland = prev.waybar.overrideAttrs (oldAttrs: {
      # add wlr/workspaces support
      mesonFlags = (oldAttrs.mesonFlags or  [ ]) ++ [ "-Dexperimental=true" ];
      # make workspaces work with hyprctl
      postPatch = (oldAttrs.postPatch or "") + ''
        sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
      '';
    });
  };
}
