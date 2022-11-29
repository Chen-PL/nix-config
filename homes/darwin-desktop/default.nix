{ username, ... }:

{
  imports = [ ./programs ];
  home.homeDirectory = "/Users/${username}";
}
