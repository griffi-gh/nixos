{ pkgs, ... }: {
  home = {
    stateVersion = "24.11";
    username = "user";
    homeDirectory = "/home/user";
    packages = with pkgs; [
      # ...
    ];
  };
  programs.home-manager.enable = true;
  imports = [
    # ...
  ];
}
