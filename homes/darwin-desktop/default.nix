{ pkgs, username, ... }:

{
  imports = [ ./programs ];
  home.packages = with pkgs; [ sublime4 ];
  home.homeDirectory = "/Users/${username}";
}
