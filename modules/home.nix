{ ... }: {
  programs.home-manager.enable = true;
  imports = [ ./home/user ];
}
