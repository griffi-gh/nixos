{ pkgs, ... }:
{
  services.vscode-server = {
    enable = true;
    nodejsPackage = pkgs.nodejs;
  };
}
