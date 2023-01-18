local config = function()
  require('mason').setup()

  local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
      options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  end

  -- local handlers = {
  --   -- ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover),
  --   -- ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help),
  --   ['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  --     virtual_text = true,
  --     signs = true,
  --     underline = true,
  --     update_in_insert = false,
  --
  --   })
  -- }

  -- format on save
  vim.cmd([[augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | lua vim.lsp.buf.format({async = false})
  augroup END]])

  -- replace the default lsp diagnostic letters with prettier symbols
  --
  vim.fn.sign_define("DiagnosticSignError", { text = "✗", texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
  vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
  vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

  local opts = { noremap = true, silent = true }

  local function on_attach(client, bufnr)
    map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    map('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
    map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- map('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    map('n', '<space>D', '<cmd>Telescope lsp_type_definitions<CR><CR>', opts)
    map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    map('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
    map('n', 'gE', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    map('n', 'ge', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    map('n', '<space>e', '<cmd>lua require\'telescope.builtin\'.diagnostics({bufnr =  0, previewer = false})<CR>',
      opts)
    map('n', '<space>E', '<cmd>lua require\'telescope.builtin\'.diagnostics({previewer = false})<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.documentFormattingProvider then
      map("n", "<space>fm", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts)
    elseif client.server_capabilities.documentRangeFormattingProvider then
      map("n", "<space>fm", "<cmd>lua vim.lsp.buf.range({async = true})<CR>", opts)
    end
  end

  local null_ls = require("null-ls")
  null_ls.setup({
    on_attach = on_attach,
    root_dir = function()
      return vim.loop.cwd()
    end,
    sources = {
      null_ls.builtins.diagnostics.eslint_d, -- eslint or eslint_d
      null_ls.builtins.code_actions.eslint_d, -- eslint or eslint_d
      null_ls.builtins.formatting.prettierd -- prettier, eslint, eslint_d, or prettierd
    },
  })

  local mason_lspconfig = require("mason-lspconfig")
  local lspconfig = require 'lspconfig'
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  mason_lspconfig.setup_handlers({
    function(server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup({
        root_dir = function()
          return vim.loop.cwd()
        end,
        -- handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities
      })
    end,
    ["tsserver"] = function()
      lspconfig.tsserver.setup({
        init_options = require("nvim-lsp-ts-utils").init_options,
        capabilities = capabilities,
        on_attach = function(client)
          local ts_utils = require("nvim-lsp-ts-utils")
          ts_utils.setup({
            update_imports_on_move = true,
            require_confirmation_on_move = false,
            auto_inlay_hints = true,
            inlay_hints_highlight = "Comment",
            -- eslint_bin = "eslint_d",
            eslint_enable_diagnostics = false,
            eslint_enable_code_actions = true,
            enable_formatting = false,
            -- formatter = "eslint_d",
          })
          ts_utils.setup_client(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          map("n", "gs", ":TSLspOrganize<CR>", opts)
          map("n", "<space>rnf", ":TSLspRenameFile<CR>", opts)
          map("n", "go", ":TSLspImportAll<CR>", opts)
        end
      })

    end,
    ["sumneko_lua"] = function()
      lspconfig.sumneko_lua.setup {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
              }
            },
            telemetry = {
              enable = false
            }
          }

        }
      }
    end,

  })

  vim.diagnostic.config { virtual_text = true }
  require("cmp-config")
end

return config
