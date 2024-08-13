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
      vulkan-tools # vulkan-tools (for e.g. vulkaninfo)
      lshw-gui     # (provides both lshw command and the gui :p)

      # etc. tools
      mangohud

      # Software:
      libreoffice-qt6-fresh # LibreOffice
      inkscape              # Inkscape
      blender               # Blender
      transmission_4-qt6    # Transmission (Qt)
      bitwarden-desktop     # BitWarden Desktop client

      # TODO fix galaxy-buds-client somehow (borked and outdated)
      # galaxy-buds-client  # GalaxyBudsClient (unofficial)

      # Games:
      principia      # Principia
      the-powder-toy # The Powder Toy
      prismlauncher  # Minecraft
      # osu-lazer-bin  # Osu (lazer)

      # Emulators:
      ryujinx        # Ryujinx (Switch)
      cemu           # Cemu (Wii U)
      # sameboy      # SameBoy (GB/GBC)
      mgba           # mGBA (GB/GBC/GBA)
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
