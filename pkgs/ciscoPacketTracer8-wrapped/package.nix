{
  fetchurl,
  symlinkJoin,
  makeWrapper,
  # callPackage,
  ciscoPacketTracer8,
}:
symlinkJoin {
  name = "ciscoPacketTracer8-wrapped";
  paths = let
    # ciscoPacketTracer8' = (callPackage ./ciscoPacketTracer8.nix {
    #   requireFile = _: fetchurl {
    #     url = "https://files-cf.beeg.pp.ua/cisco/Packet_Tracer822_amd64_signed.deb";
    #     sha256 = "6cd2b8891df92d2cad8b6fdc47480fc089de085c4f3fe95eb80d5450a2a7f72d";
    #   };
    # });
    ciscoPacketTracer8' = ciscoPacketTracer8.overrideAttrs(_: {
      packetTracerSource = fetchurl {
        url = "https://files-cdn.girl.pp.ua/cisco/Packet_Tracer822_amd64_signed.deb";
        sha256 = "6cd2b8891df92d2cad8b6fdc47480fc089de085c4f3fe95eb80d5450a2a7f72d";
      };
    });
  in [
    ciscoPacketTracer8'
  ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    cp $out/bin/packettracer8 $out/bin/packettracer8-wl
    wrapProgram $out/bin/packettracer8 \
      --set GDK_BACKEND "x11" \
      --set XDG_CURRENT_DESKTOP "GNOME";
  '';
}
