
    -- Mappings.

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {source="always"})]]

vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

-- LSP settings (for overriding per client)
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help),
  ['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
  })
}

-- replace the default lsp diagnostic letters with prettier symbols
--
vim.fn.sign_define("DiagnosticSignError", { text = "✗", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

local function on_attach(client, bufnr)

    local opts = {noremap = true, silent = true}

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    map('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
    map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- map('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    map('n', '<space>D', '<cmd>Telescope lsp_type_definitions<CR><CR>', opts)
    -- map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    map('n', '<space>ca', '<cmd>Telescope lsp_code_actions<CR>', opts)
    map('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
    map('n', 'gE', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    map('n', 'ge', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    map('n', '<space>e', '<cmd>lua require\'telescope.builtin\'.lsp_document_diagnostics({previewer = false})<CR>', opts)
    map('n', '<space>E', '<cmd>lua require\'telescope.builtin\'.lsp_workspace_diagnostics({previewer = false})<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        map("n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        map("n", "<space>fm", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    if client.name == "typescript" then
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      local ts_utils = require("nvim-lsp-ts-utils")
      ts_utils.setup({
          update_imports_on_move = true,
          require_confirmation_on_move = true,
          auto_inlay_hints = true,
          inlay_hints_highlight = "Comment",
          eslint_bin = "eslint_d",
          eslint_enable_diagnostics = true,
          eslint_enable_code_actions = true,
          enable_formatting = true,
          formatter = "eslint_d",
      })
      ts_utils.setup_client(client)
      map("n", "gs", ":TSLspOrganize<CR>", opts)
      map("n", "<space>rn", ":TSLspRenameFile<CR>", opts)
      map("n", "go", ":TSLspImportAll<CR>", opts)
    end
end



-- lspInstall + lspconfig stuff

local function setup_servers()
  local lsp_installer = require("nvim-lsp-installer")

    local null_ls = require("null-ls")
    null_ls.config({
      debug = true,
      sources = {
        null_ls.builtins.diagnostics.eslint_d, -- eslint or eslint_d
        null_ls.builtins.code_actions.eslint_d, -- eslint or eslint_d
        null_ls.builtins.formatting.eslint_d -- prettier, eslint, eslint_d, or prettierd
      },
    })

  local lspconf = require("lspconfig")
  lspconf["null-ls"].setup({ on_attach = on_attach })

  lsp_installer.on_server_ready(function(server)
      lspconf[server.name].setup {
          root_dir = function()
              return vim.loop.cwd()
          end,
          handlers = handlers,
          on_attach = on_attach,
          init_options = server.name == "typescript" and require("nvim-lsp-ts-utils").init_options,
          settings = {
              Lua = {
                  diagnostics = {
                      globals = {"vim"}
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
  end)
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
-- require "lspinstall".post_install_hook = function()
--     setup_servers() -- reload installed servers
--     vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
-- end

