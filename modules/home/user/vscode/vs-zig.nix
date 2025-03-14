{ pkgs, ... }: {
  programs.vscode = {
    extensions =
      with pkgs.vscode-marketplace;
    [
      ziglang.vscode-zig
    ];
    userSettings = {
      # Zig
      # "zig.initialSetupDone" = true;
      "zig.path" = "zig";
      "zig.checkForUpdate" = false;
      "zig.zls.enabled" = "on";
      "zig.zls.path" = "zls";
      "zig.zls.checkForUpdate" = false;
      "zig.zls.enableBuildOnSave" = true;
      "zig.zls.inlayHintsHideRedundantParamNames" = true;
      "zig.zls.inlayHintsHideRedundantParamNamesLastToken" = true;
    };
  };
}
