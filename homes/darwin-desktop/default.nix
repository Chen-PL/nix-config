{ username, ... }:

{
  imports = [ ./programs ];
  home = {
    homeDirectory = "/Users/${username}";
    sessionPath = [ "/opt/homebrew/bin" ];
  };
}
