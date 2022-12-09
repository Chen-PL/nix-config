{ inputs, username, ... }:

{
  imports = [ inputs.impermanence.nixosModules.home-manager.impermanence ];

  home.persistence."/nix/persist/home/${username}" = {
    directories = [
      # Well known user directories
      "Desktop"
      "Documents"
      "Downloads"
      "Music"
      "Pictures"
      "Public"
      "Templates"
      "Videos"

      ".gnupg"
      ".ssh"

      # Nix configurations
      "nix-config"
      # For my research
      "Research"
    ];
    # allows other users, such as root, to access files through 
    # the bind mounted directories listed in directories.
    allowOther = true;
  };
}
