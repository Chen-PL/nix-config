{ username, ... }:

{
  imports = [ ./programs ];

  home = {
    inherit username;
    sessionPath = [ "$HOME/bin" ];
  };
}
