{
  programs.ssh = {
    matchBlocks = {
      github = {
        hostname = "*.github.com";
        identityFile = "~/.ssh/id_ed25519";
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
