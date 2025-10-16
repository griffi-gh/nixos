{ ... }:
{
  #   services.flatpak = {
  #     enable = true;
  #     uninstallUnmanaged = true;
  #     update.onActivation = true;
  #     remotes = let
  #       trustedkey = repo: "${../../../assets/trustedkeys/${repo}.trustedkeys.gpg}";
  #     in [
  #       {
  #         name = "flathub";
  #         location = "https://flathub.org/repo/flathub.flatpakrepo";
  #         gpg-import = trustedkey "flathub";
  #       }
  #       {
  #         name = "flathub-beta";
  #         location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
  #         gpg-import = trustedkey "flathub-beta";
  #       }
  #       {
  #         name = "sober";
  #         location = "https://sober.vinegarhq.org/repo/";
  #         gpg-import = trustedkey "sober";
  #       }
  #     ];
  #     packages = [
  #       { appId = "org.vinegarhq.Sober"; origin = "sober";  }
  #       # { appId = "org.gimp.GIMP"; origin = "flathub-beta"; }
  #     ];
  #     overrides = {
  #       global = {
  #         # Force Wayland by default
  #         Context.sockets = [ "wayland" "!x11" "!fallback-x11" ];
  #         Environment = {
  #           # Fix un-themed cursor in some Wayland apps
  #           XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
  #           # Force correct theme for some GTK apps
  #           GTK_THEME = "Adwaita:dark";
  #         };
  #       };
  #     };
  #   };

  #   # gpg signature for flatpak repos
  # #   xdg.dataFile = let
  # #     trustRepo = repo: {
  # #       "flatpak/repo/${repo}.trustedkeys.gpg" = {
  # #         enable = true;
  # #         source = ../../../assets/trustedkeys/${repo}.trustedkeys.gpg;
  # #       };
  # #     };
  # #   in (
  # #     (trustRepo "flathub") //
  # #     (trustRepo "flathub-beta") //
  # #     (trustRepo "sober")
  # #   );

  #   # fix app icons not appearing
  #   xdg.systemDirs.data = [
  #     # TODO: this is user-speicific:
  #     "/home/user/.local/share/flatpak/exports/share"
  #     "/var/lib/flatpak/exports/share"
  #   ];
}
