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

      { directory = ".gnupg"; mode = "0700"; }
      { directory = ".ssh"; mode = "0700"; }

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
