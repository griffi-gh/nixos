{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.tailscale
  ];
  services.tailscale = {
    enable = true;
    port = 41641;
    openFirewall = true;
    # Set to "server" or "both" to allow using as exit node (will enable ip forwarding)
    # Set to "client" or "both" to allow using exit nodes as client (will set reverse path filter to loose)
    useRoutingFeatures = "client";
  };
}
