{ config, lib, ... }:

with builtins;

let
  sublimeSettingHome = "${config.xdg.configHome}/sublime-text/Packages/User";
  moduleToList = module: lib.attrsets.mapAttrsToList
      (filename: settings: { "${sublimeSettingHome}/${filename}".text = toJSON settings; })
      (import module);

  settingModules = [
    ./abella
    ./ayu
    # ./nord
    ./package-control
    ./preferences
  ];
in
{
  home.file = foldl' (x: y: x // y) { } (concatMap moduleToList settingModules);
}
