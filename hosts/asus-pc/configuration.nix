{ config, lib, pkgs, ... }: let
  hostname = "asus-pc";
in {
  imports = [
    ./hardware-configuration.nix
  ];

  # hostname
  networking.hostName = hostname;

  # cpu
  hardware.cpu.amd.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "schedutil";

  # gpu
  boot.blacklistedKernelModules = [ "radeon" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.amdgpu = {
    initrd.enable = true;
    opencl.enable = true;
    legacySupport.enable = true;
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

  # force tpm2 off
  security.tpm2.enable = lib.mkForce false;

  # boot.initrd.kernelModules = [ "amdgpu" "radeon" ];

  # disable mitigations
  boot.kernelParams = [
    "mitigations=off"
  ];
}
