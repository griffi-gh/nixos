{ ... }:
{
  # Enable sound
  services.pipewire = {
    enable = true;
    audio.enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    # jack.enable = true;
    extraConfig.pipewire = {
      # fix audio stuttering
      "10-clock-min-quantum" = {
        "context.properties" = {
          "clock.power-of-two-quantum" = true;
          "default.clock.min-quantum" = 512;
          "default.clock.max-quantum" = 4096;
        };
      };
    };
  };
}
