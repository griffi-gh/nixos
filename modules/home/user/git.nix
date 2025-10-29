{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    lfs.enable = true;
    settings = {
      user.name = "griffi-gh";
      user.email = "prasol258@gmail.com";
      init.defaultBranch = "master";
      commit.verbose = true;
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "nano";
      diff.colorMoved = "default";
      rerere.enable = true; # https://git-scm.com/book/en/v2/Git-Tools-Rerere
      credential = {
        credentialStore = "secretservice";
        helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
      };
    };
    ignores = [
      ".directory"
      ".direnv"
      "*.kate-swp"
    ];
  };
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options.features = "decorations";
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = false;
    extensions = with pkgs; [
      gh-copilot
    ];
  };
}
