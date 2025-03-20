{ ... }: {
  imports = [
    ./plasma/panels.nix
    ./plasma/widgets.nix
    ./plasma/kwin.nix
    ./plasma/kwin-system76-scheduler.nix
    ./plasma/window-rules.nix
    ./plasma/input.nix
    ./plasma/shortcuts.nix
    ./plasma/dolphin.nix
    ./plasma/konsole.nix
    ./plasma/spectacle.nix
  ];
  programs.plasma = {
    enable = true;
    immutableByDefault = true;
    desktop = {
      mouseActions.leftClick = null;
      mouseActions.rightClick = "contextMenu";
      mouseActions.middleClick = null;
      mouseActions.verticalScroll = null;
    };
    configFile = {
      kdeglobals = {
        General = {
          # enable font antialiasing
          XftAntialias = true;
          XftHintStyle = "hintslight";
          XftSubPixel = "rgb";
        };
        QtQuickRendererSettings = {
          SceneGraphBackend = "opengl";
          ForceGlCoreProfile = true;
          RenderLoop = "threaded";
        };
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

  # home.activation."kwin_reconfigure" = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   qdbus org.kde.KWin /KWin reconfigure
  # '';

  # home.file."/home/user/.config/systemd/user/plasma-ksplash-ready.service.d/override.conf" = {
  #   # fix bug where splash screen doesn't disappear
  #   text = ''
  #     [Service]
  #     ExecStart=/etc/profiles/per-user/user/bin/dbus-send --session --reply-timeout=1 --type=method_call --dest=org.kde.KSplash /KSplash org.kde.KSplash.setStage string:ready
  #   '';
  # };
}
