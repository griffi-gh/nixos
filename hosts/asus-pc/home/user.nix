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

    fish = {
      enable = true;
      shellAliases = {
        cat = "bat";
        cls = "clear";
        "cd.." = "cd ..";
      };
    };
    nushell.enable = true;
    carapace.enable = true;
    starship = {
      enable = true;
      enableTransience = true;
    };
    bat.enable = true;

    git = {
      enable = true;
      userName = "griffi-gh";
      userEmail = "prasol258@gmail.com";
      lfs.enable = true;
      extraConfig = {
        credential.helper = "store";
      };
    };
  };

  imports = [
    # ...
  ];
}
