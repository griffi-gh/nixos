{ ... }: {
  programs.plasma.input.keyboard = {
    switchingPolicy = "global";
    layouts = [
      { layout = "us"; }
      { layout = "ua"; }
    ];
    options = [
      "grp:win_space_toggle"
    ];
  };
}
