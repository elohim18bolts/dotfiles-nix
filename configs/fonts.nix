{pkgs,config,...}:
{
  home.packages = [
    pkgs.fontconfig
    (pkgs.nerdfonts.override { fonts = ["JetBrainsMono" "VictorMono" ];})

  ];

  fonts.fontconfig.enable = true;

}
