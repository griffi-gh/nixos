{
  osu-lazer-bin,
  symlinkJoin,
  makeWrapper,
}:
symlinkJoin {
  name = "osu-lazer-bin-wrapped";
  paths = [ osu-lazer-bin ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/osu! \
      --set SDL_VIDEODRIVER wayland \
      --add-flags '--sdl';
  '';
}
