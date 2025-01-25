{ pkgs, lib, ... }:
let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  #add_plugin => {plugin, packages} 
  add_neovim_plugins = plugin_list:
    pkgs.lib.fold
      (el: prev:
        {
          plugins =
            (if el ? "config" then
              [
                {
                  plugin = el.plugin;
                  config = el.config;
                }
              ] else [ el.plugin ]
            )
            ++ (if prev ? "plugins" then prev.plugins else [ ]);
          packages =
            (if el ? "depends_on" then el.depends_on else [ ]) ++ (if prev ? "packages" then prev.packages else [ ]);
        }
      )
      { }
      plugin_list;
in
let
  plugins = add_neovim_plugins (with pkgs.vimPlugins;[
    { plugin = (nvim-treesitter.withPlugins (_: nvim-treesitter.allGrammars)); }
    { plugin = plenary-nvim; }
    { plugin = telescope-nvim; }
    {
      plugin = lualine-nvim;
      config = toLuaFile ./plugins/lualine.lua;
    }
    {
      plugin = nvim-colorizer-lua;
      config = toLua ''
        require("colorizer").setup()
      '';
    }
    {

      plugin = neoscroll-nvim;
      config = toLua ''
        require("neoscroll").setup()
      '';
    }

    # {
    #   plugin = tabline-nvim;
    #   config = toLuaFile ./plugins/tabline.lua;
    # }
    {
      plugin = nord-nvim;
      config = toLua ''
        vim.cmd([[colorscheme nord]])
      '';
    }
    {
      plugin = nvim-lspconfig;
      config = toLuaFile ./plugins/lspconfig.lua;
      depends_on = with pkgs;[
        pyright
        nodePackages.typescript-language-server
        lua-language-server
        yaml-language-server
        nil
        terraform-ls
        rust-analyzer
        gopls
        cargo
        rustfmt
        go
        nixpkgs-fmt
      ];
    }
    /* {
         plugin = sg-nvimCustom;
         config = toLuaFile ./plugins/sg.lua;
             }*/
    { plugin = harpoon; }
    { plugin = undotree; }
    {
      plugin = vim-fugitive;
      depends_on = [ pkgs.git ];
    }
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
    { plugin = cmp-nvim-lsp; }
    { plugin = cmp-buffer; }
    { plugin = cmp-path; }
    { plugin = cmp-cmdline; }
    { plugin = cmp-vsnip; }
    { plugin = vim-vsnip; }
    { plugin = ansible-vim; }
    { plugin = vim-nix; }
    {
      plugin = nvim-web-devicons;
      config = toLuaFile ./plugins/nvim-web-devicons.lua;
      depends_on = [
        pkgs.fontconfig
        (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "VictorMono" ]; })
      ];
    }
    {
      plugin = neo-tree-nvim;
      config = toLuaFile ./plugins/neo-tree.lua;
    }
    { plugin = oil-nvim; }
    {
      plugin = which-key-nvim;
      config = toLuaFile ./plugins/which-key.lua;
    }
    { plugin = vim-floaterm; }
    { plugin = gitsigns-nvim; }
    { plugin = rainbow-delimiters-nvim; }
    { plugin = indent-blankline-nvim; }
    { plugin = hologram-nvim; }
    { plugin = go-nvim; }
    # {
    #   plugin = orgmode;
    #   config = toLua ''
    #       require('orgmode').setup({
    #       org_agenda_files = '~/orgfiles/**/*',
    #       org_default_notes_file = '~/orgfiles/refile.org',
    #     })
    #   '';
    # }
  ]);
in
{
  programs.neovim.plugins = plugins.plugins;
  programs.neovim.extraPackages = plugins.packages;
}
#rec {

/*  nixpkgs = {
  overlays = [
      (final: prev:
        {
          vimPlugins = prev.vimPlugins // {
            sg-nvimCustom = prev.vimUtils.buildVimPlugin {
              pname = "sg-nvimCustom";
              version = "v1.1.0";
              src = pkgs.fetchFromGitHub {
                owner = "sourcegraph";
                repo = "sg.nvim";
                rev = "8d7735bfb810d919806da1e1c4f839fbc6ecccfe";
                sha256 = "1wb6k3zyk5xa2s6v9x5kly9wv6hi4mpw9630fkyj0ixc4z67y4j9";
              };
              binSrc = pkgs.fetchzip {
                url = "https://github.com/sourcegraph/sg.nvim/releases/download/v1.1.0/${sgBaseName}.tar.xz";
                extension = "tar.xz";
                sha256 = "${sgSha256}";
              };
              postInstall = ''
                mkdir -p $out/dist
                cp -r $binSrc/* $out/dist
              '';
            };
          };
        })
  ];
  };
  */
