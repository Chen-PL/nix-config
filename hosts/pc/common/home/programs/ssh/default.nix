{
  programs.ssh = {
    matchBlocks = {
      github = {
        hostname = "*.github.com";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
