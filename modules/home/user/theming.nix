{ pkgs, vscode-extensions, ... }: let
  # accentColor = "250,140,200";
  # accentColor = "255,184,228";
  accentColor = "245,194,231";
  wallpaper = "/home/user/nixos/wallpapers/abstract-swirls.png";
  catppuccin-flavour = "mocha";
  catppuccin-accent = "pink";
  # TODO automate these:
  catppuccin-flavour-uppercased = "Mocha";
  catppuccin-accent-uppercased = "Pink";
in {
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