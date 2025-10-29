{ ... }:
let
  outOfTreePlugin =
    name:
    { ... }:
    {
      home.file.".local/share/kwin/effects/${name}" = {
        source = ../../../../assets/kwin/plugins/${name}/package;
      };
    };
in
{
  imports = [
    (outOfTreePlugin "morphingpopups")
  ];
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
      # desktop effects:
      Plugins = {
        sheetEnabled = true; # "sheet"
        blurEnabled = false;
        forceblurEnabled = true; # Effect-blurplus
      };
      Effect-blurplus = {
        FakeBlur = true;
        FakeBlurDisableWhenWindowBehind = false;
        WindowClasses = "";
      };
    };
  };
}
