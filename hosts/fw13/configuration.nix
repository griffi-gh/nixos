{ config, lib, pkgs, ... }: let
  hostname = "fw13";
in {
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.05";
  networking.hostName = hostname;

  hardware.framework.laptop13.audioEnhancement = true;

  boot.kernelParams = [
    "resume=UUID=4f0b5893-4d99-4dbc-9ba0-1ab0ac6c3cfc"
    # "i915.enable_psr=1"
  ];

  fileSystems = let
    btrfsOptions = [ "ssd" "noatime" "nodiscard" "compress=zstd:1" ];
  in {
    "/".options = btrfsOptions;
    "/home".options = btrfsOptions;
    "/nix".options =  btrfsOptions;
    "/boot".options = [ "noatime" ];
  };

  services.fwupd = {
    enable = true;
    extraRemotes = [ "lvfs-testing" ];
  };

  hardware.amdgpu = {
    opencl.enable = true;
    initrd.enable = true;
  };

  hardware.cpu.amd = {
    updateMicrocode = true;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };
}
