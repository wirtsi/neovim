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
  {
    "nvim-lualine/lualine.nvim",
    optional = true,

    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          local status = require("ollama").status()

          if status == "IDLE" then
            return "󱙺" -- nf-md-robot-outline
          elseif status == "WORKING" then
            return "󰚩" -- nf-md-robot
          end
        end,
        cond = function()
          return package.loaded["ollama"] and require("ollama").status() ~= nil
        end,
      })
    end,
    {
      "olimorris/codecompanion.nvim",
      lazy = false,
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
      },
      config = function()
        require("codecompanion").setup({
          adapters = {
            llama3 = function()
              return require("codecompanion.adapters").extend("ollama", {
                name = "llama3", -- Give this adapter a different name to differentiate it from the default ollama adapter
                schema = {
                  model = {
                    default = "qwen2.5-coder:7b",
                  },
                  num_ctx = {
                    default = 4096,
                  },
                  num_predict = {
                    default = -1,
                  },
                },
              })
            end,
          },
          strategies = {
            chat = {
              adapter = "llama3",
            },
            inline = {
              adapter = "llama3",
            },
            agent = {
              adapter = "llama3",
            },
          },
          display = {
            chat = {
              window = {
                layout = "vertical", -- float|vertical|horizontal|buffer
              },
            },
          },
          -- opts = {
          --   ---@param adapter CodeCompanion.Adapter
          --   ---@return string
          --   system_prompt = function(adapter)
          --     if adapter.schema.model.default == "llama3.1:latest" then
          --       return "My custom system prompt"
          --     end
          --     return "My default system prompt"
          --   end,
          -- },
        })
      end,
      init = function() end,
    },
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<c-y>]],
      insert_mapping = true,
      terminal_mapping = true,
      direction = "vertical",
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.2
        end
      end,
    },
  },
  {
    "wnkz/monoglow.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
}
