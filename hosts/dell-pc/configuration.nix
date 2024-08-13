{ config, lib, pkgs, ... }: let
  hostname = "dell-pc";
in {
  imports = [
    ./hardware-configuration.nix
  ];

  # hostname
  networking.hostName = hostname;

  # early gpu init (DO NOT USE, CAUSES FLICKER)
  # hardware.amdgpu.initrd.enable = true;

  # opencl
  hardware.amdgpu.opencl.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  # hip/rocm
  systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [ rocblas hipblas clr ];
      };
    in [
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];

  # cpu
  hardware.cpu.amd.updateMicrocode = true;

  # fs
  fileSystems."/nix".options = [ "noatime" ];
}
