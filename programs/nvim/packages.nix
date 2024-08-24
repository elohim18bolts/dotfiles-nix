{pkgs,...}:
let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    plenary-nvim
    telescope-nvim
    lualine-nvim
    tabline-nvim
    {
     plugin = gruvbox-nvim;
     config = toLua ''
       vim.o.background = "dark" -- or "light" for light mode
       vim.cmd([[colorscheme gruvbox]])
       ''
    }
    nvim-lspconfig

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
    nvim-autopairs
    nvim-cmp
    cmp-buffer
    cmp-path
    cmp-cmdline
    cmp-vsnip
    vim-vsnip
    ansible-vim
    vim-nix
    nvim-tree
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