{pkgs,...}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    plenary-nvim
    telescope-nvim
    lualine-nvim
    tabline-nvim
    gruvbox-nvim
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
    vim-floaterm
    gitsigns-nvim
    rainbow-delimiters-nvim
    indent-blankline-nvim
    hologram-nvim
    go-nvim

  ];
}