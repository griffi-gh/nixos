{ pkgs, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    nss.enableGuest = true;
    qemu.vhostUserPackages = [ pkgs.virtiofsd ];
  };
  programs.virt-manager.enable = true;

  # virtualisation.virtualbox.host = {
  #   enable = true;
  #   # enableKvm = true;
  #   # enableExtensionPack = true;
  # };
  # users.extraGroups.vboxusers.members = [ "user" ];
  # environment.variables = {
  #   # skip SVM check
  #   # VBOX_HWVIRTEX_IGNORE_SVM_IN_USE = true;
  # };
}
