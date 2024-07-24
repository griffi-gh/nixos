{ config, lib, pkgs, ... }: {
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    mouse = {
      # accelProfile = "flat";
      # accelSpeed = "0";
      middleEmulation = false;
    };
    touchpad = {
      naturalScrolling = true;
      disableWhileTyping = true;
      tapping = true;
      clickMethod = "clickfinger";
    };
  };
}
