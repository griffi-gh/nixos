{ ... }: {
  # networking :3
  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    # wireless.iwd.enable = true;

    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22    # ssh
        3389  # rdp
        9993  # zerotier
      ];
      allowedUDPPorts = [
        3389  # rdp
        9993  # zerotier
      ];
    };

    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
}
