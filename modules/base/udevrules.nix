{ pkgs, ... }: {
  services.udev = {
    packages = [
      pkgs.android-udev-rules
    ];
    # for PSPLINK support
    extraRules = ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="054c", ATTR{idProduct}=="01c9", SYMLINK+="psp", MODE="0666"
    '';
  };
}
