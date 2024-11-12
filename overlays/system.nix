{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    libinpux
  ];
  system.replaceRuntimeDependencies = with pkgs; [
    {
      original = libinput.out;
      replacement = libinpux.out;
    }
  ];
}
