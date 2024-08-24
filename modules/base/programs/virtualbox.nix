{ ... }: {
  virtualisation.virtualbox.host = {
    enable = true;
    # enableKvm = true;
    # enableExtensionPack = true;
  };
  users.extraGroups.vboxusers.members = [ "user" ];
}
