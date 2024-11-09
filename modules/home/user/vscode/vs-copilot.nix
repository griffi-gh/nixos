{ pkgs, ...}: {
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      github.copilot
      github.copilot-chat
    ];
    userSettings = {
      "chat.commandCenter.enabled" = false;
    };
  };
}
