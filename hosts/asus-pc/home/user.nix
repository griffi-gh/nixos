{ pkgs, ... }: {
  home = {
    stateVersion = "24.11";
    username = "user";
    homeDirectory = "/home/user";
    packages = with pkgs; [
      # ...
    ];
  };

  programs = {
    home-manager.enable = true;

    fish.enable = true;
    nushell.enable = true;
    carapace.enable = true;
    starship = {
      enable = true;
      enableTransience = true;
    };
  };

  imports = [
    # ...
  ];
}
