final: prev:

{
  installApplication =
    { name
    , appname ? name
    , version
    , src
    , description
    , homepage
    , postInstall ? ""
    , sourceRoot ? "."
    , ...
    }:
      with prev; stdenv.mkDerivation {
        name = "${name}-${version}";
        version = "${version}";
        inherit src sourceRoot;
        buildInputs = [ undmg unzip ];
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p "$out/Applications/${appname}.app"
          cp -pR * "$out/Applications/${appname}.app"
        '' + postInstall;
        meta = with prev.lib; {
          inherit description homepage;
          platforms = platforms.darwin;
        };
      };
}
