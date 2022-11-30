{ pkgs, ... }:

let
  mkNixosEngine = type: alias: {
    urls = [{
      template = "https://search.nixos.org/${type}";
      params = [
        { name = "channel"; value = "unstable"; }
        { name = "type"; value = "${type}"; }
        { name = "query"; value = "{searchTerms}"; }
      ];
    }];
    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
    definedAliases = [ "@${alias}" ];
  };
in
{
  programs.firefox.profiles.default.search.engines = {
    "Nix Packages" = mkNixosEngine "packages" "pkg";
    "Nix Options" = mkNixosEngine "options" "opt";

    "NixOS Wiki" = {
      urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
      iconUpdateURL = "https://nixos.wiki/favicon.png";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      definedAliases = [ "@nw" ];
    };

  };
}
