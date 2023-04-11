{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        # identityFile = "~/.ssh/id_rsa_yubikey.pub";
      };

      home-server = {
        hostname = "home.cuichen.cc";
        identityFile = toString ./id_rsa_yubikey.pub;
      };

      linode-server = {
        hostname = "server.cuichen.cc";
        identityFile = toString ./id_rsa_yubikey.pub;
      };
    };
  };
}
