local colors = {
	bg       = '#202328',
	fg       = '#bbc2cf',
	yellow   = '#ECBE7B',
	cyan     = '#008080',
	darkblue = '#081633',
	green    = '#98be65',
	orange   = '#FF8800',
	violet   = '#a9a1e1',
	magenta  = '#c678dd',
	blue     = '#51afef',
	red      = '#ec5f67',
}
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		--		component_separators = { left = '', right = '' },
		--		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = { '  ', separator = { left = '' }, right_padding = 2, color = function()
			-- auto change color according to neovims mode
			local mode_color = {
				n = colors.red,
				i = colors.green,
				v = colors.blue,
				[''] = colors.blue,
				V = colors.blue,
				c = colors.magenta,
				no = colors.red,
				s = colors.orange,
				S = colors.orange,
				[''] = colors.orange,
				ic = colors.yellow,
				R = colors.violet,
				Rv = colors.violet,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				['r?'] = colors.cyan,
				['!'] = colors.red,
				t = colors.red,
			}
			return { fg = mode_color[vim.fn.mode()] }
		end
		},
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}
