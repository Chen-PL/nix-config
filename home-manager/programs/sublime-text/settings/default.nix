{ config, lib, ... }:

let
  sublimeSettingHome = "${config.xdg.configHome}/sublime-text/Packages/User";
  moduleToList = module:
    lib.attrsets.mapAttrsToList
      (filename: settings: { "${sublimeSettingHome}/${filename}".text = builtins.toJSON settings; })
      (import module);
  modulesToHomeFile = modules:
    lib.attrsets.zipAttrsWith (_: list: builtins.head list) (builtins.concatMap moduleToList modules);

  settingModules = [
    ./abella
    ./ayu
    ./nord
    ./package-control
    ./preferences
  ];
in
{
  home.file = modulesToHomeFile settingModules;
}
