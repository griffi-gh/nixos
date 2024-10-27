{ vscode-extensions, ... }: {
  programs.vscode = {
    extensions =
      with vscode-extensions.vscode-marketplace;
    [
      dart-code.dart-code
      dart-code.flutter
    ];
    userSettings = {
      # "dart.showDebuggerNumbersAsHex" = true;
    };
  };
}
