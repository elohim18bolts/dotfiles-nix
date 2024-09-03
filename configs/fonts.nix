{ pkgs, config, ... }:
let
  symbolFont = pkgs.nerdfonts.override {
    fonts = [ "NerdFontsSymbolsOnly" ];
  };
in
{
  home.file."NerdFontsSymbols" = {
    enable = true;
    source = "${symbolFont}/share/fonts/truetype/NerdFonts/SymbolsNerdFontMono-Regular.ttf";
    target = "Library/Fonts/SymbolsNerdFontMono-Regular.ttf";
  };
  home.packages = [
    pkgs.fontconfig
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "VictorMono" ]; })

  ];

  fonts.fontconfig.enable = true;

}
