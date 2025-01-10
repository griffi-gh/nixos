{ config, lib, pkgs, ... }: let
  hostname = "fw13";
in {
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.05";
  networking.hostName = hostname;

  # === Kernel ===
  boot.kernelParams = [
    "resume=UUID=4f0b5893-4d99-4dbc-9ba0-1ab0ac6c3cfc"
    "amdgpu.sg_display=0"
    # "i915.enable_psr=1"
  ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };

  # === Filesystems ===

  fileSystems = let
    btrfsOptions = [ "ssd" "noatime" "compress=zstd:1" ];
  in {
    "/".options = btrfsOptions;
    "/home".options = btrfsOptions;
    "/nix".options =  btrfsOptions;
    "/boot".options = [ "noatime" ];
  };

  # === Misc ===

  services.fwupd = {
    enable = true;
    extraRemotes = [ "lvfs-testing" ];
  };

  hardware.framework.laptop13 = {
    # XXX: hides the headphone port
    # audioEnhancement.enable = true;
  };

  # === GPU ===

  hardware.amdgpu = {
    opencl.enable = true;
    initrd.enable = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  # misc. opencl support
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];
  systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in [
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];

  # === CPU ===
  hardware.cpu.amd.updateMicrocode = true;
}
