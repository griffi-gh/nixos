{ pkgs, ... }:
{
  # Steam can only be installed system-wide :<\
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
  };
  environment.systemPackages = with pkgs; [
    protonup-qt
  ];
  # chaotic.steam.extraCompatPackages = with pkgs; [
  #   proton-ge-custom
  # ];
}
