{ ... }: {
  # Gamemoderun
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
        igpu_power_threshold = -1;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 1; # THIS IS MACHINE SPECIFIC
        amd_performance_level = "high";
      };
    };
  };
}
