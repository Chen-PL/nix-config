{ username, ... }:

{
  imports = [ ./brew ];

  users.users.${username} = {
    home = "/Users/${username}";
  };

  services.nix-daemon.enable = true;
}
