{ pkgs, ... }: {
  # Manage GTK stuff
  gtk = {
    enable = true;
    theme = {
      # package = pkgs.kdePackages.breeze-gtk;
      # name = "Breeze-Dark";
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
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

  # Still, use Breeze-Dark for Firefox and Thunderbird
  programs.firefox.profiles.default.settings."widget.content.gtk-theme-override" = "Breeze-Dark";
  programs.thunderbird.profiles.default.settings."widget.content.gtk-theme-override" = "Breeze-Dark";
}
