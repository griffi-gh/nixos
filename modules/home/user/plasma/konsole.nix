{ ... }: {
  # TODO use programs.konsole instead
  programs.plasma.configFile.konsolerc = {
    "Desktop Entry" = {
      DefaultProfile = "fish.profile";
    };
    TabBar = {
      CloseTabOnMiddleMouseButton = true;
      TabBarPosition = "Left";
      TabBarVisibility = "AlwaysShowTabBar";
    };
  };
  xdg.dataFile = {
    "konsole/custom-theme.colorscheme" = {
      enable = true;
      source = ../../../../assets/konsole/custom-theme.colorscheme;
    };
    "konsole/fish.profile" = {
      enable = true;
      source = ../../../../assets/konsole/fish.profile;
    };
  };
}
