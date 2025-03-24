{ ... }: {
  programs.zed-editor = {
    enable = true;
    installRemoteServer = true;
    extensions = [
      "catppuccin"
      "catppuccin-blur"
      "catppuccin-blur-plus"
      "catppuccin-icons"
      "csharp"
      "dart"
      "discord-presence"
      "dockerfile"
      "git-firefly"
      "html"
      "lua"
      "make"
      "nix"
      "qml"
      "scss"
      "sql"
      "svelte"
      "toml"
      "xml"
      "zed-legacy-themes"
      "zig"
    ];
    userSettings = {
      # Font/size
      ui_font_size = 16;
      buffer_font_size = 16;

      # Theme/icons
      theme = {
        mode = "system";
        light = "Catppuccin Latte";
        dark = "Catppuccin Mocha";
      };

      icon_theme = "Catppuccin Mocha";

      # LSP options
      lsp = {
        rust-analyzer = {
          initialization_options = {
            check = {
              # Use clippy as the cargo check command
              command = "clippy";
            };
            diagnostics = {
              experimental = {
                enable = false;
              };
            };
            # TODO remove this
            # binary = {
            #   ignore_system_version = true;
            # };
          };
        };
      };

      # AI stuff
      assistant = {
        default_model = {
          provider = "zed.dev";
          model = "claude-3-7-sonnet-latest";
        };
        version = "2";
      };

      features = {
        edit_prediction_provider = "zed"; # "copilot"
      };

      # Disable telemetry and auto-update
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      auto_update = false;

      # only use LSP, not Prettier
      # formatter = "language_server";
      # prettier = {
      #   allowed = false;
      # };

      # Enable inlay hints
      inlay_hints = {
        enabled = true;
        show_background = true;
      };

      # Language-specific settings
      languages = {
        Nix = {
          formatter = {
            external = {
              command = "nixfmt";
              arguments = ["--quiet" "--"];
            };
          };
        };
        Rust = {
          format_on_save = "on";
          formatter = {
            external = {
              command = "rustfmt";
              arguments = ["--edition=2024" "--emit=stdout"];
            };
          };
        };
      };
    };
  };
}