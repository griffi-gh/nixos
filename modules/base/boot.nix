{ pkgs, ... }:
let
  kernelPackages = pkgs.linuxPackages_latest;
in
{
  # Use the systemd-boot EFI boot loader.
  boot = {
    inherit kernelPackages;
    bootspec = {
      enable = true;
      enableValidation = false;
    };
    kernelParams = [
      "modprobe.blacklist=sp5100_tco"
      "nmi_watchdog=0"
      "nowatchdog"
      "quiet"
      "plymouth.use-simpledrm"
    ];
    initrd = {
      systemd.enable = true;
      verbose = true;
    };
    loader = {
      efi.canTouchEfiVariables = true;
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
      # theme = "breeze";
    };
  };
  environment.systemPackages = with kernelPackages; [
    perf
  ];
}
