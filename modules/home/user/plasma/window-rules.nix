{ lib, ... }: let
  ALL_DESKTOPS = "\\0";
in {
  programs.plasma.window-rules = let
    pip-rules = {
      above = true;
      desktops = ALL_DESKTOPS;
    };
  in [
    {
      description = "firefox-pip";
      match.window-class = "firefox firefox";
      match.title = "Picture-in-Picture";
      apply = pip-rules;
    }
    {
      description = "firefox-pip-nightly";
      match.window-class = "firefox firefox-nightly";
      match.title = "Picture-in-Picture";
      apply = pip-rules;
    }
    {
      description = "tidal-pip";
      match.window-class = "tidal-hifi tidal-hifi";
      match.title = "Picture-in-picture";
      apply = pip-rules;
    }
    {
      description = "xeyes";
      match.window-class = "xeyes XEyes";
      apply.above = true;
    }
    {
      description = "heroic-desktop-file";
      match.window-class = "electron heroic";
      apply.desktopfile = "/etc/profiles/per-user/user/share/applications/com.heroicgameslauncher.hgl.desktop";
    }
    {
      description = "ktailctl-desktop-file";
      match.window-class = "ktailctl";
      apply.desktopfile = "/etc/profiles/per-user/user/share/applications/com.github.kaeza.ktailctl.desktop";
    }
    {
      description = "transmission-qt-desktop-file";
      match.window-class = "transmission-qt";
      apply.desktopfile = "/etc/profiles/per-user/user/share/applications/transmission-qt.desktop";
    }
    {
      description = "vscode-desktop-file-0";
      match.window-class = "code code-url-handler";
      apply.desktopfile = "/etc/profiles/per-user/user/share/applications/code.desktop";
    }
    {
      description = "vscode-desktop-file-1";
      match.window-class = "code code";
      apply.desktopfile = "/etc/profiles/per-user/user/share/applications/code.desktop";
    }
    {
      description = "bitwarden-desktop-file";
      match.window-class = "electron Bitwarden";
      apply.desktopfile = "/etc/profiles/per-user/user/share/applications/bitwarden.desktop";
    }
    {
      description = "zulip-desktop-file";
      match.window-class = "zulip Zulip";
      apply.desktopfile = "/etc/profiles/per-user/user/share/applications/zulip.desktop";
    }
    {
      description = "stremio";
      match.window-class = "stremio com.stremio.stremio";
      apply.desktopfile = "/etc/profiles/per-user/user/share/applications/smartcode-stremio.desktop";
      apply.maximizehoriz = true;
      apply.maximizevert = true;
    }
    {
      description = "imhex-maximize";
      match.window-class = "imhex";
      apply.maximizehoriz = true;
      apply.maximizevert = true;
    }
    {
      # Pomodoro timer: Above all windows and pin to all desktops
      description = "pomodoro-gtk";
      match.window-class = "gjs-console io.gitlab.idevecore.Pomodoro";
      apply = pip-rules;
    }
    # Fix non-resizable device manager windows in Tizen Studio
    # TODO fix this
    # {
    #   description = "tizen-studio-device-manager";
    #   match.window-class = "org.tizen.device.manager.Main";
    #   apply.resizable = {
    #     apply = "force";
    #     value = true;
    #   };
    #   apply.maxsize = {
    #     apply = "force";
    #     value = "9999,9999";
    #   };
    #   apply.minsize = {
    #     apply = "force";
    #     value = "300,100";
    #   };
    # }
    {
      description = "discord-canary-desktop-file";
      match.window-class = "DiscordCanary discord";
      apply.desktopfile = "/etc/profiles/per-user/user/share/applications/discord-canary.desktop";
    }
  ];
  programs.plasma.configFile."kwinrulesrc".General = {
    count.immutable = lib.mkForce false;
    rules.immutable = lib.mkForce false;
  };
}
