{ config, lib, pkgs, ... }: {
  # desktop nya :3
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      compositor = "kwin"; # may be borked, weston is the default :p
    };
    settings = {
      General = {
        InputMethod = "qtvirtualkeyboard";
      };
    };
  };
  services.desktopManager.plasma6.enable = true;

  # xdg portals
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    # extraPortals = with pkgs; [
    #   xdg-desktop-portal-gtk
    # ];
  };

  # extra stuff
  environment.systemPackages = with pkgs.kdePackages; [
    plasma-browser-integration
    kaccounts-integration
    kaccounts-providers
    qtimageformats
    kimageformats
    qtvirtualkeyboard
  ];

  # kde connect
  programs.kdeconnect = {
    enable = true;
    # package = pkgs.kdePackages.kdeconnect-kde;
  };
}
