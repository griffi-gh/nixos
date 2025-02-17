{ ... }: {
  programs.plasma.panels = [
    {
      location = "bottom";
      hiding = "none";
      floating = true;
      lengthMode = "fill";
      height = 42;
      widgets = [
        {
          kickoff = {
            compactDisplayStyle = true;
          };
        }
        "org.kde.plasma.pager"
        {
          iconTasks = {
            appearance = {
              showTooltips = true;
              highlightWindows = true;
              indicateAudioStreams = true;
              fill = true;
              iconSpacing = "small";
            };
            behavior = {
              middleClickAction = "close";
            };
            launchers = [
              "applications:systemsettings.desktop"
              "applications:org.kde.konsole.desktop"
              # "applications:org.kde.kate.desktop"
              "applications:org.kde.dolphin.desktop"
              "applications:org.kde.plasma-systemmonitor.desktop"
              "preferred://browser"
              "applications:thunderbird.desktop"
              # "applications:goofcord.desktop"
              "applications:vesktop.desktop"
              # "applications:discord-canary.desktop"
              "applications:org.telegram.desktop.desktop"
              "applications:nheko.desktop"
              "applications:tidal-hifi.desktop"
              "applications:dev.zed.Zed.desktop"
              "applications:code.desktop"
              "applications:com.heroicgameslauncher.hgl.desktop"
              "applications:steam.desktop"
            ];
          };
        }
        "org.kde.plasma.marginsseparator"
        {
          systemTray = {
            icons.spacing = "small";
            items = {
              hidden = [
                "kded6"
                "KTailctl"
                "Yakuake"
                "Nextcloud"
                "Xwayland Video Bridge_pipewireToXProxy"
              ];
              shown = [
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.volume"
                "org.kde.plasma.battery"
                "org.kde.plasma.bluetooth"
              ];
              extra = [
                "org.kde.plasma.battery"
                "org.kde.plasma.brightness"
                "org.kde.plasma.cameraindicator"
                "org.kde.plasma.clipboard"
                "org.kde.plasma.devicenotifier"
                "org.kde.plasma.manage-inputmethod"
                "org.kde.plasma.mediacontroller"
                "org.kde.plasma.notifications"
                "org.kde.kscreen"
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.keyboardindicator"
                "org.kde.plasma.keyboardlayout"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.volume"
                "org.kde.kdeconnect"
                "org.kde.plasma.printmanager"
                "Nextcloud"
                "Xwayland Video Bridge_pipewireToXProxy"
              ];
              configs = {
                battery.showPercentage = true;
                keyboardLayout.displayStyle = "label";
              };
            };
          };
        }
        "org.kde.plasma.digitalclock"
        "org.kde.plasma.showdesktop"
      ];
    }
  ];
}
