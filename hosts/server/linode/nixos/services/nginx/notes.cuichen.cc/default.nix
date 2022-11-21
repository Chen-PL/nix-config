{
  services.nginx.virtualHosts = {
    "note.cuichen.cc" = {
      forceSSL = true;
      enableACME = true;
      root = ./html;
    };
  };
}
