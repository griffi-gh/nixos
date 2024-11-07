{ ... }: {
  home.activation.removeHmFontsBackup = {
    data = "rm -f $HOME/home/user/.config/fontconfig/conf.d/10-hm-fonts.conf.hm-bak";
    before = [ "checkLinkTargets" ];
    after = [ ];
  };
}