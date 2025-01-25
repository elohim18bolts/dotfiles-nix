-- Setup language servers.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.lua_ls.setup {
  settings = {
    runtime = { version = 'LuaJIT', },
    diagnostics = {
      globals = { 'vim', 'require' },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = vim.api.nvim_get_runtime_file("", true),
    },
    -- Do not send telemetry data containing a randomized but unique identifier
    telemetry = {
      enable = false,
    },
  },
}
lspconfig.yamlls.setup {
  on_attach = on_attach,
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/chart.json"] = "/*",
        ["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"] = "conf/**/*catalog*",
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
      }
    }
  }
}
lspconfig.nil_ls.setup {
  autostart = true,
  capabilities = capabilities,
  settings = {
    ['nil'] = {
      testSetting = 42,
      formatting = {
        command = { "nixpkgs-fmt" },
      },
    },
  }
}
lspconfig.svelte.setup {}
lspconfig.terraformls.setup {}
-------------------------Ruby Setup ----------------------------------
_timers = {}
local function setup_diagnostics(client, buffer)
  if require("vim.lsp.diagnostic")._enable then
    return
  end

  local diagnostic_handler = function()
    local params = vim.lsp.util.make_text_document_params(buffer)
    client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
      if err then
        local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
        vim.lsp.log.error(err_msg)
      end
      if not result then
        return
      end
      vim.lsp.diagnostic.on_publish_diagnostics(
        nil,
        vim.tbl_extend("keep", params, { diagnostics = result.items }),
        { client_id = client.id }
      )
    end)
  end

  diagnostic_handler() -- to request diagnostics on buffer when first attaching

  vim.api.nvim_buf_attach(buffer, false, {
    on_lines = function()
      if _timers[buffer] then
        vim.fn.timer_stop(_timers[buffer])
      end
      _timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
    end,
    on_detach = function()
      if _timers[buffer] then
        vim.fn.timer_stop(_timers[buffer])
      end
    end,
  })
end

require("lspconfig").ruby_lsp.setup({
  on_attach = function(client, buffer)
    setup_diagnostics(client, buffer)
  end,
})
-------------------------End Ruby Setup ----------------------------------
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  on_attach = function(client, bufnr)
    --Enable inlay hints and chnage its color
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#9DA9A0" })
  end,
  settings = {
    ['rust-analyzer'] = {},
  },
}
require 'lspconfig'.gopls.setup {}

vim.api.nvim_create_autocmd('BufWritePre', {
  --	pattern = { "*.hcl","*.tf", "*.tfvars" },
  buffer = buffer,
  callback = function()
    vim.lsp.buf.format { async = false }
  end
})
vim.api.nvim_create_autocmd('BufLeave', {

  buffer = buffer,
  command = "if &buftype == 'quickfix'|q|endif"
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>pd', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>pa', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>pw', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', function()
      vim.lsp.buf.references()
    end
    , opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
