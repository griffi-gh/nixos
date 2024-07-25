{ config, lib, pkgs, ... }: {
  networking.hostName = "asus-pc";
  imports = [
    ./hardware-configuration.nix
  ];

  # cpu
  hardware.cpu.amd.updateMicrocode = true;

  # gpu
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.amdgpu = {
    initrd.enable = true;
    legacySupport.enable = true;
    opencl.enable = true;
  };
  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };

  # fs
  fileSystems."/".options = [
    "noatime"
    "nossd"
    "autodefrag"
    "space_cache=v2"
  ];

  # boot.initrd.kernelModules = [ "amdgpu" "radeon" ];
}
