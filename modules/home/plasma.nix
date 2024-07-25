{ ... }: {
  programs.plasma = {
    enable = true;
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      wallpaper = "/home/user/nixos/wallpapers/whatever.png"; #TODO use relative path?
    };
    configFile =
      let
        immutable = value: { inherit value; immutable = true; };
      in {
        # plugins
        kwinrc.Plugins = {
          cubeEnabled = immutable true; # cube :3
        };

        # virtual desktops conf.
        kwinrc.Desktops = {
          Number = immutable 4;
          Rows = immutable 2;
        };

        # enable font antialiasing
        # TODO this should be different per-machine :p
        kdeglobals.General = {
          XftAntialias = immutable true;
          XftHintStyle = immutable "hintslight";
          XftSubPixel = immutable "rgb";
        };

        systemsettingsrc.systemsettings_sidebar_mode = {
          HighlightNonDefaultSettings = immutable true;
        };

        plasma-localerc.Formats =
          let
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
