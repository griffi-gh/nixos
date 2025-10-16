{ ... }:
let
  outOfTreePlugin = name: {
    home.file.".local/share/kwin/effects/${name}" = {
      source = ../../../../assets/kwin/plugins/${name}/package;
    };
  };
in
outOfTreePlugin "morphingpopups"
// {
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

      # Set the Task Switcher to "Sidebar"
      TabBox.LayoutName = "Sidebar";
    };
  };
}
