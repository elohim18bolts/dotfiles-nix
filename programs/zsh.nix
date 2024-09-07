{ pkgs, ... }:
{
  imports = [
    (import ../configs/zsh.nix {
      inherit pkgs;
      inherit (pkgs) stdenv lib;
    })
  ];

  home. packages = [
    pkgs.zsh
    pkgs.zsh-fzf-tab
  ];

}
