require("obsidian").setup({

  -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
  completion = {
    -- Set to false to disable completion.
    nvim_cmp = true,
    -- Trigger completion at 2 chars.
    min_chars = 2,
  },
  workspaces = {
    {
      name = "personal",
      path = "~/Documents/comptia/comptia",
    },
  },

})
