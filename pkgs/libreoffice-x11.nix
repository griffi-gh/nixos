# libreoffice-qt6-fresh using Xwayland
{
  libreoffice-qt6-fresh,
  symlinkJoin,
  makeWrapper,
}:
symlinkJoin {
  name = "libreoffice-x11";
  paths = [ libreoffice-qt6-fresh ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/libreoffice --set WAYLAND_DISPLAY ""
    wrapProgram $out/bin/soffice --set WAYLAND_DISPLAY ""
  '';
}
