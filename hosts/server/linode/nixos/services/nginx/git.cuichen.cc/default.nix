{ lib, pkgs, ... }:

let
  cgitConfig = lib.attrsets.mapAttrsToList
    (name: value: "${name}=${value}")
    (import ./cgitrc.nix);
  cgitConfigFile = pkgs.writeText "cgitrc"
    (lib.concatStringsSep "\n" cgitConfig);
in
{
  environment.systemPackages = [ pkgs.cgit ];

  services.nginx.virtualHosts = {
    "git.cuichen.cc" = {
      forceSSL = true;
      enableACME = true;
      root = "${pkgs.cgit}/cgit/";

      extraConfig = ''
        try_files  $uri @cgit;
      '';

      locations = {
        "~ /.+/(info/refs|git-upload-pack)" = {
          fastcgiParams = {
            SCRIPT_FILENAME = "${pkgs.git}/bin/git-http-backend";
            PATH_INFO = "$uri";
            GIT_HTTP_EXPORT_ALL = "1";
            GIT_PROJECT_ROOT = "/var/git";
            HOME = "/var/git";
          };
          extraConfig = ''
            include       ${pkgs.nginx}/conf/fastcgi_params;
            fastcgi_pass  unix:/run/fcgiwrap.sock;
          '';
        };
        "@cgit" = {
          fastcgiParams = {
            CGIT_CONFIG = cgitConfigFile;
            SCRIPT_FILENAME = "${pkgs.cgit}/cgit/cgit.cgi";
            PATH_INFO = "$uri";
            QUERY_STRING = "$args";
            HTTP_HOST = "$server_name";
          };
          extraConfig = ''
            include       ${pkgs.nginx}/conf/fastcgi_params;
            fastcgi_pass  unix:/run/fcgiwrap.sock;
          '';
        };
      };
    };
  };
}
