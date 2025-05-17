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
      "csv"
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
      "nu"
      "fish"
      "emmet"
      "jinja2"
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
              # Use clippy as the cargo check commandc
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
        # "roslyn": {
        #         "inlayHintsOptions": {
        #             "enable": true, // Or false to disable
        #             "maxLength": 20, // Adjust as needed
        #             "useParameterNames": true
        #         }
        #     }
        omnisharp = {
          # XXX: seems to not work :<
          initialization_options = {
            RoslynExtensionsOptions = {
              inlayHintsOptions = {
                enableForParameters = true;
                forLiteralParameters = true;
                forIndexerParameters = true;
                forObjectCreationParameters = true;
                forOtherParameters = true;
                suppressForParametersThatDifferOnlyBySuffix = true;
                suppressForParametersThatMatchMethodIntent = true;
                suppressForParametersThatMatchArgumentName = true;
                enableForTypes = true;
                forImplicitVariableTypes = true;
                forLambdaParameterTypes = true;
                forImplicitObjectCreation = true;
              };
            };
          };
        };
      };

      # AI stuff
      assistant = let
        claude = {
          provider = "zed.dev";
          model = "claude-3-7-sonnet-latest";
        };
      in {
        version = "2";
        default_model = claude;
        editor_model = claude;
      };

      features = {
        # edit_prediction_provider = "zed";
        edit_prediction_provider = "copilot";
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
        toggle_on_modifiers_press = {
          control = true;
          alt = true;
        };
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