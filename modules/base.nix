{ config, lib, pkgs, ... }: {
  system.stateVersion = "24.11";

  hardware.enableAllFirmware = true;
  # hardware.enableRedistributableFirmware = true;

  imports = [
    ./base/nix.nix
    ./base/boot.nix
    ./base/networking.nix
    ./base/bluetooth.nix
    ./base/power.nix
    ./base/desktop-kde.nix
    ./base/fonts.nix
    ./base/user.nix
    ./base/services/ssh.nix
    ./base/services/sound.nix
    ./base/services/libinput.nix
    ./base/services/printing.nix
    ./base/services/xserver.nix
    # ./base/services/zerotier.nix # broken
    ./base/programs/steam.nix
    ./base/programs/virtualbox.nix
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
  };

  environment.systemPackages = with pkgs; [
    efibootmgr
    e2fsprogs
    btrfs-progs
    lm_sensors
    vim
    micro
    wget
    curl
    nodejs
    python3
    unrar
    p7zip
    appimage-run
  ];

  # AppImage support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # sudo
  security.sudo.enable = false;
  security.sudo-rs = {
    enable = true;
    execWheelOnly = true;
  };

  environment.variables = {
    EDITOR = "nano";
  };

  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_DBUS_REMOTE = "1";
    # SDL_VIDEODRIVER = "wayland";
    NIXOS_OZONE_WL = "1";
  };

  security = {
    protectKernelImage = false;
    allowSimultaneousMultithreading = true;
  };
}
