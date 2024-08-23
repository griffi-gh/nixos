{ pkgs, ... }: {
  # Manage GTK stuff
  gtk = {
    enable = true;
    # gtk3.extraCss = ''
    #   @import './colors.css';
    # '';
    # gtk4.extraCss = ''
    #   @import './colors.css';
    # '';
    # theme = {
    #   package = pkgs.kdePackages.breeze-gtk;
    #   name = "Breeze-dark";
    # };
  };
}
