vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pe", ":Oil --float " .. vim.loop.cwd())
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("n", "<leader>w", "<C-w>")
vim.keymap.set("n", "<leader>fs", ":w<CR>")
vim.keymap.set("n", "<leader>cc", function()
  vim.ui.input({
    prompt = "Run Command: ",
  }, function(input)
    vim.cmd(string.format("!%s", input))
  end)
end)
-- vim.keymap.set('n', "<leader>t", vim.cmd.FloatermToggle)
vim.keymap.set('t', "<leader>x", vim.cmd.FloatermToggle)
-- vim.keymap.set('n', "<leader>tn", vim.cmd.TablineBufferNext)
-- vim.keymap.set('n', "<leader>tp", vim.cmd.TablineBufferPrevious)
-- vim.keymap.set('n', "<leader>th", vim.cmd.TablineToggleShowAllBuffers)
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.linebreak = true
vim.opt.cursorline = true
vim.opt.scrolloff = 15
vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 20
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.binary = true
vim.opt.endofline = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.cmd('autocmd BufRead,BufNewFile user-data set filetype=yaml')
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufRead', 'BufNewFile' }, {
  pattern = 'lfrc',
  command = 'set filetype=vim',
})
