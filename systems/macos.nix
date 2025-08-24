{ config, pkgs, ... }:
{
  home = {
    username = "elohim";
    homeDirectory = "/Users/elohim";
  };
  home.packages = with pkgs;[
    (license-cli.override {
      wl-clipboard = null;
    })
  ];
}
