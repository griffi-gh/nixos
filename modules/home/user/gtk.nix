{ pkgs, ... }: {
  # Manage GTK stuff
  gtk = {
    enable = true;
    theme = {
      package = pkgs.kdePackages.breeze-gtk;
      name = "Breeze-dark";
    };
  };
}
