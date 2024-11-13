{ pkgs, ... }: let
  # Use custom libinput with Hold-and-Tap support
  # (MR 500: https://gitlab.freedesktop.org/libinput/libinput/-/merge_requests/500)
  doUseLibinpux = true;
in if doUseLibinpux then {
  environment.systemPackages = with pkgs; [
    libinpux
  ];
  system.replaceRuntimeDependencies = with pkgs; let
    kwinx = kdePackages.kwin.override {
      libinput = libinpux;
    };
  in [
    {
      original = kdePackages.kwin.out;
      replacement = kwinx.out;
    }
  ];
} else {}
