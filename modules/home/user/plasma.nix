{ ... }: let
  # TODO use relative path?
  wallpaper = "/home/user/nixos/wallpapers/whatever.png";
in {
  imports = [
    ./plasma/kwin.nix
    ./plasma/window-rules.nix
    ./plasma/input.nix
    ./plasma/dolphin.nix
    ./plasma/konsole.nix
  ];
  programs.plasma = {
    enable = true;
    immutableByDefault = true;
    workspace = {
      inherit wallpaper;
      lookAndFeel = "org.kde.breezedark.desktop";
    };
    kscreenlocker.appearance = {
      inherit wallpaper;
    };
    configFile = {
      # "Navigation Wraps Around"
      kwinrc.Windows.RollOverDesktops = true;

      kdeglobals.General = {
        # accent color
        AccentColor = "250,140,200";
        LastUsedCustomAccentColor = "250,140,200";

        # enable font antialiasing
        XftAntialias = true;
        XftHintStyle = "hintslight";
        XftSubPixel = "rgb";
      };

      # Highlight non-default settings
      systemsettingsrc.systemsettings_sidebar_mode = {
        HighlightNonDefaultSettings = true;
      };

      # Locale
      plasma-localerc.Formats = let
        lang = "en_US.UTF8";
        locale = "en_IE.UTF-8";
      in {
        LANG = lang;
        LC_CTYPE = locale;
        LC_NUMERIC = locale;
        LC_TIME = locale;
        LC_COLLATE = locale;
        LC_MONETARY = locale;
        LC_MESSAGES = locale;
        LC_PAPER = locale;
        LC_NAME = locale;
        LC_ADDRESS = locale;
        LC_TELEPHONE = locale;
        LC_MEASUREMENT = locale;
        LC_IDENTIFICATION = locale;
      };
    };
  };
}
