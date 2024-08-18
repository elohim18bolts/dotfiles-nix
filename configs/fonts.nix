{pkgs,config,...}:
{
  home.packages = [
    pkgs.fontconfig
    pkgs.victor-mono

  ];

  fonts.fontconfig.enable = true;

}
