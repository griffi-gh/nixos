{ inputs, ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        # https://gitlab.matrix.org/matrix-org/olm/-/blob/6d4b5b07887821a95b144091c8497d09d377f985/README.md#important-libolm-is-now-deprecated
        # libolm is deprecated, used by some matrix clients
        "olm-3.2.16"
        "electron-32.3.3"
        "electron-33.4.11"
        "dotnet-runtime-7.0.20"
        "libxml2-2.13.8"
      ];
      firefox.enablePlasmaBrowserIntegration = true;
    };
    flake = {
      setNixPath = true;
      setFlakeRegistry = true;
    };
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
    ] ++ (import ../../overlays);
  };
}