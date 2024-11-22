{ ... }: {
  programs.plasma.shortcuts = {
    # yakuake.toggle-window-state = "Calculator,F12,Open/Retract Yakuake";
    "services/org.kde.spectacle.desktop".RectangularRegionScreenShot = [
        "Meta+Shift+Print"
        "Meta+`"
    ];
  };
}
