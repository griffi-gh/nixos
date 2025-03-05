{ config, lib, pkgs, ... }: let
  hostname = "fw13";
  # If true, use weekly fstrim.service instead of discard=async
  btrfs-nodiscard = true;
in {
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.05";
  networking.hostName = hostname;

  # === Kernel ===
  boot.kernelParams = [
    # added this for hibernation, idk if it's necessary
    "resume=UUID=4f0b5893-4d99-4dbc-9ba0-1ab0ac6c3cfc"

    # scatter-whatever. can cause issues with external displays.
    "amdgpu.sg_display=0"

    # AMD backlight management (aka Vari-Bright).
    # ruins colors and suspected cause for flicker issues.
    # Yep, should be fixed in a future kernel, TODO: remove this
    # https://gitlab.freedesktop.org/drm/amd/-/issues/3853
    # https://lore.kernel.org/all/20241227073700.3102801-1-alexander.deucher@amd.com/
    "amdgpu.abmlevel=0"
  ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.dirty_writeback_centisecs" = 1500;
  };

  # === Filesystems ===

  fileSystems = let
    btrfsOptions =
      [ "ssd" "noatime" "compress=zstd:1" ]
      ++ (if btrfs-nodiscard then [ "nodiscard" ] else [ "discard=async" ]);
  in {
    "/".options = btrfsOptions;
    "/home".options = btrfsOptions;
    "/nix".options =  btrfsOptions;
    "/boot".options = [ "noatime" ];
  };

  services.fstrim.enable = btrfs-nodiscard;

  # === Misc ===

  services.fwupd = {
    enable = true;
    extraRemotes = [ "lvfs-testing" ];
  };

  hardware.framework.laptop13 = {
    # XXX: hides the headphone port
    # audioEnhancement.enable = true;
  };

  # === Packages ===
  environment.systemPackages = with pkgs; [
    fw-ectool
  ];

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

  # === Fans ===
  programs.fw-fanctrl = {
    enable = true;
    config = {
      defaultStrategy = "lazy";
      strategyOnDischarging = "laziest";
    };
  };
}
