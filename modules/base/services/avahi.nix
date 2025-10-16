{ ... }:
{
  services.avahi = {
    enable = true;
    publish.enable = true;
    openFirewall = true;
    ipv4 = true;
    nssmdns4 = true;
    ipv6 = true;
    nssmdns6 = false;
  };
}
