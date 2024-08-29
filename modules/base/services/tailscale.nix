{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.tailscale
  ];
  services.tailscale = {
    enable = true;
    port = 41641;
    openFirewall = true;
  };
}
