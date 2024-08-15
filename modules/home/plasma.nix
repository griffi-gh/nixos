{ ... }: {
    programs.plasma = {
        enable = true;
        workspace = {
            lookAndFeel = "org.kde.breezedark.desktop";
            wallpaper = "/home/user/nixos/wallpapers/whatever.png"; #TODO use relative path?
        };
        configFile = let
            immutable = value: { inherit value; immutable = true; };
        in {
            # accent color
            kdeglobals.General.AccentColor = immutable accent_color;
            kdeglobals.General.LastUsedCustomAccentColor = accent_color;

            # keyboard layouts
            kxkbrc.Layout.DisplayNames = immutable ",";
            kxkbrc.Layout.LayoutList = immutable "us,ua";
            kxkbrc.Layout.Options = immutable "grp:win_space_toggle";
            kxkbrc.Layout.ResetOldOptions = immutable true;
            kxkbrc.Layout.Use = immutable true;
            kxkbrc.Layout.VariantList = immutable ",";

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
