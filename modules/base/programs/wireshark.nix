{ pkgs, ... }: {
  # Wireshark (requires dumpcap wrapper, so configured system-wide)
  environment.systemPackages = with pkgs; [ wireshark ];
  programs.wireshark.enable = true;
  # users.extraGroups.wireshark.members = [ "user" ];
  users.users.user.extraGroups = [ "wireshark" "tcpdump" ];
}
