{ pkgs, ... }:
{
  virtualisation = {
    containers = {
      enable = true;
      storage.settings.storage.driver = "btrfs";
    };
    oci-containers.backend = "podman";
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
      autoPrune.enable = true;
    };
  };
  environment.systemPackages = with pkgs; [
    podman
    podman-tui
    podman-compose
    # pods
  ];
}
