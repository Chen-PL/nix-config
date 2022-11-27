{
  additions = final: _prev: import ../../pkgs/unix { pkgs = final; };

  modifications = final: prev: {
    abella-modded = prev.abella.overrideAttrs (oldAttrs: {
      src = prev.fetchFromGitHub {
        owner = "JimmyZJX";
        repo = "abella";
        rev = "c64dad15e2351433ab11fb716347fe54a8fec11e";
        hash = "sha256-z7oO7pqjZEcZY2+W1T/T6GpY3eqRuTq5lVf7eLit5VU=";
      };
    });
  };
}
