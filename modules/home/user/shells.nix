{ ... }: {
  home.shellAliases = {
    cls = "clear";
    p = "pwd";
    ls = "eza -a";
    cat = "bat -pp";
    helix = "hx";
    y = "yazi";
    # cd = "z"; # causes loop on fish
    # grep = "rg"; # not 100% compatible

    # git
    g = "git";
    gp = "git push";
    gpf = "git push --force-with-lease";
    gpff = "git push --force";
    gpl = "git pull";
    gc = "git commit";
    gcm = "git commit -m";
    gcam = "git commit -am";
    gam = "git commit --amend";
    ga = "git add";
    gaa = "git add -A";
    gb = "git branch";
    gco = "git checkout";
    gcb = "git checkout -b";
    gaampf = "git add -A; git commit --amend --no-edit; git push --force-with-lease";

    nix-query = "nix-locate --top-level";

    flake = "nix flake";
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
          NIX_REMOTE=daemon sudo nixos-rebuild switch --flake ~/nixos#$hostname --fast
        '';
        rebuild-boot = ''
          NIX_REMOTE=daemon sudo nixos-rebuild boot --flake ~/nixos#$hostname
        '';
        flake-update = ''
          nix flake update --flake ~/nixos
        '';
        nuke-sycoca = ''
          rm ~/.cache/ksycoca6_* -rf;
          kbuildsycoca6 --noincremental;
        '';
        plasmashell-restart = ''
          kquitapp6 plasmashell;
          kstart plasmashell;
        '';
        kwin-reconfigure = ''
          qdbus org.kde.KWin /KWin reconfigure;
        '';
        drop-caches = ''
          sudo sync;
          echo 3 | sudo tee /proc/sys/vm/drop_caches;
        '';
        drop-swap = ''
          sudo swapoff -a;
          sudo swapon -a;
        '';
        servedir = ''
          http-server -c-1 -p 18886 -a :: --cors -gb --log-ip
        '';
        uncow = ''
          set file $argv[1]
          set tmp_file $file.(random)
          mv $file $tmp_file
          touch $file
          chattr +C $file
          cat $tmp_file > $file
          rm $tmp_file
        '';
        efz = ''
          $EDITOR $(fzf)
        '';
      };
    };
    bash = {
      enable = true;
      enableVteIntegration = true;
    };
    nushell = {
      enable = true;
      extraConfig = ''
        $env.TRANSIENT_PROMPT_COMMAND = ^starship module character;
        $env.TRANSIENT_PROMPT_COMMAND_RIGHT = "";
      '';
    };

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

    # cli sw.
    htop.enable = true;

    yazi = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableBashIntegration = true;
      # enableZshIntegration = true;
    };

    # tools:
    thefuck.enable = true;
    fzf.enable = true;
    zoxide.enable = true;
    bat.enable = true;
    eza = {
      enable = true;
      icons = "auto";
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
