{ vscode-extensions, ... }: {
  programs.vscode = {
    extensions = with vscode-extensions.vscode-marketplace; [
      # bash
      mads-hartmann.bash-ide-vscode
      rogalmic.bash-debug

      # fish
      bmalehorn.vscode-fish

      # nushell
      thenuprojectcontributors.vscode-nushell-lang
    ];
    userSettings = {

    };
  };
}