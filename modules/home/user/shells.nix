{ ... }: {
  home.shellAliases = {
    ls = "eza -a";
    cat = "bat";
    cls = "clear";
    helix = "hx";
    balooctl = "balooctl6";
  };
  programs = {
    # Shells:
    fish = {
      enable = true;
      shellAliases = {};
      functions = {
        rebuild-switch = ''
          NIX_REMOTE=daemon sudo nixos-rebuild switch --flake ~/nixos#$hostname;
        '';
        flake-update = ''
          nix flake update --flake ~/nixos;
        '';
      };
    };
    bash = {
      enable = true;
      enableVteIntegration = true;
    };
    nushell.enable = true;

    # direnv:
    direnv = {
      enable = true;
      config.global = {
        load_dotenv = true;
        strict_env = true;
        hide_env_diff = true;
      };
      nix-direnv.enable = true;
    };

    # prompt:
    carapace.enable = true;
    starship = {
      enable = true;
      enableTransience = true;
    };

    # tools:
    htop.enable = true;
    thefuck.enable = true;
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
