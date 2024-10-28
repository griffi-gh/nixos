{ pkgs, ... }: {
  # Use the systemd-boot EFI boot loader.
  boot = {
    bootspec = {
      enable = true;
      enableValidation = false;
    };
    kernelPackages = pkgs.linuxPackages_zen; # Use latest stable Linux
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
      theme = "bgrt";
    };
  };
}
