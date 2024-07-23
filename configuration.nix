{ config, lib, pkgs, ... }: {
  system.stateVersion = "24.11";

  hardware.enableAllFirmware = true;
  # hardware.enableRedistributableFirmware = true;

  imports = [ 
    ./modules/nix.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/bluetooth.nix
    ./modules/desktop-kde.nix
    ./modules/services/ssh.nix
    ./modules/services/sound.nix
    ./modules/services/printing.nix
    ./modules/services/xserver.nix
    ./modules/user.nix
  ];

  # Locale/timezone
  i18n.defaultLocale = "en_IE.UTF-8";
  time.timeZone = "Europe/Warsaw"; 

  # Enable 32-bit graphics packages
  hardware.graphics.enable32Bit = true;

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

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  programs = {
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };
    git.enable = true;
    vim.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  
  environment.systemPackages = with pkgs; [
    vim
    micro
    wget
    curl
    nodejs
  ];

  environment.variables = {
    EDITOR = "nano";
  };
}
