{ pkgs, ... }: let
  # Use custom libinput with Hold-and-Tap support
  # (MR 500: https://gitlab.freedesktop.org/libinput/libinput/-/merge_requests/500)
  usePatchedLibinput = false;
in

(if usePatchedLibinput then {
  environment.systemPackages = with pkgs; [
    libinput-patched
  ];
  system.replaceRuntimeDependencies = with pkgs; let
    kwin-patched = kdePackages.kwin.override {
      libinput = libinput-patched;
    };
  in [
    {
      original = kdePackages.kwin.out;
      replacement = kwin-patched.out;
    }
  ];
} else {})