{ inputs, ... }:
{
  # KWin script
  home.file.".local/share/kwin/scripts/kwin-system76-scheduler-integration" = {
    source = inputs.kwin-system76-scheduler-integration;
  };
  programs.plasma.configFile.kwinrc.Plugins."kwin-system76-scheduler-integrationEnabled" = true;

  # DBus proxy
  systemd.user.services."com.system76.Scheduler.dbusproxy" = {
    Unit.Description = "Forward com.system76.Scheduler session DBus messages to the system bus";
    Service.ExecStart = "/usr/bin/env bash ${inputs.kwin-system76-scheduler-integration}/system76-scheduler-dbus-proxy.sh";
    Install.WantedBy = [ "default.target" ];
  };
}
