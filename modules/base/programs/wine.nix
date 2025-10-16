{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wineWowPackages.staging
    (writeShellScriptBin "wine64" ''
      #!/usr/bin/env bash
      exec "${wineWowPackages.staging}/bin/wine" "$@"
    '')
  ];
}
