{ username, stateVersion, ... }:

{
  imports = [ ./programs ];

  home = {
    inherit username stateVersion;
    sessionPath = [ "$HOME/bin" ];
  };
}
