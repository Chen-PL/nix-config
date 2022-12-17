{
  programs.git = {
    enable = true;
    userName = "Chen";
    userEmail = "i@cuichen.cc";
    extraConfig = {
      # Sign all commits using ssh key
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = toString ./id_rsa_yubikey.pub;
    };
  };
}
