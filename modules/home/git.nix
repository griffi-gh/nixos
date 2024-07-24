{ ... }: {
  programs.git = {
    enable = true;
    userName = "griffi-gh";
    userEmail = "prasol258@gmail.com";
    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "master";
      credential.helper = "store";
    };
  };
}
