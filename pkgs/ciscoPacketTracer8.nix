{
  ciscoPacketTracer8,
  fetchurl,
  symlinkJoin,
  makeWrapper,
}:
symlinkJoin {
  name = "ciscoPacketTracer8";
  paths = let
    ciscoPacketTracer8' = ciscoPacketTracer8.overrideAttrs (prev: {
      src = fetchurl {
        url = "https://files-cf.beeg.pp.ua/cisco/Packet_Tracer822_amd64_signed.deb";
        sha256 = "6cd2b8891df92d2cad8b6fdc47480fc089de085c4f3fe95eb80d5450a2a7f72d";
      };
    });
  in [
    ciscoPacketTracer8'
  ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/packettracer8 \
      --set WAYLAND_DISPLAY "" \
      --set XDG_CURRENT_DESKTOP "GNOME";
  '';
}
