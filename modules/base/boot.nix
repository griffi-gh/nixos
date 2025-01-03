{ pkgs, ... }: let
  linux = pkgs.linuxPackages_latest;
in {
  # Use the systemd-boot EFI boot loader.
  boot = {
    bootspec = {
      enable = true;
      enableValidation = false;
    };
    kernelPackages = linux; # linuxPackages_latest
    kernelParams = [
      "modprobe.blacklist=sp5100_tco"
      "nmi_watchdog=0"
      "nowatchdog"
      "quiet"
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
    tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
    };
    plymouth = {
      enable = true;
      # theme = "bgrt";
      theme = "breeze";
    };
  };
  environment.systemPackages = with linux; [
    perf
  ];
}
