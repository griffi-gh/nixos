{ ... }: let
  wallpaper = "/home/user/nixos/wallpapers/whatever.png"; #TODO use relative path?
in {
  programs.plasma = {
    enable = true;
    workspace = {
      inherit wallpaper;
      lookAndFeel = "org.kde.breezedark.desktop";
    };
    configFile = let
      immutable = value: { inherit value; immutable = true; };
    in {
      # =========== kde/qt applications ===========

      # Dolphin
      dolphinrc.General = {
        GlobalViewProps = immutable false;
        ConfirmClosingMultipleTabs = immutable false;
        RememberOpenedTabs = immutable false;
        ShowFullPath = immutable true;
      };

      # Konsole
      konsolerc.TabBar = {
        TabBarPosition = immutable "Left";
        TabBarVisibility = immutable "AlwaysShowTabBar";
      };

      # =========== kde settings ===========

      # accent color
      kdeglobals.General = {
        AccentColor = immutable "250,140,200";
        LastUsedCustomAccentColor = "250,140,200";
      };

      # set lock screen wallpaper
      kscreenlockerrc."Greeter/Wallpaper/org.kde.image/General" = {
        Image = immutable wallpaper;
        PreviewImage = immutable wallpaper;
      };

      # keyboard layouts/kxkb
      kxkbrc.Layout = {
        Use = immutable true;
        ResetOldOptions = immutable true;
        DisplayNames = immutable ",";
        LayoutList = immutable "us,ua";
        Options = immutable "grp:win_space_toggle";
        VariantList = immutable ",";
      };

      # plugins
      kwinrc.Plugins = {
        # Dim on root prompt
        dimscreenEnabled = immutable true;
      };

      # virtual desktops conf.
      kwinrc.Desktops = {
        Number = immutable 4;
        Rows = immutable 2;
      };

      # enable font antialiasing
      kdeglobals.General = {
        XftAntialias = immutable true;
        XftHintStyle = immutable "hintslight";
        XftSubPixel = immutable "rgb";
      };

      # Highlight non-default settings
      systemsettingsrc.systemsettings_sidebar_mode = {
        HighlightNonDefaultSettings = immutable true;
      };

      # Locale
      plasma-localerc.Formats = let
        lang = "en_US.UTF8";
        locale = "en_IE.UTF-8";
      in {
        LANG = immutable lang;
        LC_CTYPE = immutable locale;
        LC_NUMERIC = immutable locale;
        LC_TIME = immutable locale;
        LC_COLLATE = immutable locale;
        LC_MONETARY = immutable locale;
        LC_MESSAGES = immutable locale;
        LC_PAPER = immutable locale;
        LC_NAME = immutable locale;
        LC_ADDRESS = immutable locale;
        LC_TELEPHONE = immutable locale;
        LC_MEASUREMENT = immutable locale;
        LC_IDENTIFICATION = immutable locale;
      };
    };
  };
}
