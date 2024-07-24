{ pkgs, ... }: {
  home = {
    stateVersion = "24.11";
    username = "user";
    homeDirectory = "/home/user";
    packages = with pkgs; [
      eza
      htop
      tree
      glxinfo
      nushell
      firefox
      thunderbird
      blender
      principia
      galaxy-buds-client
    ];
  };

  programs = {
    home-manager.enable = true;
  };

  imports = [
    ../../../modules/home/shell.nix
    ../../../modules/home/git.nix
    ../../../modules/home/plasma.nix
  ];
}
