{ pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    gns3-server
    ubridge
    dynamips
  ];
  security.wrappers.ubridge = {
    source = lib.getExe pkgs.ubridge;
    capabilities = "cap_net_admin,cap_net_raw=ep";
    owner = "root";
    group = "ubridge";
    permissions = "u+rx,g+x";
  };
  users.extraGroups.ubridge.members = [ "user" ];
}