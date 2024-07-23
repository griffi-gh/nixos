{ config, lib, pkgs, ... }: {
  # desktop nya :3
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  # xdg portals
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };
}
