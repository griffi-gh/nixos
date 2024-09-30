{ pkgs, ... }:
pkgs.symlinkJoin {
  name = "libreoffice-x11";
  paths = [ pkgs.libreoffice-qt6-fresh ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/libreoffice --set WAYLAND_DISPLAY ""
    wrapProgram $out/bin/soffice --set WAYLAND_DISPLAY ""
  '';
}
