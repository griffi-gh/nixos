{ ... }: {
  programs.plasma.input.keyboard = {
    switchingPolicy = "global";
    layouts = [
      { layout = "us"; }
      { layout = "pl"; }
      { layout = "ua"; }
      { layout = "ru"; }
    ];
    options = [
      "grp:win_space_toggle"
    ];
  };
}
