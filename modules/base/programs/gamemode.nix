{ ... }: {
  # Gamemoderun
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
        desiredgov = "performance"; # governor to use while gaming
        igpu_desiredgov = "performance"; # governor when igpu is under load
        igpu_power_threshold = -1; # mayb just set it to sth like 0.9 to avoid overheating?
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 1; # <- this is machine-specific (usually 0, but this one's weird)
        amd_performance_level = "high"; # force high clocks
      };
    };
  };
  # Breaks Steam games:
  # environment.sessionVariables = {
  #   GAMEMODERUNEXEC = "powerprofilesctl launch";
  # };
}
