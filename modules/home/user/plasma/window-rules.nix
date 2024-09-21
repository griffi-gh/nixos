{ lib, ... }: let
  ALL_DESKTOPS = "\\0";
in {
  programs.plasma.window-rules = [
    {
      description = "hm-firefox-pip";
      match.window-class = "firefox firefox";
      match.title = "Picture-in-Picture";
      apply.above = true;
      apply.desktops = ALL_DESKTOPS;
    }
    {
      description = "hm-xeyes";
      match.window-class = "xeyes XEyes";
      apply.above = true;
    }
    {
      description = "hm-heroic-desktop-file";
      match.window-class = "electron heroic";
      apply.desktopfile = "/etc/profiles/per-user/user/share/applications/com.heroicgameslauncher.hgl.desktop";
    }
    {
      description = "hm-ktailctl-desktop-file";
      match.window-class = "ktailctl";
      apply.desktopfile = "/etc/profiles/per-user/user/share/applications/com.github.kaeza.ktailctl.desktop";
    }
    {
      description = "hm-transmission-qt-desktop-file";
      match.window-class = "transmission-qt";
      apply.desktopfile = "/etc/profiles/per-user/user/share/applications/transmission-qt.desktop";
    }
    {
      description = "hm-vscode-desktop-file";
      match.window-class = "code code-url-handler";
      apply.desktopfile = "/etc/profiles/per-user/user/share/applications/code.desktop";
    }
    {
      description = "hm-bitwarden-desktop-file";
      match.window-class = "electron Bitwarden";
      apply.desktopfile = "/etc/profiles/per-user/user/share/applications/bitwarden.desktop";
    }
    {
      description = "hm-zulip-desktop-file";
      match.window-class = "zulip Zulip";
      apply.desktopfile = "/etc/profiles/per-user/user/share/applications/zulip.desktop";
    }
    {
      description = "hm-stremio";
      match.window-class = "stremio com.stremio.stremio";
      apply.desktopfile = "/etc/profiles/per-user/user/share/applications/smartcode-stremio.desktop";
      apply.maximizehoriz = true;
      apply.maximizevert = true;
    }
    {
      description = "hm-imhex-maximize";
      match.window-class = "imhex";
      apply.maximizehoriz = true;
      apply.maximizevert = true;
    }
  ];
  programs.plasma.configFile."kwinrulesrc".General = {
    count.immutable = lib.mkForce false;
    rules.immutable = lib.mkForce false;
  };
}
