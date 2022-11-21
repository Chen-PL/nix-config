{ config, lib, pkgs, ... }:

with lib;

let
  listenParams = options: concatStrings (mapAttrsToList (n: v: " '${n}=${toString v}' ") options);
  exe = "${pkgs.nodePackages.tiddlywiki}/lib/node_modules/.bin/tiddlywiki";
  dataDir = name: "/var/lib/wiki/" + name;
  servWiki = name: options: {
    description = "TiddlyWiki nodejs server";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      Restart = "on-failure";
      DynamicUser = true;
      StateDirectory = "wiki/" + name;
      ExecStartPre = "-${exe} ${dataDir name} --init server";
      ExecStart = "${exe} ${dataDir name} --listen ${listenParams options}";
    };
  };
  researchWikiPort = 8100;
in
{
  services.nginx.virtualHosts = {
    "note.cuichen.cc" = {
      forceSSL = true;
      enableACME = true;

      locations = {
        "/research/" = {
          proxyPass = "http://127.0.0.1:${toString researchWikiPort}/research/";
          proxyWebsockets = true; # needed if you need to use WebSocket
          extraConfig =
            # required when the target is also TLS server with multiple hosts
            "proxy_ssl_server_name on;" +
            # required when the server wants to use HTTP Authentication
            "proxy_pass_header Authorization;"
          ;
        };
      };
    };
  };

  systemd.services.tiddlywiki-research = servWiki "research" {
    # credentials = "../credentials-research.csv";
    port = researchWikiPort;
    path-prefix = "/research";
    # readers = "(authenticated)";
  };
}
