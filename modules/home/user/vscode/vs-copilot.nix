{ pkgs, ...}: {
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-extensions; [
      github.copilot
      github.copilot-chat
    ];
    userSettings = {
      # "chat.commandCenter.enabled" = false;
      "github.copilot.nextEditSuggestions.enabled" = true;
    };
  };
}
