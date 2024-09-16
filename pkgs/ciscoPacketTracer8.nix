{ pkgs, ... }:
pkgs.ciscoPacketTracer8.overrideAttrs (prev: {
  src = pkgs.fetchurl {
    url = "https://files-cf.beeg.pp.ua/cisco/Packet_Tracer822_amd64_signed.deb";
    sha256 = "6cd2b8891df92d2cad8b6fdc47480fc089de085c4f3fe95eb80d5450a2a7f72d";
  };
  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "cisco-pt8.desktop";
      desktopName = "Cisco Packet Tracer 8";
      icon = "ciscoPacketTracer8";
      # Override XDG_CURRENT_DESKTOP to GNOME to fix the theming/wayland issues
      exec = "env XDG_CURRENT_DESKTOP=GNOME packettracer8 %f";
      mimeTypes = [ "application/x-pkt" "application/x-pka" "application/x-pkz" ];
    })
  ];
})
