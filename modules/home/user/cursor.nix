{ pkgs, ... }: let
  cursor = {
    name = "phinger-cursors-dark";
    package = pkgs.phinger-cursors;
    size = 24;
  };
in {
  home.pointerCursor = {
    inherit (cursor) name package size;
    gtk.enable = true;
    x11.enable = true;
  };
  programs.plasma.workspace.cursor = {
    theme = cursor.name;
    inherit (cursor) size;
  };
}
