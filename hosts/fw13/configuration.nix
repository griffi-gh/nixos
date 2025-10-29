{
  lib,
  pkgs,
  ...
}:
let
  hostname = "fw13";
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.11";
  networking.hostName = hostname;

  services.udev.extraRules = ''
    # PCI auto suspend
    SUBSYSTEM=="pci", ATTR{power/control}="auto"
  '';
  hardware.sensor.iio.enable = true; # ambient light sensor

  # === Kernel ===
  boot.kernelParams = [
    # "amdgpu.abmlevel=0"
    # "amdgpu.sg_display=0"
    "pcie_aspm=force"
    # "pcie_aspm.policy=powersupersave"
  ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.dirty_writeback_centisecs" = 1500;
  };

  services.fwupd = {
    enable = true;
    extraRemotes = [ "lvfs-testing" ];
  };

  # XXX: hides the headphone port
  # hardware.framework.laptop13.audioEnhancement.enable = true;

  environment.systemPackages = with pkgs; [
    fw-ectool
    ryzenadj
  ];

  # hardware.amdgpu.initrd.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.amdgpu.opencl.enable = true;
  hardware.graphics.extraPackages = with pkgs.rocmPackages; [
    clr
    clr.icd
  ];
  systemd.tmpfiles.rules = [
    "L+ /opt/rocm - - - - ${
      pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      }
    }"
  ];

  hardware.cpu.amd = {
    updateMicrocode = true;
    ryzen-smu.enable = true;
  };

  hardware.fw-fanctrl = {
    enable = true;
    config = {
      defaultStrategy = "lazy";
      strategyOnDischarging = "laziest";
    };
  };

  boot.initrd.kernelModules = [
    "dm-snapshot"
    "cryptd"
  ];
  boot.initrd.luks.devices."cryptroot" = {
    device = "/dev/disk/by-label/NIXLUKS";
    preLVM = true;
    bypassWorkqueues = true;
    allowDiscards = true;
  };
  fileSystems =
    let
      btrfsOptions = {
        device = lib.mkForce "/dev/disk/by-label/nixos";
        options = [
          "ssd"
          "noatime"
          "compress=zstd:1"
          "discard=async"
        ];
      };
    in
    {
      "/" = btrfsOptions;
      "/home" = btrfsOptions;
      "/nix" = btrfsOptions;
      "/boot" = {
        device = lib.mkForce "/dev/disk/by-label/BOOT";
        options = [ "noatime" ];
      };
    };
  services.fstrim.enable = true;
}
