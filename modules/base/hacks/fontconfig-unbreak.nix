# https://github.com/timon-schelling/timonos/blob/5da503e6d87eed4f417be000dd9d4cebe099c470/src/user/fonts/system.nix

# TODO: remove once https://github.com/NixOS/nixpkgs/pull/338328 (9729387a99fcff79e06dfd631f74a2923a84d585) gets to nixpkgs-unstable

{ lib, pkgs, config, ... }:

let
  cfg = config.fonts.fontconfig;

  fcBool = x: "<bool>" + (lib.boolToString x) + "</bool>";
  pkg = pkgs.fontconfig;

  # configuration file to read fontconfig cache
  # priority 0
  cacheConf  = makeCacheConf {};

  # generate the font cache setting file
  # When cross-compiling, we can’t generate the cache, so we skip the
  # <cachedir> part. fontconfig still works but is a little slower in
  # looking things up.
  makeCacheConf = { }:
    let
      makeCache = fontconfig: pkgs.makeFontsCache { inherit fontconfig; fontDirectories = config.fonts.packages; };
      cache     = makeCache pkgs.fontconfig;
      cache32   = makeCache pkgs.pkgsi686Linux.fontconfig;
    in
    pkgs.writeText "fc-00-nixos-cache.conf" ''
      <?xml version='1.0'?>
      <!DOCTYPE fontconfig SYSTEM 'urn:fontconfig:fonts.dtd'>
      <fontconfig>
        <!-- Font directories -->
        ${lib.concatStringsSep "\n" (map (font: "<dir>${font}</dir>") config.fonts.packages)}
        ${lib.optionalString (pkgs.stdenv.hostPlatform == pkgs.stdenv.buildPlatform) ''
        <!-- Pre-generated font caches -->
        <cachedir>${cache}</cachedir>
        ${lib.optionalString (pkgs.stdenv.isx86_64 && cfg.cache32Bit) ''
          <cachedir>${cache32}</cachedir>
        ''}
        ''}
      </fontconfig>
    '';

  # rendering settings configuration file
  # priority 10
  renderConf = pkgs.writeText "fc-10-nixos-rendering.conf" ''
    <?xml version='1.0'?>
    <!DOCTYPE fontconfig SYSTEM 'urn:fontconfig:fonts.dtd'>
    <fontconfig>

      <!-- Default rendering settings -->
      <match target="pattern">
        <edit mode="append" name="hinting">
          ${fcBool cfg.hinting.enable}
        </edit>
        <edit mode="append" name="autohint">
          ${fcBool cfg.hinting.autohint}
        </edit>
      </match>

    </fontconfig>
  '';

  # local configuration file
  localConf = pkgs.writeText "fc-local.conf" cfg.localConf;

  # default fonts configuration file
  # priority 52
  defaultFontsConf =
    let genDefault = fonts: name:
      lib.optionalString (fonts != []) ''
        <alias binding="same">
          <family>${name}</family>
          <prefer>
          ${lib.concatStringsSep ""
          (map (font: ''
            <family>${font}</family>
          '') fonts)}
          </prefer>
        </alias>
      '';
    in
    pkgs.writeText "fc-52-nixos-default-fonts.conf" ''
    <?xml version='1.0'?>
    <!DOCTYPE fontconfig SYSTEM 'urn:fontconfig:fonts.dtd'>
    <fontconfig>

      <!-- Default fonts -->
      ${genDefault cfg.defaultFonts.sansSerif "sans-serif"}

      ${genDefault cfg.defaultFonts.serif     "serif"}

      ${genDefault cfg.defaultFonts.monospace "monospace"}

      ${genDefault cfg.defaultFonts.emoji "emoji"}

    </fontconfig>
  '';

  # bitmap font options
  # priority 53
  rejectBitmaps = pkgs.writeText "fc-53-no-bitmaps.conf" ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
    <fontconfig>

    ${lib.optionalString (!cfg.allowBitmaps) ''
    <!-- Reject bitmap fonts -->
    <selectfont>
      <rejectfont>
        <pattern>
          <patelt name="scalable"><bool>false</bool></patelt>
        </pattern>
      </rejectfont>
    </selectfont>
    ''}

    <!-- Use embedded bitmaps in fonts like Calibri? -->
    <match target="font">
      <edit name="embeddedbitmap" mode="assign">
        ${fcBool cfg.useEmbeddedBitmaps}
      </edit>
    </match>

    </fontconfig>
  '';

  # reject Type 1 fonts
  # priority 53
  rejectType1 = pkgs.writeText "fc-53-nixos-reject-type1.conf" ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
    <fontconfig>

    <!-- Reject Type 1 fonts -->
    <selectfont>
      <rejectfont>
        <pattern>
          <patelt name="fontformat"><string>Type 1</string></patelt>
        </pattern>
      </rejectfont>
    </selectfont>

    </fontconfig>
  '';

  # Replace default linked config with a different variant
  replaceDefaultConfig = defaultConfig: newConfig: ''
    rm $dst/${defaultConfig}
    ln -s ${pkg.out}/share/fontconfig/conf.avail/${newConfig} \
          $dst/
  '';

  # fontconfig configuration package
  confPkg = pkgs.runCommand "fontconfig-conf" {
    preferLocalBuild = true;
  } ''
    dst=$out/etc/fonts/conf.d
    mkdir -p $dst

    # fonts.conf
    cp ${pkg.out}/etc/fonts/fonts.conf \
          $dst/../fonts.conf

    # horrible sed hack to add the line that was accidentally removed
    # from the default config in #324516
    # FIXME: fix that, revert this
    sed '5i <include ignore_missing="yes">/etc/fonts/conf.d</include>' -i $dst/../fonts.conf

    # TODO: remove this legacy symlink once people stop using packages built before #95358 was merged
    mkdir -p $out/etc/fonts/2.11
    ln -s /etc/fonts/fonts.conf \
          $out/etc/fonts/2.11/fonts.conf

    # fontconfig default config files
    ln -s ${pkg.out}/etc/fonts/conf.d/*.conf \
          $dst/

    ${lib.optionalString (!cfg.antialias)
      (replaceDefaultConfig "10-yes-antialias.conf"
        "10-no-antialias.conf")
    }

    ${lib.optionalString (cfg.hinting.style != "slight")
      (replaceDefaultConfig "10-hinting-slight.conf"
        "10-hinting-${cfg.hinting.style}.conf")
    }

    ${lib.optionalString (cfg.subpixel.rgba != "none")
      (replaceDefaultConfig "10-sub-pixel-none.conf"
        "10-sub-pixel-${cfg.subpixel.rgba}.conf")
    }

    ${lib.optionalString (cfg.subpixel.lcdfilter != "default")
      (replaceDefaultConfig "11-lcdfilter-default.conf"
        "11-lcdfilter-${cfg.subpixel.lcdfilter}.conf")
    }

    # 00-nixos-cache.conf
    ln -s ${cacheConf}  $dst/00-nixos-cache.conf

    # 10-nixos-rendering.conf
    ln -s ${renderConf}       $dst/10-nixos-rendering.conf

    # 50-user.conf
    ${lib.optionalString (!cfg.includeUserConf) ''
    rm $dst/50-user.conf
    ''}

    # local.conf (indirect priority 51)
    ${lib.optionalString (cfg.localConf != "") ''
    ln -s ${localConf}        $dst/../local.conf
    ''}

    # 52-nixos-default-fonts.conf
    ln -s ${defaultFontsConf} $dst/52-nixos-default-fonts.conf

    # 53-no-bitmaps.conf
    ln -s ${rejectBitmaps} $dst/53-no-bitmaps.conf

    ${lib.optionalString (!cfg.allowType1) ''
    # 53-nixos-reject-type1.conf
    ln -s ${rejectType1} $dst/53-nixos-reject-type1.conf
    ''}
  '';
in
{
  fonts.fontconfig.confPackages = lib.mkForce [ confPkg ];
}
