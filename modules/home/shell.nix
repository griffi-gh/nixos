{ ... }: {
  programs = {
    fish = {
      enable = true;
      shellAliases = {
        ls = "eza -a --icons=auto --hyperlink --across";
        cat = "bat";
        cls = "clear";
        "cd.." = "cd ..";
      };
    };
    nushell.enable = true;
    carapace.enable = true;
    starship = {
      enable = true;
      enableTransience = true;
    };
    bat.enable = true;
  };
}
