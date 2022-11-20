{
  services.nginx.virtualHosts = {
    "server.cuichen.cc" = {
      forceSSL = true;
      enableACME = true;
      root = ./html;
    };
  };
}
