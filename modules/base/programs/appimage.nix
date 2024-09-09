{ pkgs, ... }: {
  # AppImage support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  environment.systemPackages = with pkgs; [
    # AppImage support
    appimage-run
  ];
}
