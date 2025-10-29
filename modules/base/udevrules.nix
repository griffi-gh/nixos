{ pkgs, ... }:
{
  services.udev = {
    packages = [ ];
    extraRules = ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="054c", ATTR{idProduct}=="01c9", SYMLINK+="psp", MODE="0666"
    '';
  };
}
