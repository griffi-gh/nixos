{
  lib,
  root,
  pkgs,
  ...
}:
let
  wallpaper = "${root}/assets/wallpapers/abstract-swirls.jpg";

  accentColor = "245,194,231";

  catppuccin-flavour = "mocha";
  catppuccin-accent = "pink";

  catppuccin-flavour-uppercased = lib.concatStrings [
    (lib.toUpper (lib.substring 0 1 catppuccin-flavour))
    (lib.substring 1 (-1) catppuccin-flavour)
  ];
  catppuccin-accent-uppercased = lib.concatStrings [
    (lib.toUpper (lib.substring 0 1 catppuccin-accent))
    (lib.substring 1 (-1) catppuccin-accent)
  ];
in
{
  gtk =
    let
      # TODO: deprecated; use https://github.com/claymorwan/catppuccin instead.
      adw-catppuccin = pkgs.applyPatches {
        src = pkgs.fetchFromGitHub {
          owner = "claymorwan";
          repo = "adw-catppuccin";
          rev = "e2a3352bb3a1eac7306d397a9945108c878a4c58";
          hash = "sha256-wrqQTyHOaNgPsgxdGGOMY3oBzPPcjtUfqHELcgw8/gE=";
        };
        patches = [
          "${root}/assets/adw-catppuccin/mocha-pink.patch"
        ];
      };
      stylesheet = "${adw-catppuccin}/${catppuccin-flavour}/gtk.css";
      extraCss = ''
        @import 'colors.css';    /* breeze accents */
        @import '${stylesheet}'; /* adw-catppuccin */
      '';
      extraConfig = {
        gtk-enable-animations = true;
        gtk-application-prefer-dark-theme = true;
        gtk-button-images = 1;
        gtk-menu-images = 1;
        gtk-enable-event-sounds = 1;
        gtk-error-bell = 0;
        gtk-enable-input-feedback-sounds = 0;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-xft-rgba = "rgb";
        gtk-decoration-layout = "icon:minimize,maximize,close";
        gtk-modules = lib.concatStringsSep ":" [
          # for kde-gtk-config
          "colorreload-gtk-module"
          "window-decorations-gtk-module"
        ];
      };
      # headerbar .titlebutton.close:not(:hover),
      # headerbar .titlebutton.minimize:not(:hover),
      # headerbar .titlebutton.maximize:not(:hover) {
      #   background: none;
      # }

      # window.csd:not(.tiled):not(.maximized):not(.fullscreen) > decoration,
      # window.csd:not(.tiled):not(.maximized):not(.fullscreen) headerbar {
      #   border-radius: 6px 6px 0px 0px;
      # }
    in
    {
      enable = true;
      iconTheme.name = "breeze-dark";
      theme.name = "Breeze-Dark";
      # theme.name = "adw-gtk3-dark";
      gtk3 = { inherit extraCss extraConfig; };
      gtk4 = {
        inherit extraCss;
        extraConfig = extraConfig // {
          gtk-theme-name = "Adwaita";
        };
      };
    };
  # foce overwrite gtkrc
  # home.file.".gtkrc-2.0".force = pkgs.lib.mkForce true;

  programs.firefox.policies.ExtensionSettings = {
    "{0a2d1098-69a9-4e98-a62c-a861766ac24d}" =
      let
        addon_xpi = pkgs.fetchurl {
          url = "https://github.com/catppuccin/firefox/releases/download/old/catppuccin_${catppuccin-flavour}_${catppuccin-accent}.xpi";
          hash = "sha256-MPaGVZMjqdqbDA7dbiSl5qQ2ji+aKyftLJiISY5ShQI=";
        };
      in
      {
        install_url = "file://${addon_xpi}";
        installation_mode = "force_installed";
        updates_disabled = true;
      };
  };

  home.file.".thunderbird/default/extensions/{aee472cc-993b-522a-b6e8-c904c250a8d9}.xpi" = {
    source = pkgs.fetchurl {
      url = "https://github.com/catppuccin/thunderbird/raw/0289f3bd9566f9666682f66a3355155c0d0563fc/themes/${catppuccin-flavour}/${catppuccin-flavour}-${catppuccin-accent}.xpi";
      hash = "sha256-Fa49rVvFSTMV6Aujj2/UD7NePzjbNnP6xGr/Z02mOiA=";
    };
  };

  programs.plasma = {
    workspace = {
      # lookAndFeel = "org.kde.breezedark.desktop";
      colorScheme = "Catppuccin${catppuccin-flavour-uppercased}${catppuccin-accent-uppercased}";
      theme = "default";
      windowDecorations = {
        library = "org.kde.breeze";
        theme = "Breeze";
      };
      iconTheme = "breeze-dark";
      inherit wallpaper;
      splashScreen.theme = "Breeze";
      # splashScreen.theme = "Catppuccin-${catppuccin-flavour-uppercased}-${catppuccin-accent-uppercased}";
    };
    kscreenlocker.appearance = {
      inherit wallpaper;
    };
    configFile = {
      kdeglobals = {
        General = {
          # accent color
          AccentColor = accentColor;
          LastUsedCustomAccentColor = accentColor;
        };
      };
    };
  };

  home.packages = with pkgs; [
    adw-gtk3
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
    kdePackages.kde-gtk-config
    (catppuccin-kde.override {
      flavour = [ catppuccin-flavour ];
      accents = [ catppuccin-accent ];
      winDecStyles = [ "modern" ];
    })
    # (rlly like it, especially with colored borders...)
    # (but it causes Qt6 apps to be blurry on HiDPI displays for some reason)
    # kde-rounded-corners
  ];

  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-marketplace; [
      catppuccin.catppuccin-vsc
    ];
    userSettings = {
      "workbench.colorTheme" = "Catppuccin ${catppuccin-flavour-uppercased}";
    };
  };
}
