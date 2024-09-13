vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use { 'sourcegraph/sg.nvim', run = 'nvim -l build/init.lua' }
end)
