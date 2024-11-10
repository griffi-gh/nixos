# principia using Xwayland for GTK3
# (works around legacy context menu apis not working)
{
  principia,
  symlinkJoin,
  makeWrapper,
}:
symlinkJoin {
  name = "principia-x11";
  paths = [ principia ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/principia \
      --set GDK_BACKEND x11;
  '';
}
