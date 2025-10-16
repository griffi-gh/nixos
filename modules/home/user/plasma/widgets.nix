{ ... }:
{
  programs.plasma.desktop.widgets = [
    #   {
    #     systemMonitor = {
    #       position = {
    #         horizontal = 1712;
    #         vertical = 0;
    #       };
    #       size = {
    #         width = 208;
    #         height = 144;
    #       };
    #       settings = {
    #         UserBackgroundHints = "ShadowBackground";
    #         Appearance.updateRateLimit = 3000;
    #       };
    #       showTitle = false;
    #       displayStyle = "org.kde.ksysguard.textonly";
    #       sensors = [
    #         {
    #           name = "cpu/all/maximumTemperature";
    #           color = "255,0,0";
    #           label = "CPU Max. Temp.";
    #         }
    #         {
    #           name = "cpu/all/usage";
    #           color = "255,255,0";
    #           label = "CPU Usage";
    #         }
    #         {
    #           name = "gpu/gpu1/usage";
    #           color = "183,107,150";
    #           label = "GPU Usage";
    #         }
    #         {
    #           name = "memory/physical/usedPercent";
    #           color = "0,255,255";
    #           label = "RAM Used";
    #         }
    #         {
    #           name = "power/0027/chargeRate";
    #           color = "149,183,107";
    #           label = "Charging Rate";
    #         }
    #         {
    #           name = "disk/e5544c15-c528-475c-a6e7-64186629d77d/used";
    #           color = "183,155,107";
    #           label = "Disk Used";
    #         }
    #       ];
    #     };
    #   }
  ];
}
