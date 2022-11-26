{ lib, stdenv, fetchFromGitHub, rsync, ocamlPackages }:

stdenv.mkDerivation rec {
  pname = "abella-modded";
  version = "2021.07.04";

  src = fetchFromGitHub {
    owner = "JimmyZJX";
    repo  = "abella";
    rev   = "c64dad15e2351433ab11fb716347fe54a8fec11e";
    hash  = "sha256-z7oO7pqjZEcZY2+W1T/T6GpY3eqRuTq5lVf7eLit5VU=";
  };

  buildInputs = [ rsync ] ++ (with ocamlPackages; [ ocaml ocamlbuild findlib ]);

  installPhase = ''
    mkdir -p $out/bin
    rsync -av abella    $out/bin/

    mkdir -p $out/share/emacs/site-lisp/abella/
    rsync -av emacs/    $out/share/emacs/site-lisp/abella/

    mkdir -p $out/share/abella/examples
    rsync -av examples/ $out/share/abella/examples/
  '';
}
