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
      };
  };
}
