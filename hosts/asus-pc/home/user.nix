{ pkgs, ... }: {
  home = {
    stateVersion = "24.11";
    username = "user";
    homeDirectory = "/home/user";
    packages = with pkgs; [
      htop
      tree
      glxinfo
      nushell
      firefox
      thunderbird
      libreoffice-qt6-fresh
      blender
      principia
      galaxy-buds-client
    ];
  };

  programs = {
    home-manager.enable = true;
  };

  imports = [
    ../../../modules/home.nix
  ];
}
