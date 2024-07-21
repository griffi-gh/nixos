{ config, lib, pkgs, ... }: {
  system.stateVersion = "24.11";

  imports = [ 
    ./modules/nix.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/bluetooth.nix
    ./modules/sound.nix
    ./modules/printing.nix
    ./modules/desktop-kde.nix
    ./modules/services/ssh.nix
    ./modules/user.nix
  ];

  hardware.enableAllFirmware = true;
  
  system.switch = {
    enable = false;
    enableNg = true;
  };

  # Enable 32-bit graphics packages
  hardware.graphics.enable32Bit = true;
  
  # Select internationalisation properties.
  # TODO configure this:
  i18n.defaultLocale = "en_IE.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # videoDrivers = ["amdgpu"];
    xkb.layout = "us";
    # xkb.options = "eurosign:e,caps:escape";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  programs = {
    nix-ld.enable = true;
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
