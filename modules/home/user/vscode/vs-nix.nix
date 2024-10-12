{ pkgs, vscode-extensions, ... }: {
  programs.vscode = {
    extensions =
      with vscode-extensions.vscode-marketplace;
    [
      jnoortheen.nix-ide
      mkhl.direnv
    ];
    userSettings = {
      # Nix IDE
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.nil}/bin/nil";

      # direnv:
      "direnv.restart.automatic" = true;
    };
  };
}
