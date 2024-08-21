{ pkgs, vscode-extensions, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;
    extensions = with vscode-extensions.open-vsx; [
      rust-lang.rust-analyzer
    ];
  };
}
