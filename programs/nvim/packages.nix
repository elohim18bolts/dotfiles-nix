{ pkgs, ... }:
{
  programs.neovim.extraPackages = with pkgs; [
    nodejs_20
  ];
}
