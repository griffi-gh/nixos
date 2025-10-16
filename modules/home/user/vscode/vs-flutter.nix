{ pkgs, ... }:
{
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-marketplace; [
      dart-code.dart-code
      dart-code.flutter
    ];
    userSettings = {
      # "dart.showDebuggerNumbersAsHex" = true;
    };
  };
}
