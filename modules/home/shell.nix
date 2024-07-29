{ ... }: {
  programs = {
    fish = {
      enable = true;
      shellAliases = {
        ls = "eza -a";
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
    eza = {
      enable = true;
      icons = true;
      git = true;
      extraOptions = [
        "--hyperlink"
        "--across"
        "--group-directories-first"
      ];
    };
    hyfetch = {
      enable = true;
      settings = {
        preset = "transgender";
        mode = "rgb";
        light_dark = "dark";
        lightness = 0.65;
        color_align = {
          mode = "horizontal";
          custom_colors = [];
          fore_back = null;
        };
        backend = "neofetch";
        args = null;
        distro = null;
        pride_month_shown = [];
        pride_month_disable = false;
      };
    };
  };
}
