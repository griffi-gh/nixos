{ pkgs, ... }:
let
  kernelPackages = pkgs.linuxPackages_latest;
in
{
  # Use the systemd-boot EFI boot loader.
  boot = {
    inherit kernelPackages;

    kernelParams = [
      "modprobe.blacklist=sp5100_tco"
      "nmi_watchdog=0"
      "nowatchdog"
      "quiet"
      "splash"
      "udev.log_level=3"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
      "plymouth.use-simpledrm"
      "amdgpu.seamless=1"
    ];

    initrd = {
      systemd.enable = true;
      verbose = false;
    };
    consoleLogLevel = 0;

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
      theme = "blahaj";
      themePackages = with pkgs; [
        plymouth-blahaj-theme
      ];
    };
  };

  environment.systemPackages = with kernelPackages; [
    perf
  ];
}
