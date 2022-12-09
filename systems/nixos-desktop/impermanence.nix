{ inputs, username, ... }:

let
  persistRoot = "/nix/persist";
in
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  environment.persistence.${persistRoot} = {
    files = [ ];
  };

  users.users = {
    root = {
      initialHashedPassword = "$6$fXoDj0WG0YbEXBD6$LfHaDe1fUxCa4D1gwPaKa1Is6w3fL5/ezIycZbiOeCTSHdHqrVWRIYfvZzBAVmOIEOXhHQcYZnYWFcecNZp6I.";
      passwordFile = "${persistRoot}/passwords/root";
    };
    ${username} = {
      initialHashedPassword = "$6$2INXvqW4zxUlYKhX$Aacwd99LSSBy5TlFRiLEjtwIuOvN5C44jO9P4IqVM.soCrR2LUsZg7k09VJVCF86W6UF90ZGvV/9qau4pDUV9.";
      passwordFile = "${persistRoot}/passwords/${username}";
    };
  };
}
