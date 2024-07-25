{ config, lib, pkgs, ... }: {
  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "9e1948db635b9d3e" # personal
    ];
  };
}
