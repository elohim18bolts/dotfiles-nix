local wk = require('which-key')
wk.add({
	mode = { "n", "v" },
	{
		{ "<leader> f", group = "File" },
		{ "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Find File" },
		{ "<leader>fp", "<cmd>Telescope git_files<cr>",   desc = "Find File In Project" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>",    desc = "Open Recent File" }, -- noremap = false, buffer = 123 }, -- additional options for creating the keymap
		{ "<leader>fg", "<cmd>Telescope grep_string<cr>", desc = "Searches for the string under your cursor" },
		{ "<leader>fG", "<cmd>Telescope live_grep<cr>",   desc = "Search for a string in your current working directory" },
		{
			"<leader>fn",
			function()
				vim.ui.input({
					prompt = "File Name: ",
				}, function(input)
					if input == "" then return end
					vim.cmd(string.format("e %s", input))
				end
				)
			end,
			desc = "New File"
		},
		{
			"<leader>fR",
			function()
				local bufferName = vim.api.nvim_buf_get_name(0)
				if string.find(string.format("%s", bufferName), "NvimTree") ~= nil then
					require('nvim-tree.api').fs.rename_sub()
					return
				end
				vim.ui.input({
					prompt = "Rename File: ",
				}, function(input)
					vim.cmd(string.format("file %s", input))
				end
				)
			end,
			desc = "Rename File In Place"

		},

	},
	{
		{ "<leader>g",  group = "Git" },
		{ "<leader>gg", "<cmd>Git<cr>",             desc = "Git Management" },
		{ "<leader>gp", "<cmd>Git push origin<cr>", desc = "Push To Remote Repo" },

	},
	{
		{ "<leader>b",  group = "Buffer" },
		{ "<leader>bb", "<cmd>Telescope buffers<cr>",                   desc = "Show Opened Buffers" },
		{ "<leader>bs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find In Current Buffer" },
	},
	{
		{ "<leader>w",  group = "Panels" },
		{ "<leader>wv", "<cmd>vsplit<cr>", desc = "Split Window Vertical" },
		{ "<leader>wz", "<cmd>split<cr>",  desc = "Split Window Horizontal" },

	},
	{
		{ "<leader>t",  group = "Terminals And Tabs" },
		{ "<leader>tt", "<cmd>FloatermToggle<cr>",              desc = "Toggle Floating Terminal" },
		{ "<leader>tn", "<cmd>TablineBufferNext<cr>",           desc = "Next Tab" },
		{ "<leader>tp", "<cmd>TablineBufferPrevious<cr>",       desc = "Previous Tab" },
		{ "<leader>th", "<cmd>TablineToggleShowAllBuffers<cr>", desc = "Toggle Show All Tabs" },

	},


})
