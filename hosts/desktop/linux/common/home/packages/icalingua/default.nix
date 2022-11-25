{ lib, stdenv, fetchurl, appimageTools, makeWrapper, electron, libsecret }:

stdenv.mkDerivation rec {
  pname = "icalingua";
  version = "2.7.7";

  src = fetchurl {
    url = "https://github.com/Icalingua-plus-plus/Icalingua-plus-plus/releases/download/v${version}/Icalingua++-${version}.AppImage";
    sha256 = "sha256-wOyaALXEA194NTduibmlaniC0Orm1QNRw5fLsu6L7Zk=";
  };

  appimageContents = appimageTools.extractType2 {
    name = "${pname}-${version}";
    inherit src;
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin $out/share/${pname} $out/share/applications $out/share/icons/hicolor/512x512
    cp -a ${appimageContents}/{locales,resources} $out/share/${pname}
    cp -a ${appimageContents}/icalingua.desktop $out/share/applications/${pname}.desktop
    cp -a ${appimageContents}/usr/share/icons/hicolor/512x512/apps $out/share/icons/hicolor/512x512
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
    runHook postInstall
  '';

  postFixup = ''
    makeWrapper ${electron}/bin/electron $out/bin/${pname} \
      --add-flags $out/share/${pname}/resources/app.asar
  '';
}