{
  vintagestory,
  symlinkJoin,
  makeWrapper,
  gamemode,
}:
symlinkJoin {
  name = "vintagestory-wrapped";
  paths = [ vintagestory ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''\
    vs_bin="$out/bin/vintagestory";
    vs_bin_wrapped="$out/bin/.vintagestory-wrapped";
    mv $vs_bin $vs_bin_wrapped;
    makeWrapper ${gamemode}/bin/gamemoderun $vs_bin \
      --add-flag $vs_bin_wrapped \
      --argv0 $vs_bin_wrapped \
      --set mesa_glthread true;
  '';
}