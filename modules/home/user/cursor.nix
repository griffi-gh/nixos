{ pkgs, ... }: let
  cursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-dark";
    size = 26; # Cursed! base grid supported by phinger is either 24 or 32, 32/1.25 = 25.6, rounded...
    # package = pkgs.capitaine-cursors;
    # name = "capitaine-cursors";
    # size = 24;
    # package = pkgs.volantes-cursors;
    # name = "volantes_cursors";
  };
in {
  home.pointerCursor = {
    inherit (cursor) name package size;
    gtk.enable = true;
    x11.enable = true;
  };
  programs.plasma.workspace.cursor = {
    inherit (cursor) size;
    theme = cursor.name;
  };
}
