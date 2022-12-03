{ config, lib, pkgs, ... }:

with lib;

let
  server = "notes.cuichen.cc";
  exe = "${pkgs.nodePackages.tiddlywiki}/lib/node_modules/.bin/tiddlywiki";
  serv = wiki:
    let
      dataDir = "/var/lib/wiki/" + wiki.name;
      listenParams = concatStrings (
        mapAttrsToList (n: v: " '${n}=${toString v}' ") wiki.options);
    in
    {
      description = "TiddlyWiki nodejs server (${wiki.name})";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        Restart = "on-failure";
        DynamicUser = true;
        StateDirectory = "wiki/" + wiki.name;
        ExecStartPre = "-${exe} ${dataDir} --init server";
        ExecStart = "${exe} ${dataDir} --listen ${listenParams}";
      };
    };
  loc = wikis:
    let
      ifStat = wiki: ''
        if ($http_referer = https://${server}/${wiki.name}/) {
          rewrite ^(.*)$ /${wiki.name}$1;
        }
      '';
      locStat = wiki: {
        "/${wiki.name}/" = {
          proxyPass = "http://127.0.0.1:${toString wiki.port}/";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_ssl_server_name on;
            proxy_pass_header Authorization;
          '';
        };
      };
    in
    foldl' (x: y: x // y) {
      "~ ^/(status|recipes|bags)".extraConfig = concatStrings (map ifStat wikis);
    } (map locStat wikis);

  researchWiki = rec {
    name = "research";
    port = 8100;
    options = {
      inherit port;
      credentials = "credentials.csv";
      use-browser-cache = "yes";
    };
  };

  nixWiki = rec {
    name = "nix";
    port = 8101;
    options = {
      inherit port;
      credentials = "credentials.csv";
      use-browser-cache = "yes";
    };
  };

  juWiki = rec {
    name = "ju";
    port = 8102;
    options = {
      inherit port;
      credentials = "credentials.csv";
      use-browser-cache = "yes";
    };
  };
in
{
  services.nginx.virtualHosts = {
    ${server} = {
      forceSSL = true;
      enableACME = true;
      locations = loc [ researchWiki nixWiki juWiki ];
    };
  };

  systemd.services.tiddlywiki-research = serv researchWiki;
  systemd.services.tiddlywiki-nix = serv nixWiki;
  systemd.services.tiddlywiki-ju = serv juWiki;
}
