{ config, lib, pkgs, ... }: {
  # Use the systemd-boot EFI boot loader.
  boot = {
    bootspec = {
      enable = true;
      enableValidation = false;
    };
    kernelPackages = pkgs.linuxPackages_latest; # Use latest stable Linux
    kernelParams = [
      "nmi_watchdog=0"
      "nowatchdog"
    ];
    initrd = {
      systemd = {
        enable = true;
        strip = true;
      };
      verbose = true;
    };
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        enable = true;
        editor = false;
      };
      timeout = 0;
    };
    # TODO fix plymouth:
    # plymouth = {
    #   enable = true;
    #   theme = "bgrt";
    # };
  };
}
