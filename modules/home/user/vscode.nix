{ pkgs, vscode-extensions, ... }: let
  projectsFolder = "~/projects";
in {
  imports = [
    ./vscode/vs-nix.nix
    ./vscode/vs-cpp.nix
    ./vscode/vs-csharp.nix
    ./vscode/vs-zig.nix
    ./vscode/vs-flutter.nix
    # ./vscode/vs-tizen.nix
  ];
  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;
    extensions =
      let from-nixpkgs = pkgs.vscode-extensions;
          from-openvsx = vscode-extensions.open-vsx; in
      with vscode-extensions.vscode-marketplace;
    [
      # Git
      eamodio.gitlens

      # Markdown
      bierner.github-markdown-preview
      bierner.markdown-preview-github-styles
      bierner.markdown-emoji
      bierner.markdown-checkbox
      bierner.markdown-yaml-preamble
      bierner.markdown-footnotes
      bierner.markdown-mermaid

      # Rust
      rust-lang.rust-analyzer # (nixpkgs is outdated)


      # JS/TS
      dbaeumer.vscode-eslint
      ms-vscode.vscode-typescript-next
      christian-kohler.npm-intellisense

      # Nushell
      thenuprojectcontributors.vscode-nushell-lang

      # TOML
      tamasfe.even-better-toml

      # RedHat LSPs for xml/yaml:
      redhat.vscode-xml
      redhat.vscode-yaml

      # Debugging:
      from-nixpkgs.vadimcn.vscode-lldb
      seaql.firedbg-rust

      # Webdev/Browser Support/Web server:
      firefox-devtools.vscode-firefox-debug
      ritwickdey.liveserver

      # Copilot:
      from-nixpkgs.github.copilot
      from-nixpkgs.github.copilot-chat

      # Generic/Editor:
      gruntfuggly.todo-tree
      aaron-bond.better-comments
      shardulm94.trailing-spaces
      from-openvsx.drmerfy.overtype
      alefragnani.project-manager
      fill-labs.dependi # Rust and other lang dependency info
      esbenp.prettier-vscode # Prettier formatter
      christian-kohler.path-intellisense # Path autocompletion
      wraith13.zoombar-vscode # Zoom bar

      # Misc. config file/language support
      editorconfig.editorconfig # .editorconfig
      logerfo.sln-support       # .sln
      codezombiech.gitignore    # .gitignore

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

      # Misc.
      ms-vscode.hexeditor    # Built-in hex editor
      anweber.vscode-httpyac # HTTPyac client
      arcanis.vscode-zipfs   # ZIPFS
    ];
    userSettings = {
      # UI:
      "workbench.startupEditor" = "none";
      "workbench.colorTheme" = "GitHub Dark Default";
      "workbench.iconTheme" = "vscode-icons";
      "window.titleBarStyle" = "custom";
      "window.dialogStyle" = "custom";

      # Editor:
      "editor.linkedEditing" = true;
      "editor.cursorSmoothCaretAnimation" = "explicit";

      # Terminal:
      "terminal.integrated.fontFamily" = "FiraCode Nerd Font Mono";

      # Search:
      "search.exclude" = {
        "**/.direnv" = true;
      };

      # Enable smooth scrolling:
      "editor.smoothScrolling" = true;
      "terminal.integrated.smoothScrolling" = true;
      "workbench.list.smoothScrolling" = true;

      # Git:
      "git.openRepositoryInParentFolders" = "never";
      "git.enableSmartCommit" = true;
      "git.confirmSync" = false;

      # Disable Telemetry and some Online Features:
      "telemetry.telemetryLevel" = "off";
      "workbench.enableExperiments" = false;
      "workbench.settings.enableNaturalLanguageSearch" = false;

      # Misc.:
      "extensions.autoUpdate" = false; # isn't compatible with mutableExtensionsDir = false
      "update.showReleaseNotes" = false; # disable release notes after every update

      # ====== EXTENSION SETTINGS ======

      # Vsicons
      "vsicons.dontShowNewVersionMessage" = true;

      # Trailing Spaces:
      "trailing-spaces.trimOnSave" = true;
      "trailing-spaces.deleteModifiedLinesOnly" = true;

      # GitLens:
      "gitlens.telemetry.enabled" = false;

      # Project Manager:
      "projectManager.projectsLocation" = projectsFolder;
      "projectManager.git.baseFolders" = [ projectsFolder ];
      "projectManager.removeCurrentProjectFromList" = false;
      "projectManager.ignoreProjectsWithinProjects" = true;

      # Live Server
      "liveServer.settings.donotShowInfoMsg" = true;
      "liveServer.settings.useLocalIp" = false;
      "liveServer.settings.donotVerifyTags" = true;

      # FireDbg:
      "firedbg.telemetry" = false;
      "firedbg.showWelcome" = false;

      # LLDB
      "lldb.suppressUpdateNotifications" = true;
    };
  };

  home.packages = with pkgs; [
    vscode-runner
  ];
}
