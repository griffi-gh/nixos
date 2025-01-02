{ config, lib, pkgs, ... }: let
  hostname = "fw13";
in {
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.05";

  networking.hostName = hostname;

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
}
