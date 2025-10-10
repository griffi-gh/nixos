{ ... }:
{
  # networking :3
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    wifi.backend = "iwd";
  };

  # dns
  # networking.resolvconf.enable = false;
  # services.resolved = {
  #   enable = true;
  #   dnssec = "false";
  #   dnsovertls = "opportunistic";
  #   fallbackDns = [
  #     # opendns sandbox
  #     "2620:0:ccd::2"
  #     "2620:0:ccc::2"
  #     "208.67.220.2"
  #     "208.67.222.2"
  #     # tailscale
  #     # "100.100.100.100"
  #   ];
  # };

  # firewall
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22 # ssh
      3389 # rdp
      5900 # vnc
      1714
      1764 # kde connect
      18885
      18886 # torrent
      61208
      61209 # glances server
    ];
    allowedUDPPorts = [
      3389 # rdp
      5900 # vnc
      1714
      1764 # kde connect
      18886 # torrent
      34197 # factorio
    ];
  };

  # unnecessary/causes rebuilds to fail
  systemd.services.NetworkManager-wait-online.enable = false;
}
