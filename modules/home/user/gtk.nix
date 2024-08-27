{ pkgs, ... }: {
  # Manage GTK stuff
  gtk = {
    enable = true;
    theme = {
      package = pkgs.kdePackages.breeze-gtk;
      name = "Breeze-Dark";
      # package = pkgs.adw-gtk3;
      # name = "adw-gtk3-dark";
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
  # foce overwrite gtkrc
  # home.file.".gtkrc-2.0".force = pkgs.lib.mkForce true;
  home.activation.removeGtkRc = {
    data = "rm -f $HOME/.gtkrc-2.0";
    before = [ "checkLinkTargets" ];
    after = [ ];
  };

  # Still, use Breeze-Dark for Firefox and Thunderbird
  # programs.firefox.profiles.default.settings."widget.content.gtk-theme-override" = "Breeze:dark";
  # programs.thunderbird.profiles.default.settings."widget.content.gtk-theme-override" = "Breeze:dark";
}
