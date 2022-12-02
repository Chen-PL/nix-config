{
  programs.ssh = {
    matchBlocks = {
      github = {
        hostname = "*.github.com";
        identityFile = ./id_rsa_yubikey.pub;
      };
    };

    matchBlocks = {
      linode-server = {
        hostname = "server.cuichen.cc";
        identityFile = ./id_rsa_yubikey.pub;
      };
    };
  };
}
