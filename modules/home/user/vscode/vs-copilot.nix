{ pkgs, ...}: {
  programs.vscode.profiles.default = {
    extensions =
      let from-nixpkgs = pkgs.vscode-extensions; in
      with pkgs.vscode-marketplace;
    [
      from-nixpkgs.github.copilot
      from-nixpkgs.github.copilot-chat
      ms-vscode.vscode-speech
    ];
    userSettings = {
      # "chat.commandCenter.enabled" = false;
      "github.copilot.nextEditSuggestions.enabled" = true;
    };
  };
}
