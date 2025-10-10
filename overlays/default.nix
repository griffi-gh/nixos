{ lib, pkgs-stable, ... }:
[
  (final: prev: {
    libinput-patched = prev.libinput.overrideAttrs (prev: {
      src = final.fetchFromGitLab {
        domain = "gitlab.freedesktop.org";
        owner = "libinput";
        repo = "libinput";
        rev = "97adececa0c8a5804157694f6c739d33bfdfac7a";
        sha256 = "sha256-iFs2RaPopqfLRvKF2Vvw0qCLtqIc4w6tVectSxbw9jM=";
      };
      patches = prev.patches or [ ] ++ [
        ./libinput-patches/0001-mr-500.patch
        ./libinput-patches/0002-hold-tap-default.patch
      ];
    });
    kwin-blur-patched = prev.kwin.overrideAttrs (prev: {
      patches = prev.patches or [ ] ++ [
        ./kwin-patches/0001-fix-blurry-offscreen-effect.patch
      ];
    });
  })

  # https://github.com/NixOS/nixpkgs/issues/445447
  (
    final: prev:
    lib.mapAttrs
      (
        n: pkg:
        pkg.overrideAttrs (old: {
          cmakeFlags = old.cmakeFlags or [ ] ++ [ "-DCMAKE_POLICY_VERSION_MINIMUM=3.5" ];
        })
      )
      {
        inherit (prev)
          fw-ectool
          aseprite
          imhex
          shiboken2
          mgba
          renderdoc
          discord-rpc
          cemu
          ;
      }
  )

  # https://github.com/NixOS/nixpkgs/issues/450444
  (final: prev: {
    bpftrace = prev.bpftrace.override {
      llvmPackages = final.llvmPackages_20;
    };
  })

  # https://github.com/NixOS/nixpkgs/issues/449445
  (final: prev: {
    imhex = prev.imhex.overrideAttrs (old: {
      env.NIX_CFLAGS_COMPILE = "-Wno-error=deprecated-declarations";
    });
  })

  # just make it work...
  (final: prev: {
    inherit (pkgs-stable) renderdoc;
  })
]
