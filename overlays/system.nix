# Use custom libinput with Hold-and-Tap support
# (MR 500: https://gitlab.freedesktop.org/libinput/libinput/-/merge_requests/500)
{ pkgs, lib, ... }:
let
  # ... what have i done ...
  actuallyEnableThisScaryStuff = false;
in
lib.optionalAttrs actuallyEnableThisScaryStuff {
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
}
