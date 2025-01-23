{ pkgs, ... }:
{
  programs.neovim.extraPackages = with pkgs; [
    pyright
    nodePackages.typescript-language-server
    lua-language-server
    yaml-language-server
    nil
    terraform-ls
    rust-analyzer
    gopls
    cargo
    rustfmt
    go
    nixpkgs-fmt
    nodejs_20
  ];
}
