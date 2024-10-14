{ pkgs, vscode-extensions, ... }: {
  programs.vscode = {
    extensions =
      let from-nixpkgs = pkgs.vscode-extensions; in
      with vscode-extensions.vscode-marketplace;
    [
      ms-vscode.cmake-tools
      from-nixpkgs.ms-vscode.cpptools
      llvm-vs-code-extensions.vscode-clangd
    ];
    userSettings = {
      "C_Cpp.intelliSenseEngine" = "disabled"; # Use clangd's intellisense engine
    };
  };
}
