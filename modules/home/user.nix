{ pkgs, ... }: {
  home = {
    stateVersion = "24.11";
    username = "user";
    homeDirectory = "/home/user";
    packages = with pkgs; [
      # fix for bash :p
      bashInteractive

      # CLI tools:
      tree
      ripgrep
      ripgrep-all
      pciutils
      glxinfo
      libva-utils
      inxi
      nmap
      dig
      pwgen
      compsize     # btrfs-compsize (btrfs compression ratio)
      trash-cli    # trash-cli (trash command)
      vulkan-tools # vulkan-tools (for e.g. vulkaninfo)
      lshw-gui     # (provides both lshw command and the gui :p)
      android-tools # adb, fastboot etc.
      osslsigncode # verify code signatures
      yt-dlp       # yt-dlp (youtube-dl fork)
      btop         # htop but even more autistic :3
      ffmpeg       # ffmpeg

      # file stuff:
      vaults       # Vaults (gocryptfs GTK GUI)
      gocryptfs    # gocryptfs
      rsync        # rsync/rclone
      rclone

      # net:
      # trayscale   # Trayscale (GTK Tailscale gui)
      ktailctl      # KTailCtl  (Qt Tailscale gui)

      # etc.
      xorg.xeyes
      scrcpy        # scrcpy (android screen mirroring)
      gearlever     # manage AppImages

      # KDE stuff:
      haruna                # KDE's Video player
      kdePackages.filelight # Filelight (disk usage analyzer)
      kdePackages.krdc      # KRDC (remote desktop client)
      kdePackages.kcolorchooser # KColorChooser (color picker)

      # Software:
      snapshot              # Gnome's Camera App
      libreoffice-qt6-fresh # LibreOffice
      transmission_4-qt6    # Transmission (Qt)
      bitwarden-desktop     # BitWarden Desktop client
      okteta                # Okteta (hex editor)
      imhex                 # imhex  (hex editor)
      apostrophe            # GTK Markdown editor
      obs-studio            # OBS Studio (streaming/recording tool)

      # Photo/Video/Graphics stuff:
      inkscape              # Inkscape (vector graphics editor)
      blender-hip           # Blender (with HIP support)
      gimp                  # GIMP  (image editor)
      krita                 # Krita (image editor)
      kdenlive              # Kdenlive (video editor)
      audacity              # Audacity (audio editor)

      # Social/Communication stuff:
      vesktop               # Discord (vesktop/vencord)
      telegram-desktop      # Telegram
      nheko                 # Nheko (matrix)
      zulip                 # Zulip desktop chat client
      teams-for-linux       # Microsoft Teams (unofficial open-source electron wrapper)

      # Dev. Stuff/Code editors
      zed-editor            # Zed Editor (gui)
      helix                 # Helix Editor (cli)
      renderdoc             # RenderDoc (graphics debugger)
      rgp                   # Radeon GPU Profiler (compatible with RenderDoc)
      love                  # Love2D (lua game framework)

      # Device drivers etc
      # TODO fix galaxy-buds-client somehow (borked and outdated)
      # galaxy-buds-client  # GalaxyBudsClient (unofficial)

      # Games:
      principia      # Principia
      the-powder-toy # The Powder Toyelopers: PCGamingWiki staff m
      osu-lazer-bin  # Osu (lazer)
      prismlauncher  # Minecraft (Prism Launcher)
      # everest-mons # mons (Celeste/Everest mod loader installer)

      # Heroic Legendary/GOG/Amazon
      heroic
      legendary-gl # legendary (epic games)
      gogdl        # gogdl (GOG downloader)
      nile         # Nile (Amazon Games)

      # Gaming tools:
      ludusavi       # Ludusavi (game save manager)
      steamtinkerlaunch # SteamTinkerLaunch (Steam launcher)
      mangohud       # MangoHud (fps overlay)

      # Emulators:
      ryujinx        # Ryujinx (Switch)
      cemu           # Cemu (Wii U) (borked package)
      mgba           # mGBA (GB/GBC/GBA)
      melonDS        # MelonDS (DS)
      # vita3k is not in nixpkgs :<
    ];
  };

  imports = [
    ./user/shells.nix
    ./user/git.nix
    ./user/plasma.nix
    ./user/gtk.nix
    ./user/flatpak.nix
    ./user/cursor.nix
    ./user/firefox.nix
    ./user/accounts.nix
    ./user/thunderbird.nix
    ./user/vscode.nix
    ./user/vscode-server.nix
  ];
}
