{ ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = ''
      ${builtins.readFile ./plugins/options.lua}
      vim.cmd [[packadd packer.nvim]]
      return require('packer').startup(function(use)
        -- Packer can manage itself
        use 'wbthomason/packer.nvim'
         use { 'sourcegraph/sg.nvim', run = 'nvim -l build/init.lua' }
      end)
    '';
  };
  imports = [ ./plugins.nix ./packages.nix ];
}
