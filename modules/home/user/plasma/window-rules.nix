{ ... }: {
  programs.plasma.window-rules = [
    {
      description = "hm-firefox-pip";
      match = {
        window-class = "firefox";
        title = "Picture-in-Picture";
      };
      apply.above = true;
      # apply.desktops = "\\0";
    }
    {
      description = "hm-heroic-desktop-file";
      match.window-class = "electron heroic";
      apply.desktopfile = "/etc/profiles/per-user/user/share/applications/com.heroicgameslauncher.hgl.desktop";
    }
    {
      description = "hm#-ktailctl-desktop-file";
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
  ];
}
