{ config, lib, pkgs, ... }: {
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    # startWhenNeeded = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    openFirewall = true;
  };
}
