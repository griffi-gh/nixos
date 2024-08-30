{ pkgs, vscode-extensions, ... }: let
  projectsFolder = "~/projects";
in {
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

      # TOML
      tamasfe.even-better-toml

      # Debugging:
      vadimcn.vscode-lldb
      seaql.firedbg-rust

      # Copilot:
      github.copilot
      github.copilot-chat

      # Generic:
      gruntfuggly.todo-tree
      shardulm94.trailing-spaces
      alefragnani.project-manager

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

      # Editing:
      "editor.linkedEditing" = true;

      # Git:
      "git.openRepositoryInParentFolders" = "never";
      "git.enableSmartCommit" = true;
      "git.confirmSync" = false;

      # Disable Telemetry and some Online Features:
      "telemetry.telemetryLevel" = "off";
      "workbench.enableExperiments" = false;
      "workbench.settings.enableNaturalLanguageSearch" = false;

      # Misc.:
      "extensions.autoUpdate" = false;

      # ====== EXTENSION SETTINGS ======

      # Vsicons
      "vsicons.dontShowNewVersionMessage" = true;

      # GitLens:
      "gitlens.telemetry.enabled" = false;

      # FireDbg:
      "firedbg.telemetry" = false;
      "firedbg.showWelcome" = false;

      # Project Manager:
      "projectManager.projectsLocation" = projectsFolder;
      # "projectManager.any.baseFolders" = [ projectsFolder ];
      "projectManager.git.baseFolders" = [ projectsFolder ];
      "projectManager.removeCurrentProjectFromList" = false;
      "projectManager.ignoreProjectsWithinProjects" = true;
    };
  };

  home.packages = with pkgs; [
    vscode-runner
  ];
}
