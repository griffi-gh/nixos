{ ... }: {
  fonts = {
    fontDir.enable = true;
    fontconfig = {
      subpixel.rgba = "rgb";
      hinting.stlye = "slight";
      cache32Bit.enable = true;
      useEmbeddedBitmaps = true;
    };
    enableDefaultPackages = false; # (Specified explicitly below instead)
    packages = with pkgs; [
      # Emoji
      noto-fonts-color-emoji

      # Base fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      freefont_ttf
      gyre-fonts # TrueType substitutes for standard PostScript fonts
      unifont

      # Microsoft fonts
      corefonts
      vistafonts

      # Bitmap fonts
      proggyfonts
      dina-font

      # Code fonts
      source-code-pro
      fira-code
      fira-code-symbols

      # Nerd fonts
      (nerdfonts.override {
        fonts = [
          "NerdFontsSymbolsOnly"
          "SourceCodePro"
          "FiraCode"
        ];
      })
    ];
  };
}