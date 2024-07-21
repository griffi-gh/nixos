{ config, lib, pkgs, ... }: {
  networking.hostName = "asus-pc";
  imports = [
    ./hardware-configuration.nix
    ./amdgpu-pre-vega.nix
  ];
  services.xserver.videoDrivers = [ "amdgpu" ];
}
