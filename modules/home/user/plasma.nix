{ pkgs, lib, ... }: let
  # TODO use relative path?
  wallpaper = "/home/user/nixos/wallpapers/whatever.png";
  accentColor = "250,140,200";
in {
  imports = [
    ./plasma/panels.nix
    ./plasma/widgets.nix
    ./plasma/kwin.nix
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
    workspace = {
      inherit wallpaper;
      lookAndFeel = "org.kde.breezedark.desktop";
    };
    desktop = {
      mouseActions.leftClick = null;
      mouseActions.rightClick = "contextMenu";
      mouseActions.middleClick = null;
      mouseActions.verticalScroll = null;
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
        WM = {
          # window outline
          # inactiveFrame = "239,240,241";
          # frame = accentColor;
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
  home.packages = with pkgs; [
    # (rlly like it, especially with colored borders...)
    # (but it causes Qt6 apps to be blurry on HiDPI displays for some reason)
    # kde-rounded-corners
  ];

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
