{ pkgs, config, ... }:
let
  symbolFont = pkgs.nerd-fonts.symbols-only;
in
{
  home.file."NerdFontsSymbols" = {
    enable = true;
    source = "${symbolFont}/share/fonts/truetype/NerdFonts/SymbolsNerdFontMono-Regular.ttf";
    target = "Library/Fonts/SymbolsNerdFontMono-Regular.ttf";
  };
  home.packages = with pkgs;[
    nerd-fonts.jetbrains-mono
    nerd-fonts.victor-mono
  ];

  fonts.fontconfig.enable = true;

}
