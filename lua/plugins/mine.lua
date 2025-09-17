-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins

local Util = require("lazyvim.util")

-- local terminal_group = vim.api.nvim_create_augroup("TerminalGroup", { clear = true })
--
-- -- Define autocommands for the terminal
-- vim.api.nvim_create_autocmd("TermOpen", {
--   group = terminal_group,
--   pattern = "term://*",
--   callback = function()
--     -- Configure the terminal settings
--     vim.opt_local.number = false
--     vim.opt_local.relativenumber = false
--     -- vim.cmd("set nobuflisted")
--     vim.cmd("startinsert")
--   end,
-- })
--

return {
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "graphql",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "rcarriga/nvim-notify",
    enabled = false,
  },
  -- {
  --   "ramilito/kubectl.nvim",
  --   -- use a release tag to download pre-built binaries
  --   version = "2.*",
  --   -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  --   -- build = 'cargo build --release',
  --   dependencies = "saghen/blink.download",
  --   config = function()
  --     require("kubectl").setup()
  --   end,
  --   keys = {
  --     { "<leader>k", '<cmd>lua require("kubectl").toggle()<cr>' },
  --     { "7", "<Plug>(kubectl.view_nodes)", ft = "k8s_*" },
  --   },
  -- },
}
