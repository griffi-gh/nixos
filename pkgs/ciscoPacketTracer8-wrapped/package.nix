{
  fetchurl,
  symlinkJoin,
  makeWrapper,
  ciscoPacketTracer8,
}:
let
  ciscoPacketTracer8' = ciscoPacketTracer8.override {
    version = "8.2.2";
    packetTracerSource = fetchurl {
      url = "https://files-cdn.girl.pp.ua/cisco/Packet_Tracer822_amd64_signed.deb";
      sha256 = "6cd2b8891df92d2cad8b6fdc47480fc089de085c4f3fe95eb80d5450a2a7f72d";
    };
  };
in
symlinkJoin {
  name = "ciscoPacketTracer8-wrapped";
  paths = [
    ciscoPacketTracer8'
  ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/packettracer8 \
      --set GDK_BACKEND "x11" \
      --set XDG_CURRENT_DESKTOP "GNOME";
    ln -s $out/bin/.packettracer8-wrapped $out/bin/packettracer8-wl
  '';
}
