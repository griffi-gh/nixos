{ self, pkgs, pkgs-master, system, ... }: {
  home = {
    stateVersion = "24.11";
    username = "user";
    homeDirectory = "/home/user";
    packages = with pkgs; with self.packages."${system}"; [
      # fix for bash :p
      bashInteractive

      # (i only use it for tizen studio rn :p)
      distrobox

      # prefix manager
      bottles

      # CLI tools:
      tree
      ripgrep
      ripgrep-all # (conflicts with radeon gpu profiler)
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
      btop         # (system monitor) htop but even more autistic :3
      ffmpeg       # ffmpeg
      imagemagick  # ImageMagick (default version)
      http-server   # http-server (node.js)

      amdgpu_top # (MAYBE move to hw modules?)

      # file stuff:
      vaults       # Vaults (gocryptfs GTK GUI)
      gocryptfs    # gocryptfs
      rsync        # rsync/rclone
      rclone

      # cloud storage:
      nextcloud-client # Nextcloud client

      # net:
      # trayscale   # Trayscale (GTK Tailscale gui)
      ktailctl      # KTailCtl  (Qt Tailscale gui)

      # etc.
      xorg.xeyes
      scrcpy        # scrcpy (android screen mirroring)
      gearlever     # manage AppImages

      # KDE stuff:
      haruna                # KDE's Video player
      kdePackages.kalk      # Kalk (Calculator)
      kdePackages.yakuake   # Yakuake (dropdown terminal)
      kdePackages.filelight # Filelight (disk usage analyzer)
      kdePackages.krdc      # KRDC (remote desktop client)
      kdePackages.kcolorchooser # KColorChooser (color picker)
      kdePackages.akregator # RSS reader

      # Software:
      vlc                   # VLC Media Player
      snapshot              # Gnome's Camera App
      # libreoffice-fresh     # LibreOffice (GTK)
      # libreoffice-qt6-fresh # LibreOffice (Qt6)
      libreoffice-x11       # LibreOffice (Qt6-X11)
      # transmission_4-qt6    # Transmission (Qt)
      qbittorrent           # qBittorrent
      okteta                # Okteta (hex editor)
      imhex                 # imhex  (hex editor)
      # DISABLED BECAUSE OF BUILD FAILURE IN node-env
      # apostrophe            # GTK Markdown editor
      obs-studio            # OBS Studio (streaming/recording tool)
      logisim-evolution     # Logisim Evolution (digital logic simulator)
      pomodoro-gtk          # GTK Pomodoro Timer
      stremio               # Stremio (media center)
      parsec-bin            # Parsec (game streaming)
      tidal-hifi            # tidal hifi electron music player thingy

      # Bitwarden clients (because two aren't enough)
      bitwarden-desktop     # BitWarden Desktop client
      keyguard            # BitWarden (Keyguard)
      #goldwarden            # BitWarden (Goldwarden)

      # Hunpell/Hyphen dicts:
      hunspell
      hunspellDicts.en_US
      hunspellDicts.ru_RU
      hunspellDicts.uk_UA
      hunspellDicts.pl_PL
      hyphen
      hyphenDicts.en_US

      # Photo/Video/Graphics stuff:
      inkscape              # Inkscape (vector graphics editor)
      blender-hip           # Blender (with HIP support)
      gimp                  # GIMP  (image editor)
      krita                 # Krita (image editor)
      kdePackages.kdenlive  # Kdenlive (video editor)
      aseprite              # Aseprite (from source)

      # Audio stuff:
      easyeffects           # EasyEffects (pa audio effects)
      # TODO set up using home-manager option instead ^^^^^^
      audacity              # Audacity (audio editor)

      # Social/Communication stuff:
      # vesktop               # Discord (vesktop/vencord)
      (vesktop.override {
        electron = electron_33;
      })
      # (discord-canary.override {
      #   withOpenASAR = true;
      #   withVencord = true;
      # })
      # goofcord            # Discord (goofcord)
      telegram-desktop      # Telegram
      nheko                 # Nheko (matrix)
      zulip                 # Zulip desktop chat client
      teams-for-linux       # Microsoft Teams (unofficial open-source electron wrapper)

      # Dev. Stuff/Code editors
      zed-editor            # Zed Editor (gui)
      helix                 # Helix Editor (cli)
      renderdoc             # RenderDoc (graphics debugger)
      # rgp                 # Radeon GPU Profiler (compatible with RenderDoc)
      love                  # Love2D (lua game framework)

      # httpie (http client)
      httpie
      httpie-desktop # (unfree)

      # Device drivers etc
      # TODO fix galaxy-buds-client somehow (borked and outdated)
      # galaxy-buds-client  # GalaxyBudsClient (unofficial)
      pkgs-master.earbuds   # Samsung Galaxy Buds (earbuds cli)
      # Dev/
      pkgs-master.zepp-simulator

      # Games:
      principia-x11  # Principia
      the-powder-toy # The Powder Toy
      minetest       # Luanti/Minetest
      osu-lazer-bin  # Osu (lazer)
      prismlauncher  # Minecraft (Prism Launcher)
      space-cadet-pinball # Space Cadet Pinball for Windows
      # everest-mons # mons (Celeste/Everest mod loader installer)

      # Heroic/Lutris and Legendary/GOG/Amazon
      lutris
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
      cemu-amd-patch # Cemu (Wii U)
      mgba           # mGBA (GB/GBC/GBA)
      melonDS        # MelonDS (DS)
      # vita3k is not in nixpkgs :<

      # Stuff i need for uni:
      ciscoPacketTracer8-wrapped
      gns3-gui # GNS3 GUI
      winbox4 # Winbox (Mikrotik RouterOS GUI)
      azuredatastudio # Azure Data Studio

      # testing:
      ocelot-desktop
    ];
  };

  imports = [
    ./user/theming.nix
    ./user/face.nix
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
    ./user/zed.nix
    ./user/hacks
  ];
}
