{
  security.acme = {
    acceptTerms = true;
    defaults.email = "i@cuichen.cc";
  };

  services.nginx = {
    enable = true;
    virtualHosts = {
      "server.cuichen.cc" = {
        forceSSL = true;
        enableACME = true;
        root = "/var/www/server.cuichen.cc";
      };
    };
  };
}
