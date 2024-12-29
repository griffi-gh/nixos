{ pkgs, ... }: {
  system.stateVersion = "24.11";

  hardware.enableAllFirmware = true;
  # hardware.enableRedistributableFirmware = true;

  imports = [
    # ./base/hacks/fontconfig-unbreak.nix # no longer needed
    ./../overlays/system.nix
    ./base/nix.nix
    ./base/boot.nix
    ./base/sudo.nix
    ./base/networking.nix
    ./base/bluetooth.nix
    ./base/power.nix
    ./base/desktop-kde.nix
    ./base/fonts.nix
    ./base/user.nix
    ./base/udevrules.nix
    ./base/tpm2.nix
    ./base/debug.nix
    ./base/location.nix
    ./base/services/ssh.nix
    ./base/services/sound.nix
    ./base/services/libinput.nix
    ./base/services/avahi.nix
    ./base/services/printing.nix
    ./base/services/xserver.nix
    ./base/services/tailscale.nix
    ./base/programs/gamescope.nix # broken
    ./base/programs/appimage.nix
    ./base/programs/gamemode.nix
    ./base/programs/steam.nix
    ./base/programs/virtualbox.nix
    ./base/programs/gns3-server.nix
    ./base/programs/wireshark.nix
    ./base/programs/wine.nix
    ./base/programs/podman.nix
  ];

  # Locale/timezone
  i18n.defaultLocale = "en_IE.UTF-8";
  time.timeZone = "Europe/Warsaw";

  # Enable 32-bit graphics packages
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Enable switch-ng
  system.switch = {
    enable = false;
    enableNg = true;
  };

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable power profile daemon
  services.power-profiles-daemon.enable = true;

  programs = {
    nix-ld = {
      enable = true;
      # package = pkgs.nix-ld-rs;
    };
    git.enable = true;
    vim.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    fish.enable = true;
    dconf.enable = true;
    # mosh (mobile shell, robust ssh over udp)
    mosh = {
      enable = true;
      openFirewall = true;
    };
    firejail.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # required
    git-crypt

    # nix stuff:
    comma

    # deps:
    bashInteractive
    efibootmgr
    e2fsprogs
    btrfs-progs
    lm_sensors

    # basic cli tools
    vim
    micro
    wget
    curl
    killall
    inetutils
    iputils
    openssl

    # runtimes:
    jdk21
    nodejs
    python3

    # archive:
    zip
    unzip
    unrar
    arj
    p7zip

    # exe icons
    icoutils

    # encrypted fs layers
    cryfs
    gocryptfs
  ];

  services = {
    # Flatpaks
    flatpak.enable = true;
  };

  # bump nofile limits
  # systemd.extraConfig = "DefaultLimitNOFILE=8192";
  security.pam.loginLimits = [
    { domain = "*"; item = "nofile"; type = "-"; value = "32768"; }
    { domain = "*"; item = "memlock"; type = "-"; value = "32768"; }
  ];

  environment.variables = {
    EDITOR = "nano";
  };

  environment.sessionVariables = {
    # Mozilla/Firefox/Thunderbird:
    MOZ_USE_XINPUT2 = "1";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_DBUS_REMOTE = "1";

    # Electron:
    # Force use of Wayland
    # XXX: Causes issues with taskbar icons in ALL electron apps (can be fixed by manual kwin rules)
    NIXOS_OZONE_WL = "1";

    # LibreOffice:
    SAL_DISABLE_WATCHDOG = "1";
    # XXX: Causes issues in writer (selected text not visible)
    # VCL_DOUBLEBUFFERING_ENABLE = "1";
    # VCL_DOUBLEBUFFERING_FORCE_ENABLE = "1";

    # SDL2:
    # XXX: Causes issues in some games
    # (tpt: blurry scaling)
    # SDL_VIDEODRIVER = "wayland";

    # Qt:
    # Fix janky fonts
    # XXX: causes blurry rendering in Spectacle and warnings whenever any Qt app is run
    # QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
  };

  # environment.profiles = lib.mkBefore [
  #   "/nix/var/nix/profiles/default"
  #   "/run/current-system/sw"
  # ];

  # set fallback cursor theme to Breeze
  # XXX: not sure if this actually works, should fix cursor in Steam and PacketTracer
  xdg.icons.fallbackCursorThemes = [
    "breeze_cursors"
  ];

  security = {
    # enable rtkit
    rtkit.enable = true;
    protectKernelImage = false;
    allowSimultaneousMultithreading = true;
  };
}
