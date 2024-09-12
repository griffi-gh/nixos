{ pkgs, ... }:
pkgs.ciscoPacketTracer8.overrideAttrs (prev: {
  src = pkgs.fetchurl {
    url = "https://files.beeg.pp.ua/cisco/Packet_Tracer822_amd64_signed.deb";
    sha256 = "6cd2b8891df92d2cad8b6fdc47480fc089de085c4f3fe95eb80d5450a2a7f72d";
  };
})
