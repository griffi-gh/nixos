{ pkgs, ... }:
{
  home.file.".local/share/icons/default" = {
    source = "${pkgs.kdePackages.breeze}/share/icons/breeze_cursors/";
    recursive = true;
  };
  # export XCURSOR_PATH="$(readlink -f /run/current-system/sw)/share/icons $XCURSOR_PATH"
}
