{ ... }: {
  programs.plasma.input.keyboard = {
    switchingPolicy = "global";
    layouts = [
      { layout = "us"; }
      { layout = "ua"; }
      { layout = "pl"; }
    ];
    options = [
      "grp:win_space_toggle"
    ];
  };
}
