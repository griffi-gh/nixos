{ ... }:
{
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
      "neocmake"

      # mcp servers
      "postgres-context-server"
      "mcp-server-sequential-thinking"
    ];

    userSettings = {
      auto_update = false;

      buffer_font_size = 15.5;
      buffer_line_height.custom = 1.4;
      ui_font_size = 16;

      theme = {
        dark = "Catppuccin Mocha";
        light = "Catppuccin Latte";
        mode = "system";
      };
      icon_theme = "Catppuccin Mocha";

      inlay_hints = {
        enabled = true;
        show_background = true;
        toggle_on_modifiers_press = {
          alt = true;
          control = true;
        };
      };

      languages = {
        Nix = {
          format_on_save = "on";
          formatter = {
            external = {
              command = "nixfmt";
              arguments = [
                "--quiet"
                "--"
              ];
            };
          };
        };
        Rust = {
          format_on_save = "on";
          formatter = {
            external = {
              command = "rustfmt";
              arguments = [
                "--edition=2024"
                "--emit=stdout"
              ];
            };
          };
        };
      };

      lsp = {
        rust-analyzer = {
          initialization_options = {
            check = {
              command = "clippy";
            };
            diagnostics = {
              experimental = {
                enable = false;
              };
            };
          };
        };

        omnisharp = {
          initialization_options = {
            RoslynExtensionsOptions = {
              inlayHintsOptions = {
                enableForParameters = true;
                enableForTypes = true;
                forImplicitObjectCreation = true;
                forImplicitVariableTypes = true;
                forIndexerParameters = true;
                forLambdaParameterTypes = true;
                forLiteralParameters = true;
                forObjectCreationParameters = true;
                forOtherParameters = true;
                suppressForParametersThatDifferOnlyBySuffix = true;
                suppressForParametersThatMatchArgumentName = true;
                suppressForParametersThatMatchMethodIntent = true;
              };
            };
          };
        };
      };

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      agent = {
        inline_assistant_model = {
          provider = "copilot_chat";
          model = "claude-sonnet-4";
        };
        default_model = {
          provider = "copilot_chat";
          model = "claude-sonnet-4";
        };
      };
      features = {
        edit_prediction_provider = "copilot";
      };
    };
  };
}
