{ config, lib, pkgs, ... }: {
  # networking :3
  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    wireless.iwd.enable = true;

    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22    # ssh
        3389  # rdp
        54686 # vscode-server port forwarding
      ];
      allowedUDPPorts = [
        3389  # rdp
      ];
    };
    
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
}