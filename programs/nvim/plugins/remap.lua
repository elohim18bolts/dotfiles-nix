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