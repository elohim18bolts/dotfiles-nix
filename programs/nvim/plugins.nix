{pkgs,...}:
let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    plenary-nvim
    telescope-nvim

    {
      plugin = lualine-nvim;
      config = toLuaFile ./plugins/lualine.lua;
    }

    tabline-nvim
    {
     plugin = nord-nvim;
     config = toLua ''
       vim.cmd([[colorscheme nord]])
       '';
    }
    {
     plugin = nvim-lspconfig;
     config = toLuaFile ./plugins/lspconfig.lua;
    }

    (nvim-treesitter.withPlugins (p: 
    with p;[
      org
      nix
      markdown
      c
      lua
      rust
      vimdoc
      go
      json5
      yaml
      javascript
      typescript
    ]
    ))
    harpoon
    undotree
    vim-fugitive
    {
    plugin = nvim-autopairs;
    config = toLua ''
       require("nvim-autopairs").setup()
    '';
    }
    {
      plugin = nvim-cmp;
      config = toLuaFile ./plugins/nvim-cmp.lua;
    }
    orgmode
    cmp-buffer
    cmp-path
    cmp-cmdline
    cmp-vsnip
    vim-vsnip
    ansible-vim
    vim-nix
    nvim-web-devicons
    {
     plugin = neo-tree-nvim;
     config = toLuaFile ./plugins/neo-tree.lua;
    }
    oil-nvim
    {
    plugin = which-key-nvim;
    config = toLuaFile ./plugins/which-key.lua;
    }
    vim-floaterm
    gitsigns-nvim
    rainbow-delimiters-nvim
    indent-blankline-nvim
    hologram-nvim
    go-nvim

  ];
}
