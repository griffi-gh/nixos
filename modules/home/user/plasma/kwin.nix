{ ... }: {
  programs.plasma.kwin = {
    virtualDesktops = {
      number = 4;
      rows = 2;
    };
    effects = {
      dimAdminMode.enable = true;
    };
  };
}
