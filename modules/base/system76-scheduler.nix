{ ... }:
{
  # enable system76 scheduler
  services.system76-scheduler = {
    enable = true;
    useStockConfig = true;
    assignments = {
      package-manager-nix = {
        nice = 15;
        class = "batch";
        ioClass = "idle";
        matchers = [
          "nix"
          "nix-daemon"
          "nixos-rebuild"
        ];
      };
      desktop-environment-kde = {
        nice = -3;
        ioClass = "best-effort";
        ioPrio = 0;
        matchers = [
          "plasmashell"
          "kwin_x11"
          "kwin_wayland"
          "kwin_wayland_wrapper"
          "krunner"
        ];
      };
    };
  };
}
