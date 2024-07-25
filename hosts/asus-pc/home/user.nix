{ pkgs, ... }: {
  home = {
    stateVersion = "24.11";
    username = "user";
    homeDirectory = "/home/user";
    packages = with pkgs; [
      # CLI tools:
      htop
      tree
      glxinfo
      vulkan-tools          # vulkan-tools (for e.g. vulkaninfo)

      # Software:
      firefox               # Firefox
      thunderbird           # Thunderbird
      libreoffice-qt6-fresh # LibreOffice
      blender               # Blender
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
