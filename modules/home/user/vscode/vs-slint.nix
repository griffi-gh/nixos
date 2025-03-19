{ pkgs, ... }: {
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-marketplace; [
      /* TODO either add these to LD_LIBRARY_PATH or use slint-lsp from nixpkgs instead
        fuse3
        openssl
        curl
        libxkbcommon
        libudev-zero
        libappindicator-gtk3
        libdrm
        libglvnd
        libusb1
        libuuid
        libxml2
        libinput
        mesa
        fontconfig
        freetype */
      slint.slint
    ];
    userSettings = {
      "slint.preview.providedByEditor" = true;
    };
  };
}