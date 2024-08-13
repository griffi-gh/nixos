{ pkgs, ... }: {
  programs = {
    home-manager.enable = true;
  };

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
      
      # etc. tools
      xorg.xeyes
      mangohud

      # Software:
      libreoffice-qt6-fresh # LibreOffice
      inkscape              # Inkscape
      blender-hip           # Blender (with HIP support)
      transmission_4-qt6    # Transmission (Qt)
      bitwarden-desktop     # BitWarden Desktop client
      vesktop               # Discord (vesktop/vencord)
      telegram-desktop      # Telegram

      # Dev. Stuff/Code editors
      zed-editor            # Zed Editor (gui)
      helix                 # Helix Editor (cli)

      # Device drivers etc
      # TODO fix galaxy-buds-client somehow (borked and outdated)
      # galaxy-buds-client  # GalaxyBudsClient (unofficial)

      # Games:
      principia      # Principia
      the-powder-toy # The Powder Toy
      prismlauncher  # Minecraft (Prism Launcher)
      # osu-lazer-bin  # Osu (lazer)
      # everest-mons   # mons (Celeste/Everest mod loader installer)

      # Emulators:
      ryujinx        # Ryujinx (Switch)
      cemu           # Cemu (Wii U)
      mgba           # mGBA (GB/GBC/GBA)
      # sameboy      # SameBoy (GB/GBC)
      # vita3k is not in nixpkgs :<
    ];
  };

  # services.kdeconnect.enable = true;

  imports = [
    ./home/shell.nix
    ./home/git.nix
    ./home/plasma.nix
    ./home/firefox.nix
    ./home/thunderbird.nix
  ];
}
