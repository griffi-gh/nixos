{ ... }: {
  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    update.onActivation = true;
    remotes = [
      { name = "flathub"; location = "https://flathub.org/repo/flathub.flatpakrepo"; }
      { name = "sober"; location = "https://sober.vinegarhq.org/repo/"; }
    ];
    packages = [
      { appId = "org.vinegarhq.Sober"; origin = "sober";  }
    ];
    overrides = {
      global = {
        # Force Wayland by default
        Context.sockets = [ "wayland" "!x11" "!fallback-x11" ];
        Environment = {
          # Fix un-themed cursor in some Wayland apps
          XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
          # Force correct theme for some GTK apps
          GTK_THEME = "Adwaita:dark";
        };
      };
    };
  };

  # gpg signature for the sober repo
  xdg.dataFile."flatpak/repo/sober.trustedkeys.gpg" = {
    enable = true;
    source = ../../../assets/sober.trustedkeys.gpg;
  };

  # fix app icons not appearing
  xdg.systemDirs.data = [
    # TODO: this is user-speicific:
    "/home/user/.local/share/flatpak/exports/share"
    "/var/lib/flatpak/exports/share"
  ];
}
