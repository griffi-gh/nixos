[
  (final: prev: let
    libinput = prev.libinput.overrideAttrs (oldAttrs: {
      src = final.fetchFromGitLab {
        domain = "gitlab.freedesktop.org";
        owner = "libinput";
        repo = "libinput";
        rev = "97adececa0c8a5804157694f6c739d33bfdfac7a";
        sha256 = "sha256-iFs2RaPopqfLRvKF2Vvw0qCLtqIc4w6tVectSxbw9jM=";
      };
      patches = oldAttrs.patches or [] ++ [
        ./libinput/pr-500.patch
        ./libinput/zzz-hold-tap-default.patch
      ];
    });
  in {
    # kdePackages = prev.kdePackages.overrideScope(kfinal: kprev: {
    #   kwin = kprev.kwin.override {
    #     inherit libinput;
    #   };
    # });
    libinpux = libinput;
  })
]
