{ pkgs, lib, ... }:
let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  sgBaseName =
    if pkgs.stdenv.isAarch64 then
      (lib.optionalString pkgs.stdenv.isLinux "sg-aarch64-unknown-linux-gnu") +
      (lib.optionalString pkgs.stdenv.isDarwin "sg-aarch64-apple-darwin")
    else
      (lib.optionalString pkgs.stdenv.isLinux "sg-x86_64-unknown-linux-gnu") +
      (lib.optionalString pkgs.stdenv.isDarwin "sg-x86_64-apple-darwin");
  sgSha256 =
    if pkgs.stdenv.isAarch64 then
      (lib.optionalString pkgs.stdenv.isLinux "XhLsefsxdPlvDBj9ftap0qGak+YiNLmER12ttyHT+f0=") +
      (lib.optionalString pkgs.stdenv.isDarwin "qt3HFRdj30kJ2HxS0rY78BLFEGP958lAyVWLXclz8to=")
    else
      (lib.optionalString pkgs.stdenv.isLinux "JdwQNtuK7wFXFXFsMFyzPaLab5u+endId4frzimJhfg=") +
      (lib.optionalString pkgs.stdenv.isDarwin "sg-x86_64-apple-darwin");
in
{

  nixpkgs = {
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
  programs.neovim.plugins = with pkgs.vimPlugins; [
    (
      nvim-treesitter.withPlugins (_: nvim-treesitter.allGrammars)
    )
    plenary-nvim
    telescope-nvim

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
    }
    {
      plugin = sg-nvimCustom;
      config = toLuaFile ./plugins/sg.lua;
    }
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
    cmp-nvim-lsp
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
    # {
    #   plugin = orgmode;
    #   config = toLua ''
    #       require('orgmode').setup({
    #       org_agenda_files = '~/orgfiles/**/*',
    #       org_default_notes_file = '~/orgfiles/refile.org',
    #     })
    #   '';
    # }
  ];
}
