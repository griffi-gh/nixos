{ config, ... }: {
  home.activation.removeHmFontsBackup = {
    data = "rm -f ${config.home.homeDirectory}/.config/fontconfig/conf.d/10-hm-fonts.conf.hm-bak";
    before = [ "checkLinkTargets" ];
    after = [ ];
  };
}