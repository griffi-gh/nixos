{ pkgs, ... }: {
  programs.vscode = {
    extensions =
      let from-nixpkgs = pkgs.vscode-extensions; in
      with pkgs.vscode-marketplace;
    [
      # Cmake
      twxs.cmake
      ms-vscode.cmake-tools

      # Ninja syntax highlighting
      surajbarkale.ninja

      # C/C++ support
      from-nixpkgs.ms-vscode.cpptools
      llvm-vs-code-extensions.vscode-clangd
    ];
    userSettings = {
      "C_Cpp.intelliSenseEngine" = "disabled"; # Use clangd's intellisense engine
      # "cmake.options.statusBarVisibility" = "compact";
      "cmake.showOptionsMovedNotification" = false;
      "cmake.options.statusBarVisibility" = "icon";
      "cmake.pinnedCommands" = [
        "workbench.action.tasks.configureTaskRunner"
        "workbench.action.tasks.runTask"
      ];
    };
  };
}
