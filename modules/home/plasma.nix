{ ... }: {
  programs.plasma = {
    enable = true;
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      wallpaper = "/home/user/nixos/wallpapers/whatever.png"; #TODO use relative path?
    };
    configFile = {
      kwinrc.Desktops.Number = {
        value = 4;
        immutable = true;
      };
      kwinrc.Desktops.Rows = {
        value = 2;
        immutable = true;
      };
    };
  };
}
