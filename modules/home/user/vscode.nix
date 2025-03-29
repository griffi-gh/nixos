{ pkgs, vscode-extensions, ... }: let
  projectsFolder = "~/projects";
in {
  imports = [
    ./vscode/vs-rust.nix
    ./vscode/vs-copilot.nix
    ./vscode/vs-nix.nix
    ./vscode/vs-cpp.nix
    ./vscode/vs-csharp.nix
    ./vscode/vs-zig.nix
    ./vscode/vs-flutter.nix
    ./vscode/vs-sh.nix
    ./vscode/vs-slint.nix
    ./vscode/vs-python.nix
    # ./vscode/vs-tizen.nix
  ];
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    # package = pkgs.vscodium;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions =
        let from-nixpkgs = pkgs.vscode-extensions;
            from-openvsx = vscode-extensions.open-vsx; in
        with pkgs.vscode-marketplace;
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

        # JS/TS
        dbaeumer.vscode-eslint
        ms-vscode.vscode-typescript-next
        christian-kohler.npm-intellisense

        # TOML
        tamasfe.even-better-toml

        # RedHat LSPs for xml/yaml:
        redhat.vscode-xml
        redhat.vscode-yaml

        # Debugging:
        from-nixpkgs.vadimcn.vscode-lldb

        # Webdev/Browser Support/Web server:
        firefox-devtools.vscode-firefox-debug
        ritwickdey.liveserver

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
        kisstkondoros.vscode-gutter-preview # image preview

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
        # "workbench.colorTheme" = "GitHub Dark Default";
        "workbench.iconTheme" = "vscode-icons";
        "window.titleBarStyle" = "custom";
        "window.dialogStyle" = "custom";

        # Editor:
        "editor.tabSize" = 2;
        "editor.linkedEditing" = true;
        "editor.cursorSmoothCaretAnimation" = "explicit";
        "editor.inlayHints.enabled" = "onUnlessPressed";

        # File Explorer:
        "explorer.confirmDelete" = false; # disable confirm
        "explorer.confirmDragAndDrop" = false;
        "explorer.confirmPasteNative" = false;

        # Terminal:
        "terminal.integrated.fontFamily" = "FiraCode Nerd Font Mono";
        "terminal.integrated.shellIntegration.enabled" = true;
        "python.terminal.shellIntegration.enabled" = true;
        "terminal.integrated.shellIntegration.environmentReporting" = true;
        "terminal.integrated.gpuAcceleration" = "off"; # fw13: terminal causes GPU hangs?
        "terminal.integrated.suggest.enabled" = true; # experimental

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
        "git.terminalAuthentication" = false; # true;
        "github.gitAuthentication" = false; #true;

        # Disable Telemetry and some Online Features:
        "telemetry.telemetryLevel" = "off";
        "workbench.enableExperiments" = false;
        "workbench.settings.enableNaturalLanguageSearch" = false;

        # Misc.:
        "extensions.autoUpdate" = false; # isn't compatible with mutableExtensionsDir = false
        "update.showReleaseNotes" = false; # disable release notes after every update

        # Diff Editor:
        # "diffEditor.maxComputationTime" = 0; # (0 = unlimited)
        "diffEditor.ignoreTrimWhitespace" = false; # show whitespace changes

        # ====== EXTENSION SETTINGS ======

        # Vsicons
        "vsicons.dontShowNewVersionMessage" = true;
        "vsicons.presets.foldersAllDefaultIcon" = true; # No custom folder icons

        # Trailing Spaces:
        "trailing-spaces.trimOnSave" = true;
        "trailing-spaces.deleteModifiedLinesOnly" = true;

        # GitLens:
        "gitlens.telemetry.enabled" = false;
        "gitlens.views.scm.grouped.views" = {
          "commits" = false;
          "branches" = true;
          "remotes" = true;
          "stashes" = true;
          "tags" = true;
          "worktrees" = true;
          "contributors" = true;
          "repositories" = false;
          "searchAndCompare" = false;
          "launchpad" = false;
        };

        # Project Manager:
        "projectManager.projectsLocation" = projectsFolder;
        "projectManager.git.baseFolders" = [ projectsFolder ];
        "projectManager.removeCurrentProjectFromList" = false;
        "projectManager.ignoreProjectsWithinProjects" = true;

        # Live Server
        "liveServer.settings.donotShowInfoMsg" = true;
        "liveServer.settings.useLocalIp" = false;
        "liveServer.settings.donotVerifyTags" = true;

        # LLDB
        "lldb.suppressUpdateNotifications" = true;
      };
    };
  };

  home.packages = with pkgs; [
    vscode-runner
  ];
}
