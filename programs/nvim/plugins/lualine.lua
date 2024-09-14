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
  black    = '#000000',
  nord0    = "#2e3440",
  nord1    = "#3b4252",
  nord2    = "#434c5e",
  nord3    = "#4c566a",
  nord4    = "#d8dee9",
  nord5    = "#e5e9f0",
  nord6    = "#eceff4",
  nord7    = "#8fbcbb",
  nord8    = "#88c0d0",
  nord9    = "#81a1c1",
  nord10   = "#5e81ac",
  nord11   = "#bf616a",
  nord12   = "#d08770",
  nord13   = "#ebcb8b",
  nord14   = "#a3be8c",
  nord15   = "#b48ead",
}
local lualine = require('lualine')
lualine.setup {
  options = {
    theme = 'nord',
    component_separators = {
      left = "⋮",
      right = "⋮",
    },

    section_separators = {
      left = "",
      right = "",
    },
    disabled_filetypes = {
      statusline = {
        'help', 'terminal', 'NvimTree', 'NvimTreeGit', 'NvimTreeGitStash', 'NvimTreeGit', 'neo-tree'
      },
      winbar = {
        'help', 'terminal', 'NvimTree', 'NvimTreeGit', 'NvimTreeGitStash', 'NvimTreeGit', 'neo-tree'
      },
    },
    ignore_focus = {
      'help', 'terminal', 'NvimTree', 'NvimTreeGit', 'NvimTreeGitStash', 'neo-tree'
    },
    --always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {
      {
        function()
          return '  '
        end,
        color = function()
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
          return { fg = mode_color[vim.fn.mode()], bg = colors.black }
        end,
        padding = { right = 1 },
        separator = {
          right = "",
        },
      }
    },
    lualine_b = {
      {
        "filesize",
        color = {
          fg = colors.nord0,
          bg = colors.nord6,
        },
      },
      {
        "filetype",
        colored = false,
        icon_only = true,
        color = {
          fg = colors.nord0,
          bg = colors.nord6,
        }
      },
      {
        'branch',
        icon = "",

      },
      {
        'diff',
      }
    },
    lualine_c = {},
    lualine_x = {
      {
        'diagnostics',
        update_in_insert = true,
      }
    },
    lualine_y = {},
    lualine_z = {
      {
        "%l:%c",
      },
      {
        "progress"

      },
      {
        "fileformat",
        icon_only = true,
      }
    }
  },
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        "buffers",
        symbols = {
          modified = "",
          readonly = "",
          unnamed = " ",
          newfile = " ",
        },
        buffers_color = {
          active = {
            fg = colors.nord6,
            bg = colors.nord10,
          },
          inactive = {
            fg = colors.nord6,
            bg = colors.nord1,
          }
        },
        separator = {
          right = "",
        }
      }
    },
    lualine_x = {},
    lualine_y = {
      {
        "filename",
        file_status = true,
        shorting_target = 25,
        path = 1,
        symbols = {

          modified = "",
          readonly = "",
          unnamed = " ",
          newfile = " ",
        },
        separator = {
          left = "",
        },
        color = {
          fg = colors.nord6,
          bg = colors.nord10,
        },
      }
    },
    lualine_z = {
      {
        "tabs",
        tabs_color = {
          active = {
            fg = colors.nord6,
            bg = colors.nord10,
          },
          inactive = {
            fg = colors.nord6,
            bg = colors.nord1,
          }
        },
        separator = {
          left = "",
        }
      }
    },
  },
  winbar = {},
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      {
        "filetype",
        colored = false,
        icon_only = true,
        color = {
          fg = colors.nord6,
          bg = colors.nord1,
        }
      },
      {
        "filename",
        file_status = true,
        path = 1,
        shorting_target = 25,
        symbols = {

          modified = "",
          readonly = "",
          unnamed = " ",
          newfile = " ",
        },
        separator = {
          left = "",
        },
        color = {
          fg = colors.nord6,
          bg = colors.nord1,
        }
      }
    },
  },
  highlight = {
    statusline = {
      bg = colors.nord0,
    },
    lualine_b_buffers_active = {
      fg = colors.nord6,
      bg = colors.nord10
    },
    lualine_b_buffers_inactive = {
      fg = colors.nord6,
      bg = colors.nord1,
    },
    lualine_b_diff_modified_terminal = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_modified_inactive = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_removed_terminal = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_removed_inactive = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_modified_replace = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_modified_command = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_removed_replace = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_removed_command = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_modified_visual = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_modified_normal = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_modified_insert = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_removed_visual = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_removed_normal = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_removed_insert = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_added_terminal = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_added_inactive = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_added_replace = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_added_command = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_added_visual = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_added_normal = {
      fg = colors.nord6,
      bg = colors.nord10,
    },
    lualine_b_diff_added_insert = {
      fg = colors.nord6,
      bg = colors.nord10,
    },

  },
  extensions = { "neo-tree" }
}
