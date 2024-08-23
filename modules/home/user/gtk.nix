{ pkgs, ... }: {
  # Manage GTK stuff
  gtk = {
    enable = true;
    theme = {
      package = pkgs.kdePackages.breeze-gtk;
      name = "Breeze-Dark";
    };
    gtk3 = {
      extraConfig = {
        gtk-modules = "colorreload-gtk-module:window-decoration-gtk-module";
      };
      extraCss = "@import 'colors.css';";
    };
    gtk4 = {
      extraCss = "@import 'colors.css';";
    };
  };
}
