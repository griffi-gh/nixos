{ config, lib, pkgs, ... }: {
  networking.hostName = "asus-pc";
  imports = [
    ./hardware-configuration.nix
  ];
  hardware.cpu.amd.updateMicrocode = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.amdgpu = {
    initrd.enable = true;
    legacySupport.enable = true;
    opencl.enable = true;
  };
  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };
  # boot.initrd.kernelModules = [ "amdgpu" "radeon" ];
}
