{ config, lib, pkgs, ... }:

with lib;

let
  inherit (builtins) attrNames toJSON;
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
  inherit (lib.attrsets) mapAttrs' nameValuePair;
  cfg = config.programs.sublime;

  packageControlFile = pkgs.fetchurl {
    url = "https://packagecontrol.io/Package%20Control.sublime-package";
    sha256 = "sha256-gXk3FEw0yEyIzUO4UxiyZW+cP6wC+PcsvBg2Cywm0Tk=";
  };

  sublimeConfigPath =
    if isDarwin then
      "Library/Application Support/Sublime Text"
    else
      "${config.xdg.configHome}/sublime-text";

  installedPackagesPath = "${sublimeConfigPath}/Installed Packages";
  packagesPath = "${sublimeConfigPath}/Packages";
  settingsPath = "${packagesPath}/User";

  apperanceConfigModule = types.submodule {
    options = {
      variables = mkOption {
        type = types.attrs;
        default = { };
      };
      globals = mkOption {
        type = types.attrs;
        default = { };
      };
      rules = mkOption {
        type = types.listOf types.attrs;
        default = [ ];
      };
    };
  };

  apperanceModule = name: types.submodule {
    options = {
      enable = mkEnableOption name // { default = false; };

      config = mkOption {
        type = apperanceConfigModule;
        default = { };
      };
    };
  };

  mkPackages = mapAttrs' (name: source: nameValuePair
    "${packagesPath}/${name}"
    { inherit source; });

  mkSettings = mapAttrs' (name: settings: nameValuePair
    "${settingsPath}/${name}.sublime-settings"
    { text = toJSON settings; });

  mkSettingsIfEnable = ext: mapAttrs' (name: settings:
    nameValuePair "${settingsPath}/${name}.${ext}"
      (mkIf (settings.enable && settings.config != { })
        { text = toJSON settings.config; }));

  filterEnabled = filterAttrs (name: options: options.enable);
in
{
  options = {
    programs.sublime = {
      enable = mkEnableOption "Sublime Text";
      package = mkPackageOption pkgs "Sublime Text" { default = "sublime4"; };

      enablePackageControl = mkEnableOption "Package Control";
      packages = mkOption {
        type = types.attrs;
        default = { };
      };

      settings = mkOption {
        type = types.attrs;
        default = { };
      };

      packageSettings = mkOption {
        type = types.attrs;
        default = { };
      };

      theme = mkOption {
        type = types.attrsOf (apperanceModule "theme");
        default = { };
      };

      color = mkOption {
        type = types.attrsOf (apperanceModule "color scheme");
        default = { };
      };
    };
  };

  config = mkIf cfg.enable (
    let
      themeEnabledList = attrNames (filterEnabled cfg.theme);
      colorEnabledList = attrNames (filterEnabled cfg.color);
      themeEnabled = if themeEnabledList != [ ] then head themeEnabledList else "default";
      colorEnabled = if colorEnabledList != [ ] then head colorEnabledList else "default";
    in
    {
      assertions = [
        (
          let numTheme = length themeEnabledList; in {
            assertion = numTheme <= 1;
            message = "Cannot have more than one theme enabled but found "
              + toString numTheme + optionalString (numTheme > 1)
              (", namely " + concatStringsSep ", " themeEnabledList);
          }
        )
        (
          let numColor = length colorEnabledList; in {
            assertion = numColor <= 1;
            message = "Cannot have more than one color scheme enabled but found "
              + toString numColor + optionalString (numColor > 1)
              (", namely " + concatStringsSep ", " colorEnabledList);
          }
        )
      ];

      home.packages = [ cfg.package ];

      home.file = mkMerge [
        {
          "${installedPackagesPath}/Package Control.sublime-package" = mkIf cfg.enablePackageControl {
            source = packageControlFile;
          };
        }

        # Preferences.sublime-settings
        (mkIf (cfg.settings != { })
          (mkSettings {
            "Preferences" = {
              theme = "${themeEnabled}.sublime-theme";
              color_scheme = "${colorEnabled}.sublime-color-scheme";
            } // cfg.settings;
          }))

        (mkPackages cfg.packages)
        (mkSettings cfg.packageSettings)
        (mkSettingsIfEnable "sublime-theme" cfg.theme)
        (mkSettingsIfEnable "sublime-color-scheme" cfg.color)
      ];
    }
  );
}
