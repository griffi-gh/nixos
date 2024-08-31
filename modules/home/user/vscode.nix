{ pkgs, vscode-extensions, ... }: let
  projectsFolder = "~/projects";
in {
  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;
    extensions =
      let from-nixpkgs = pkgs.vscode-extensions; in
      with vscode-extensions.vscode-marketplace;
    [
      # Git
      eamodio.gitlens

      # Nix/NixOS
      mkhl.direnv
      jnoortheen.nix-ide

      # Rust
      rust-lang.rust-analyzer # nixpkgs is outdated

      # TOML
      tamasfe.even-better-toml

      # C#/dotnet
      from-nixpkgs.ms-dotnettools.csdevkit
      from-nixpkgs.ms-dotnettools.csharp
      from-nixpkgs.ms-dotnettools.vscode-dotnet-runtime

      # EditorConfig support
      editorconfig.editorconfig

      # Debugging:
      from-nixpkgs.vadimcn.vscode-lldb
      seaql.firedbg-rust

      # Copilot:
      from-nixpkgs.github.copilot
      from-nixpkgs.github.copilot-chat

      # Generic:
      gruntfuggly.todo-tree
      shardulm94.trailing-spaces
      alefragnani.project-manager

      # Themes/Icons/etc.:
      github.github-vscode-theme
      vscode-icons-team.vscode-icons

      # Remote
      ms-vscode.remote-explorer
      from-nixpkgs.ms-vscode-remote.remote-ssh
      from-nixpkgs.ms-vscode-remote.remote-ssh-edit

      # Intellicode
      from-nixpkgs.visualstudioexptteam.vscodeintellicode
      visualstudioexptteam.vscodeintellicode-completions
      from-nixpkgs.visualstudioexptteam.intellicode-api-usage-examples
      from-nixpkgs.ms-dotnettools.vscodeintellicode-csharp # IntelliCode support for C# DevKit
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

      # direnv:
      "direnv.restart.automatic" = true;

      # Vsicons
      "vsicons.dontShowNewVersionMessage" = true;

      # GitLens:
      "gitlens.telemetry.enabled" = false;

      # FireDbg:
      "firedbg.telemetry" = false;
      "firedbg.showWelcome" = false;

      # Project Manager:
      "projectManager.projectsLocation" = projectsFolder;
      "projectManager.git.baseFolders" = [ projectsFolder ];
      "projectManager.removeCurrentProjectFromList" = false;
      "projectManager.ignoreProjectsWithinProjects" = true;

      # C#:
      "dotnetAcquisitionExtension.enableTelemetry" = false;
      "csharp.preview.improvedLaunchExperience" = true;
      "nuget.includePrereleasePackageVersions" = true;
      "csharp.inlayHints.enableInlayHintsForImplicitObjectCreation" = true;
      "csharp.inlayHints.enableInlayHintsForImplicitVariableTypes" = true;
      "csharp.inlayHints.enableInlayHintsForLambdaParameterTypes" = true;
      "csharp.inlayHints.enableInlayHintsForTypes" = true;
      "dotnet.inlayHints.enableInlayHintsForIndexerParameters" = true;
      "dotnet.inlayHints.enableInlayHintsForLiteralParameters" = true;
      "dotnet.inlayHints.enableInlayHintsForObjectCreationParameters" = true;
      "dotnet.inlayHints.enableInlayHintsForOtherParameters" = true;
      "dotnet.inlayHints.enableInlayHintsForParameters" = true;
      "dotnet.inlayHints.suppressInlayHintsForParametersThatDifferOnlyBySuffix" = true;
      "dotnet.inlayHints.suppressInlayHintsForParametersThatMatchArgumentName" = true;
      "dotnet.inlayHints.suppressInlayHintsForParametersThatMatchMethodIntent" = true;
    };
  };

  home.packages = with pkgs; [
    vscode-runner
  ];
}
