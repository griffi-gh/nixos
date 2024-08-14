{ ... }: {
  programs = {
    # Shells:
    fish = {
      enable = true;
      shellAliases = {
        ls = "eza -a";
        cat = "bat";
        cls = "clear";
        "cd.." = "cd ..";
        helix = "hx";
      };
      functions = {
        rebuild-switch = "rm -f ~/.gtkrc-2.0.bak; nixos-rebuild switch --flake ~/nixos#$hostname --use-remote-sudo";
      };
    };
    nushell.enable = true;

    # prompt:
    carapace.enable = true;
    starship = {
      enable = true;
      enableTransience = true;
    };

    # tools:
    htop.enable = true;
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
