{ pkgs, ... }:
{
  home.file.".local/share/icons/breeze_cursors" = {
    source = "${pkgs.kdePackages.breeze}/share/icons/breeze_cursors/";
    recursive = true;
  };
}
