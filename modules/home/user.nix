{ pkgs, pkgs-stable, ... }: {
  home = {
    stateVersion = "24.11";
    username = "user";
    homeDirectory = "/home/user";
    packages = with pkgs; [
      # CLI tools:
      tree
      pciutils
      glxinfo
      inxi
      vulkan-tools # vulkan-tools (for e.g. vulkaninfo)
      lshw-gui     # (provides both lshw command and the gui :p)
      android-tools

      # etc. tools
      xorg.xeyes
      mangohud
      steamtinkerlaunch

      # Software:
      snapshot              # Gnome's Camera App
      haruna                # KDE's Video player
      libreoffice-qt6-fresh # LibreOffice
      inkscape              # Inkscape
      blender-hip           # Blender (with HIP support)
      transmission_4-qt6    # Transmission (Qt)
      bitwarden-desktop     # BitWarden Desktop client
      vesktop               # Discord (vesktop/vencord)
      telegram-desktop      # Telegram
      nheko                 # Nheko (matrix)
      kdePackages.krdc      # KRDC
      okteta                # Okteta (hex editor)
      imhex                 # imhex  (hex editor)


      # Dev. Stuff/Code editors
      zed-editor            # Zed Editor (gui)
      helix                 # Helix Editor (cli)
      renderdoc             # RenderDoc (graphics debugger)

      # Device drivers etc
      # TODO fix galaxy-buds-client somehow (borked and outdated)
      # galaxy-buds-client  # GalaxyBudsClient (unofficial)

      # Games:
      principia      # Principia
      the-powder-toy # The Powder Toy
      osu-lazer-bin  # Osu (lazer)
      prismlauncher  # Minecraft (Prism Launcher)
      # everest-mons   # mons (Celeste/Everest mod loader installer)

      # Emulators:
      ryujinx        # Ryujinx (Switch)
      pkgs-stable.cemu # Cemu (Wii U) (borked package)
      mgba           # mGBA (GB/GBC/GBA)
      # sameboy      # SameBoy (GB/GBC)
      # vita3k is not in nixpkgs :<
    ];
  };

  imports = [
    ./user/shells.nix
    ./user/git.nix
    ./user/plasma.nix
    ./user/gtk.nix
    ./user/cursor.nix
    ./user/firefox.nix
    ./user/accounts.nix
    ./user/thunderbird.nix
    ./user/vscode-server.nix
  ];
}
