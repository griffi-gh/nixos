{ ... }: {
  home.shellAliases = {
    ls = "eza -a";
    cat = "bat -pp";
    grep = "rg";
    helix = "hx";
    cls = "clear";
  };
  programs = {
    # Shells:
    fish = {
      enable = true;
      shellAliases = {};
      functions = {
        fish_greeting = ''
          set blue (set_color "#5BCEFA")
          set pink (set_color "#F5A9B8")
          set white (set_color "#FFFFFF")
          set char \u2594
          set banner $blue$char$pink$char$white$char$pink$char$blue$char

          set nixos_icon \uf313
          set nixos_version (nixos-version | cut -d'.' -f1,2)
          set tool_nixos $nixos_icon NixOS $nixos_version

          set fish_icon \uee41
          set fish_version $version
          set tool_fish $fish_icon fish $fish_version

          echo $banner $tool_fish on $tool_nixos

          set_color normal;
        '';
        rebuild-switch = ''
          NIX_REMOTE=daemon sudo nixos-rebuild switch --flake ~/nixos#$hostname;
        '';
        rebuild-boot = ''
          NIX_REMOTE=daemon sudo nixos-rebuild boot --flake ~/nixos#$hostname;
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
