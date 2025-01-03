{ config, lib, pkgs, ... }: let
  hostname = "fw13";
in {
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.05";
  networking.hostName = hostname;

  boot.kernelParams = [
    "resume=UUID=4f0b5893-4d99-4dbc-9ba0-1ab0ac6c3cfc"
    # "i915.enable_psr=1"
  ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };

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

  hardware.framework.laptop13 = {
    # XXX: hides the headphone port
    # audioEnhancement.enable = true;
  };

  hardware.amdgpu = {
    opencl.enable = true;
    initrd.enable = true;
  };

  hardware.cpu.amd = {
    updateMicrocode = true;
  };
}
