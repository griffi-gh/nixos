{ pkgs, vscode-extensions, ... }: let
  # accentColor = "250,140,200";
  # accentColor = "255,184,228";
  accentColor = "245,194,231";
  wallpaper = "/home/user/nixos/wallpapers/abstract-swirls.jpg";
  catppuccin-flavour = "mocha";
  catppuccin-accent = "pink";
  # TODO automate these:
  catppuccin-flavour-uppercased = "Mocha";
  catppuccin-accent-uppercased = "Pink";
in {
  gtk = let
    adw-catppuccin = pkgs.fetchFromGitHub {
      owner = "claymorwan";
      repo = "adw-catppuccin";
      rev = "e2a3352bb3a1eac7306d397a9945108c878a4c58";
      hash = "sha256-wrqQTyHOaNgPsgxdGGOMY3oBzPPcjtUfqHELcgw8/gE=";
    };
    stylesheet = "${adw-catppuccin}/${catppuccin-flavour}/gtk.css";
    extraCss = ''
      @import 'colors.css'; /* breeze accents */
      @import '${stylesheet}'; /* adw-catppuccin */

      headerbar .titlebutton.close:not(:hover),
      headerbar .titlebutton.minimize:not(:hover),
      headerbar .titlebutton.maximize:not(:hover) {
        background: none;
      }

      window.csd:not(.tiled):not(.maximized):not(.fullscreen) > decoration,
      window.csd:not(.tiled):not(.maximized):not(.fullscreen) headerbar {
        border-radius: 6px 6px 0px 0px;
      }
    '';
  in {
    theme = {
      # name = "Adwaita";
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    gtk3 = {
      inherit extraCss;
    };

    gtk4 = {
      inherit extraCss;
    };
  };

  # programs.firefox.profiles.default.extensions = [
  #   (pkgs.fetchFirefoxAddon {
  #     name = "catppuccin_${catppuccin-flavour}_${catppuccin-accent}";
  #     url = "https://github.com/catppuccin/firefox/releases/download/old/catppuccin_${catppuccin-flavour}_${catppuccin-accent}.xpi";
  #     sha256 = "MPaGVZMjqdqbDA7dbiSl5qQ2ji+aKyftLJiISY5ShQI=";
  #   })
  # ];

  programs.firefox.policies.ExtensionSettings = {
    "{0a2d1098-69a9-4e98-a62c-a861766ac24d}" = let
      addon_xpi = pkgs.fetchurl {
        url = "https://github.com/catppuccin/firefox/releases/download/old/catppuccin_${catppuccin-flavour}_${catppuccin-accent}.xpi";
        hash = "sha256-MPaGVZMjqdqbDA7dbiSl5qQ2ji+aKyftLJiISY5ShQI=";
      };
    in {
      install_url = "file://${addon_xpi}";
      installation_mode = "force_installed";
      updates_disabled = true;
    };
  };

  home.file.".thunderbird/default/extensions/{aee472cc-993b-522a-b6e8-c904c250a8d9}.xpi" = {
    source = pkgs.fetchurl {
      url = "https://github.com/catppuccin/thunderbird/raw/0289f3bd9566f9666682f66a3355155c0d0563fc/themes/${catppuccin-flavour}/${catppuccin-flavour}-${catppuccin-accent}.xpi";
      hash = "sha256-Fa49rVvFSTMV6Aujj2/UD7NePzjbNnP6xGr/Z02mOiA=";
    };
  };

  programs.plasma = {
    workspace = {
      inherit wallpaper;
      # lookAndFeel = "org.kde.breezedark.desktop";
      # lookAndFeel = "Catppuccin-${catppuccin-flavour-uppercased}-${catppuccin-accent-uppercased}";
      colorScheme = "Catppuccin${catppuccin-flavour-uppercased}${catppuccin-accent-uppercased}";
      windowDecorations = {
        library = "org.kde.breeze";
        theme = "Breeze";
      };
      splashScreen.theme = "Catppuccin-${catppuccin-flavour-uppercased}-${catppuccin-accent-uppercased}";
    };
    kscreenlocker.appearance = {
      inherit wallpaper;
    };
    configFile = {
      kdeglobals = {
        General = {
          # accent color
          AccentColor = accentColor;
          LastUsedCustomAccentColor = accentColor;
        };
      };
    };
  };

  home.packages = with pkgs; [
    (catppuccin-kde.override {
      flavour = [ catppuccin-flavour];
      accents = [ catppuccin-accent];
      winDecStyles = [ "modern" ];
    })
    # (rlly like it, especially with colored borders...)
    # (but it causes Qt6 apps to be blurry on HiDPI displays for some reason)
    # kde-rounded-corners
  ];

  programs.vscode = {
    extensions = with vscode-extensions.vscode-marketplace; [
      catppuccin.catppuccin-vsc
      # devgauravjatt.github-catppuccin-dark
    ];
    userSettings = {
      "workbench.colorTheme" = "Catppuccin ${catppuccin-flavour-uppercased}";
      # "Github Catppuccin Dark Mix";
    };
  };
}