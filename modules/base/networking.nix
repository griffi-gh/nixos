{ ... }: {
  # networking :3
  networking = {
    networkmanager = {
      enable = true;
      # wifi.backend = "iwd";
      # DOES NOT PLAY WELL WITH KDE!
      # issues:
      # - makes it forget wifi network is protected
      # - wpa3 is borked
      # - no hotspot
    };
    # wireless.iwd.enable = true;

    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22    # ssh
        3389  # rdp
        5900  # vnc
        1714 1764 # kde connect
        18886 # torrent
        61208 61209 # glances server
        2234  # soulseek/nicotine+
      ];
      allowedUDPPorts = [
        3389  # rdp
        5900  # vnc
        1714 1764 # kde connect
        18886 # torrent
      ];
    };

    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # Unnecesary on single-user systems, slows down boot, causes rebuilds to fail
  systemd.services.NetworkManager-wait-online.enable = false;
}
