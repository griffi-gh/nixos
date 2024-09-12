# ubridge (required by GNS3)
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ubridge
  ];
  security.wrappers.ubridge = {
    source = "/run/current-system/sw/bin/ubridge";
    capabilities = "cap_net_admin,cap_net_raw=ep";
    owner = "root";
    group = "ubridge";
    permissions = "u+rx,g+x";
  };
  users.extraGroups.ubridge.members = [ "user" ];
}
