{ pkgs, vscode-extensions, ... }: {
  programs.vscode = {
    extensions =
      let from-nixpkgs = pkgs.vscode-extensions;
          from-openvsx = vscode-extensions.open-vsx; in
      with vscode-extensions.vscode-marketplace;
    [
      ziglang.vscode-zig
    ];
    userSettings = {
      # Zig
      "zig.initialSetupDone" = true;
      "zig.path" = "zig";
      "zig.checkForUpdate" = false;
      "zig.zls.path" = "zls";
      "zig.zls.checkForUpdate" = false;
      "zig.zls.enableBuildOnSave" = true;
      "zig.zls.inlayHintsHideRedundantParamNames" = true;
      "zig.zls.inlayHintsHideRedundantParamNamesLastToken" = true;
    };
  };
}
