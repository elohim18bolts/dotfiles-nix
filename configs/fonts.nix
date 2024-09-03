{ pkgs, config, ... }:
{
  home.packages = [
    pkgs.fontconfig
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "VictorMono" "Symbols" ]; })

  ];

  fonts.fontconfig.enable = true;

}
