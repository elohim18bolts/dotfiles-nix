{pkgs,...}:
{
   programs.neovim = {
enable = true;
viAlias = true;
vimAlias = true;
vimdiffAlias = true;
extraLuaConfig = ''
vim.g.mapleader = "<Space>"
vim.keymap.set("i", "jk", "<ESC>")
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.scrolloff = 15
vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 20
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.binary = true
vim.opt.endofline = false


vim.cmd('autocmd BufRead,BufNewFile user-data set filetype=yaml')

'';
};
imports = [ ./plugins.nix ./packages.nix ];
}
