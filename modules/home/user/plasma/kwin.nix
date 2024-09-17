{ ... }: {
  programs.plasma = {
    kwin = {
      virtualDesktops = {
        number = 4;
        rows = 2;
      };
      effects = {
        dimAdminMode.enable = true;
      };
    };
    configFile.kwinrc = {
      # Effects: "Sheet"
      Plugins.sheetEnabled = true;

      # "Navigation Wraps Around"
      Windows.RollOverDesktops = false;
    };
  };
}
