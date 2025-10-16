{ pkgs, ... }:
{
  programs.vscode.profiles.default = {
    extensions =
      # let from-nixpkgs = pkgs.vscode-extensions; in
      with pkgs.vscode-marketplace; [
        ms-python.python
        ms-python.vscode-pylance
        ms-python.debugpy
      ];
  };
}
