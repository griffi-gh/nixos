{ pkgs, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = "griffi-gh";
    userEmail = "prasol258@gmail.com";
    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
      core.editor = "nano";
      credential = {
        credentialStore = "secretservice";
        credential.helper = "${pkgs.gitFull}/bin/git-credential-libsecret";
      };
    };
  };
}
