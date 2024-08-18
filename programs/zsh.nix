{config, pkgs, ...}:
{
  imports = [
    ../configs/zsh.nix

  ];

  home.packages =  [
    pkgs.zsh
    pkgs.zsh-fzf-tab
  ];

}
