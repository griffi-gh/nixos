{ ... }:
{
  programs.mpv = {
    enable = true;
    config = {
      hwdec = "auto";
      vo = "gpu-next";
      gpu-context = "wayland";
    };
  };
}
