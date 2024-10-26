{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = ''
      ${builtins.readFile ./plugins/options.lua}
    '';
  };
  # This is only for rust-analyzer to find the cargo binary.
  home.sessionVariables = {
    RUSTUP_TOOLCHAIN = "${pkgs.cargo}";
    # EDITOR = "emacs";
  };
  imports = [ ./plugins.nix ./packages.nix ];
}
