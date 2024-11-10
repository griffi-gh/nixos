{ pkgs, ... }: {
  virtualisation = {
    containers = {
      enable = true;
      storage.settings.storage.driver = "btrfs";
    };
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
      autoPrune.enable = true;
    };
  };
  environment.systemPackages = with pkgs; [
    podman
    podman-tui
    podman-compose
    pods
  ];
}
