{ ... }:
{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # videoDrivers = ["amdgpu"];
    xkb.layout = "us";
    # xkb.options = "eurosign:e,caps:escape";
  };
}
