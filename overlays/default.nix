[
  (final: prev: {
    libinput-patched = prev.libinput.overrideAttrs (oldAttrs: {
      src = final.fetchFromGitLab {
        domain = "gitlab.freedesktop.org";
        owner = "libinput";
        repo = "libinput";
        rev = "97adececa0c8a5804157694f6c739d33bfdfac7a";
        sha256 = "sha256-iFs2RaPopqfLRvKF2Vvw0qCLtqIc4w6tVectSxbw9jM=";
      };
      patches = oldAttrs.patches or [] ++ [
        ./libinput-patches/0001-mr-500.patch
        ./libinput-patches/0002-hold-tap-default.patch
      ];
    });
  })
]
