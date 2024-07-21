{ config, lib, pkgs, ... }: {
  # networking :3
  networking = {
    # hostName = "asus-pc";
  	networkmanager = {
  	  enable = true;
  	  wifi.backend = "iwd";
    };
    wireless.iwd.enable = true;
    nftables.enable = true;
    firewall = {
      allowedTCPPorts = [ 22 54686 ];
      allowedUDPPorts = [];
    };
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
}
