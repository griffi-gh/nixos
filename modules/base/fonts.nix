{ self, pkgs, system, ... }: {
  fonts = {
    fontDir.enable = true;
    fontconfig = {
      subpixel.rgba = "rgb";
      hinting.style = "slight";
      cache32Bit = true;
      # useEmbeddedBitmaps = true;
    };
    enableDefaultPackages = false; # (Specified explicitly below instead)
    packages = with pkgs; let
      inherit (self.packages."${system}") segoe-ui-linux;
    in [
      # Emoji
      noto-fonts-color-emoji

      # Base fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      liberation_ttf
      freefont_ttf
      gyre-fonts # TrueType substitutes for standard PostScript fonts
      unifont

      # Microsoft fonts
      segoe-ui-linux
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
      nerd-fonts.symbols-only
      nerd-fonts.sauce-code-pro
      nerd-fonts.fira-code
      # (nerdfonts.override {
      #   fonts = [
      #     "NerdFontsSymbolsOnly"
      #     "SourceCodePro"
      #     "FiraCode"
      #   ];
      # })
    ];
  };
}
