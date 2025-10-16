{ ... }:
{
  programs.plasma.configFile.dolphinrc =
    let
      sidebarIconSize = 16;
    in
    {
      General = {
        GlobalViewProps = false;
        ConfirmClosingMultipleTabs = false;
        RememberOpenedTabs = false;
        ShowFullPath = true;
        ShowStatusBar = "FullWidth";
        ShowZoomSlider = true;
      };
      "KFileDialog Settings" = {
        "Places Icons Auto-resize" = false;
        "Places Icons Static Size" = sidebarIconSize;
      };
      PlacesPanel = {
        IconSize = sidebarIconSize;
      };
      "Notification Messages" = {
        warnAboutRisksBeforeActingAsAdmin = false;
      };
      VersionControl = {
        enabledPlugins = "Git";
      };
    };
}
