{pkgs,config,...}:
{
  home.packages = [
    pkgs.fontconfig
    (pkgs.nerdfonts.overrride { fonts = ["JetBrainsMono" "VictorMono" ]})

  ];

  fonts.fontconfig.enable = true;

}
