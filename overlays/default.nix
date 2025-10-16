{ lib, pkgs-stable, ... }:
[
  # just make it work...
  (final: prev: {
    inherit (pkgs-stable) renderdoc;
  })

  (final: prev: {
    vlc' = final.symlinkJoin {
      name = "vlc";
      paths = [ prev.vlc ];
      nativeBuildInputs = [ final.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/vlc \
            --unset DISPLAY
      '';
    };
  })

  (final: prev: {
    principia = final.symlinkJoin {
      name = "principia";
      paths = [ prev.principia ];
      nativeBuildInputs = [ final.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/principia \
          --set GDK_BACKEND x11;
      '';
    };
  })

  (final: prev: {
    osu-lazer-bin = final.symlinkJoin {
      name = "osu-lazer-bin";
      paths = [ prev.osu-lazer-bin ];
      nativeBuildInputs = [ final.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/osu! \
          --set SDL_VIDEODRIVER wayland \
          --add-flags '--sdl';
      '';
    };
  })

  (final: prev: {
    principia = final.symlinkJoin {
      name = "principia";
      paths = [ prev.principia ];
      nativeBuildInputs = [ final.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/principia \
          --set GDK_BACKEND x11;
      '';
    };
  })

  (final: prev: {
    ciscoPacketTracer8 = final.symlinkJoin {
      name = "ciscoPacketTracer8";
      paths = [
        (prev.ciscoPacketTracer8.override {
          version = "8.2.2";
          packetTracerSource = final.fetchurl {
            url = "https://files-cdn.girl.pp.ua/cisco/Packet_Tracer822_amd64_signed.deb";
            sha256 = "6cd2b8891df92d2cad8b6fdc47480fc089de085c4f3fe95eb80d5450a2a7f72d";
          };
        })
      ];
      nativeBuildInputs = [ final.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/packettracer8 \
            --set GDK_BACKEND "x11" \
            --set XDG_CURRENT_DESKTOP "GNOME";
        ln -s $out/bin/.packettracer8-wrapped $out/bin/packettracer8-wl
      '';
    };
  })

  (final: prev: {
    vintagestory = final.symlinkJoin {
      name = "vintagestory";
      paths = [ prev.vintagestory ];
      nativeBuildInputs = [ final.makeWrapper ];
      postBuild = ''
        vs_bin="$out/bin/vintagestory";
        vs_bin_wrapped="$out/bin/.vintagestory-wrapped";
        mv $vs_bin $vs_bin_wrapped;
        makeWrapper ${final.gamemode}/bin/gamemoderun $vs_bin \
          --add-flag $vs_bin_wrapped \
          --argv0 $vs_bin_wrapped \
          --set mesa_glthread true;
      '';
    };
  })
]
