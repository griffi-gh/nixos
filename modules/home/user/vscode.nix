{ pkgs, vscode-extensions, ... }: {
  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;
    extensions = with vscode-extensions.vscode-marketplace; [
      # Git
      eamodio.gitlens

      # Nix/NixOS
      mkhl.direnv
      jnoortheen.nix-ide

      # Rust
      rust-lang.rust-analyzer

      # Copilot:
      github.copilot
      github.copilot-chat

      # Generic:
      gruntfuggly.todo-tree
      shardulm94.trailing-spaces

      # Themes/Icons/etc.:
      github.github-vscode-theme
      vscode-icons-team.vscode-icons
    ];
    userSettings = {
      # UI:
      "workbench.startupEditor" = "none";
      "workbench.colorTheme" = "GitHub Dark Default";
      "window.titleBarStyle" = "custom";
      "window.dialogStyle" = "custom";

      # Editing:
      "editor.linkedEditing" = true;

      # Telemetry:
      "telemetry.telemetryLevel" = "off";
      "workbench.enableExperiments" = false;
      "gitlens.telemetry.enabled" = false;

      # Misc.:
      "extensions.autoUpdate" = false;
      "workbench.settings.enableNaturalLanguageSearch" = false;
    };
  };

  home.packages = with pkgs; [
    vscode-runner
  ];
}
