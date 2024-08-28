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

  # fs
  fileSystems = {
    "/".options = [ "ssd" "noatime" "compress=zstd:1" ];
    "/home".options = [ "ssd" "noatime" "compress=zstd:1" ];
    "/nix".options = [ "ssd" "noatime" "compress=zstd:1" ];
    "/boot".options = [ "noatime" ];
  };

  # services
  services.thermald.enable = true;
  services.fwupd.enable = true;

  # cpu
  hardware.cpu.amd.updateMicrocode = true;

  # HACK: wifi
  networking.networkmanager.wifi.powersave = false;
  boot.extraModprobeConfig = ''
    options rtw88_core disable_lps_deep=y
    options rtw88_pci disable_msi=y disable_aspm=y
    options rtw_core disable_lps_deep=y
    options rtw_pci disable_msi=y disable_aspm=y
  '';

  # HACK: disable hibernation
  boot.kernelParams = [ "nohibernate" ];

  # HACK: steam scaling
  environment.sessionVariables = {
    STEAM_FORCE_DESKTOPUI_SCALING = "1.25";
  };
}
