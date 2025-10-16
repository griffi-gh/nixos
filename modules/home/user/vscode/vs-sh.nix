{ pkgs, ... }:
{
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-marketplace; [
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
