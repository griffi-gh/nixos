{ vscode-extensions, ... }: {
  programs.vscode = {
    extensions = with vscode-extensions.vscode-marketplace; [
      rust-lang.rust-analyzer # (nixpkgs is outdated)
      seaql.firedbg-rust
      slint.slint # (for Slint UI)
    ];
    userSettings = {
      # Rust-analyzer:
      "rust-analyzer.check.command" = "clippy";
      "rust-analyzer.diagnostics.experimental.enable" = true;
      # "rust-analyzer.interpret.tests" = true; # (Experimental)
      # "rust-analyzer.hover.actions.references.enable" = true;

      # FireDbg:
      "firedbg.telemetry" = false;
      "firedbg.showWelcome" = false;
    };
  };
}