{ ... }: {
  # TODO: use nix-flatpak
  # services.flatpak = {
  #   enable = true;
  # };

  # TODO: this is user-speicific:
  xdg.systemDirs.data = [
    "/home/user/.local/share/flatpak/exports/share"
    "/var/lib/flatpak/exports/share"
  ];
}
