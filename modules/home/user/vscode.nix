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

      # Debugging:
      vadimcn.vscode-lldb
      seaql.firedbg-rust

      # Copilot:
      github.copilot
      github.copilot-chat

      # Generic:
      gruntfuggly.todo-tree
      shardulm94.trailing-spaces

      # Themes/Icons/etc.:
      github.github-vscode-theme
      vscode-icons-team.vscode-icons

      # Remote
      ms-vscode.remote-explorer
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
    ];
    userSettings = {
      # UI:
      "workbench.startupEditor" = "none";
      "workbench.colorTheme" = "GitHub Dark Default";
      "workbench.iconTheme" = "vscode-icons";
      "window.titleBarStyle" = "custom";
      "window.dialogStyle" = "custom";

      # Git:
      "git.openRepositoryInParentFolders" = "never";

      # Editing:
      "editor.linkedEditing" = true;

      # Telemetry:
      "telemetry.telemetryLevel" = "off";
      "workbench.enableExperiments" = false;

      # Misc.:
      "extensions.autoUpdate" = false;
      "workbench.settings.enableNaturalLanguageSearch" = false;

      # ====== EXTENSION SETTINGS ======

      # Vsicons
      "vsicons.dontShowNewVersionMessage" = true;

      # GitLens:
      "gitlens.telemetry.enabled" = false;

      # FireDbg:
      "firedbg.telemetry" = false;
      "firedbg.showWelcome" = false;
    };
  };

  home.packages = with pkgs; [
    vscode-runner
  ];
}
