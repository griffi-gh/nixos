{ ... }: {
  programs.plasma.configFile.konsolerc = let
    immutable = value: { inherit value; immutable = true; };
  in {
    "Desktop Entry" = {
      DefaultProfile = "fish.profile";
    };
    TabBar = {
      CloseTabOnMiddleMouseButton = immutable true;
      TabBarPosition = immutable "Left";
      TabBarVisibility = immutable "AlwaysShowTabBar";
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
