{ pkgs, ... }: {
  home = {
    stateVersion = "24.11";
    username = "user";
    homeDirectory = "/home/user";
    packages = with pkgs; [
      # CLI tools:
      htop
      tree
      pciutils
      glxinfo
      vulkan-tools          # vulkan-tools (for e.g. vulkaninfo)
      lshw-gui              # (provides both lshw command and the gui :p)

      # Software:
      thunderbird           # Thunderbird
      libreoffice-qt6-fresh # LibreOffice
      blender               # Blender
      # TODO fix galaxy-buds-client somehow (borked and outdated)
      galaxy-buds-client    # GalaxyBudsClient (unofficial)

      # Games:
      principia             # Principia
      the-powder-toy        # The Powder Toy
      prismlauncher         # Minecraft
    ];
  };

  programs = {
    home-manager.enable = true;
  };

  imports = [
    ../../../modules/home.nix
  ];
}
