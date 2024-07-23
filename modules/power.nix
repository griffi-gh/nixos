{ config, lib, pkgs, ... } : {
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil"; #alr the default in most cases
    # powerDownCommands = "";
  };
}
