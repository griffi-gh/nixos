{ ... }: {
  programs = {
    fish = {
      enable = true;
      shellAliases = {
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
