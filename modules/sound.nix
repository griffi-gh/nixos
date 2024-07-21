{ config, lib, pkgs, ... }: {
  # Enable sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}
