{ config, lib, pkgs, ... }: let
  hostname = "dell-pc";
in {
  imports = [
    ./hardware-configuration.nix
  ];

  # hostname
  networking.hostName = hostname;

  # gpu
  hardware.amdgpu = {
    # initrd.enable = true;
  };

  # fs
  fileSystems."/nix".options = [ "noatime" ];
}
