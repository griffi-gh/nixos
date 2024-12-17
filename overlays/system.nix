{ pkgs, lib, ... }:
let
  # XXX: these two options are currently mutually exclusive!
  # (also TODO use nixos module/config system instead of this)

  # Use custom libinput with Hold-and-Tap support
  # (MR 500: https://gitlab.freedesktop.org/libinput/libinput/-/merge_requests/500)
  # ... what have i done ...
  enablePatchedLibinput = false;

  # Enable patched KWin with fixed blurry offscreen effect fix
  enablePatchedKwin = false;
in
(lib.optionalAttrs enablePatchedLibinput {
  environment.systemPackages = with pkgs; [
    libinput-patched
  ];
  system.replaceDependencies.replacements = with pkgs; let
    kwin-patched = kdePackages.kwin.override {
      libinput = libinput-patched;
    };
  in [
    {
      oldDependency = kdePackages.kwin.out;
      newDependency = kwin-patched.out;
    }
  ];
}) // (lib.optionalAttrs enablePatchedKwin {
  # environment.systemPackages = with pkgs; [
  #   kwin-blur-patched
  # ];
  system.replaceDependencies.replacements = [
    (with pkgs; {
      oldDependency = kdePackages.kwin.out;
      newDependency = kwin-blur-patched.out;
    })
  ];
})
